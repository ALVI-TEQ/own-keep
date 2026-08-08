package com.alviteq.ownkeep

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.media.MediaRecorder
import android.net.Uri
import androidx.activity.result.IntentSenderRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.latin.TextRecognizerOptions
import com.google.mlkit.vision.documentscanner.GmsDocumentScannerOptions
import com.google.mlkit.vision.documentscanner.GmsDocumentScanning
import com.google.mlkit.vision.documentscanner.GmsDocumentScanningResult
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterFragmentActivity() {
    private var pendingExportResult: MethodChannel.Result? = null
    private var pendingExportSource: File? = null
    private var pendingScanResult: MethodChannel.Result? = null
    private var voiceRecorder: MediaRecorder? = null
    private var voiceRecordingPath: String? = null
    private var pendingVoiceStartResult: MethodChannel.Result? = null
    private var pendingVoiceStartPath: String? = null

    private val requestMicrophonePermission = registerForActivityResult(
        ActivityResultContracts.RequestPermission(),
    ) { granted ->
        val result = pendingVoiceStartResult
        val path = pendingVoiceStartPath
        pendingVoiceStartResult = null
        pendingVoiceStartPath = null
        if (result == null) return@registerForActivityResult
        if (!granted || path == null) {
            result.error("MICROPHONE_DENIED", "Microphone permission was denied", null)
            return@registerForActivityResult
        }
        startVoiceRecording(path, result)
    }

    private val documentScanner = GmsDocumentScanning.getClient(
        GmsDocumentScannerOptions.Builder()
            .setGalleryImportAllowed(true)
            .setPageLimit(20)
            .setResultFormats(GmsDocumentScannerOptions.RESULT_FORMAT_PDF)
            .setScannerMode(GmsDocumentScannerOptions.SCANNER_MODE_FULL)
            .build(),
    )

    private val scanDocument = registerForActivityResult(
        ActivityResultContracts.StartIntentSenderForResult(),
    ) { activityResult ->
        val channelResult = pendingScanResult
        pendingScanResult = null
        if (channelResult == null) return@registerForActivityResult
        if (activityResult.resultCode != Activity.RESULT_OK) {
            channelResult.success(null)
            return@registerForActivityResult
        }
        val scan = GmsDocumentScanningResult.fromActivityResultIntent(activityResult.data)
        val pdfUri = scan?.pdf?.uri
        if (pdfUri == null) {
            channelResult.error("SCAN_EMPTY", "The scanner did not return a PDF", null)
            return@registerForActivityResult
        }
        try {
            val destination = File.createTempFile("ownkeep-scan-", ".pdf", cacheDir)
            contentResolver.openInputStream(pdfUri)?.use { input ->
                destination.outputStream().use { output -> input.copyTo(output) }
            } ?: error("Could not open the scanned PDF")
            channelResult.success(destination.absolutePath)
        } catch (error: Exception) {
            channelResult.error("SCAN_COPY_FAILED", "The scanned PDF could not be prepared", null)
        }
    }

    private val createDocument = registerForActivityResult(
        ActivityResultContracts.StartActivityForResult(),
    ) { activityResult ->
        val result = pendingExportResult
        val source = pendingExportSource
        pendingExportResult = null
        pendingExportSource = null
        if (result == null) return@registerForActivityResult
        val destination = activityResult.data?.data
        if (activityResult.resultCode != Activity.RESULT_OK || destination == null || source == null) {
            result.success(false)
            return@registerForActivityResult
        }
        try {
            contentResolver.openOutputStream(destination, "w")?.use { output ->
                source.inputStream().use { input -> input.copyTo(output) }
            } ?: error("Could not open the selected destination")
            result.success(true)
        } catch (error: Exception) {
            result.error("DOCUMENT_EXPORT_FAILED", "The copy could not be saved", null)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.alviteq.ownkeep/voice_recorder",
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "startRecording" -> {
                    if (voiceRecorder != null || pendingVoiceStartResult != null) {
                        result.error("RECORDING_BUSY", "A recording is already active", null)
                        return@setMethodCallHandler
                    }
                    val path = call.argument<String>("path")
                    if (path.isNullOrBlank()) {
                        result.error("INVALID_PATH", "Recording path is unavailable", null)
                        return@setMethodCallHandler
                    }
                    if (ContextCompat.checkSelfPermission(
                            this,
                            Manifest.permission.RECORD_AUDIO,
                        ) == PackageManager.PERMISSION_GRANTED
                    ) {
                        startVoiceRecording(path, result)
                    } else {
                        pendingVoiceStartResult = result
                        pendingVoiceStartPath = path
                        requestMicrophonePermission.launch(Manifest.permission.RECORD_AUDIO)
                    }
                }
                "stopRecording" -> stopVoiceRecording(result)
                else -> result.notImplemented()
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.alviteq.ownkeep/document_scanner",
        ).setMethodCallHandler { call, result ->
            if (call.method != "scanDocument") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            if (pendingScanResult != null) {
                result.error("SCAN_BUSY", "Another scan is active", null)
                return@setMethodCallHandler
            }
            pendingScanResult = result
            documentScanner.getStartScanIntent(this)
                .addOnSuccessListener { intentSender ->
                    scanDocument.launch(IntentSenderRequest.Builder(intentSender).build())
                }
                .addOnFailureListener {
                    pendingScanResult = null
                    result.error(
                        "SCANNER_UNAVAILABLE",
                        "Google Play services document scanner is unavailable",
                        null,
                    )
                }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "app.citizenvault/ocr",
        ).setMethodCallHandler { call, result ->
            if (call.method != "recognizeText") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            val path = call.argument<String>("path")
            if (path.isNullOrBlank() || !File(path).isFile) {
                result.error("INVALID_SOURCE", "OCR source is unavailable", null)
                return@setMethodCallHandler
            }
            val recognizer = TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS)
            val image = try {
                InputImage.fromFilePath(this, Uri.fromFile(File(path)))
            } catch (error: Exception) {
                recognizer.close()
                result.error("INVALID_SOURCE", "OCR source is invalid", null)
                return@setMethodCallHandler
            }
            recognizer.process(image)
                .addOnSuccessListener { text -> result.success(text.text) }
                .addOnFailureListener {
                    result.error("OCR_FAILED", "Text recognition failed", null)
                }
                .addOnCompleteListener { recognizer.close() }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "citizen_vault/files",
        ).setMethodCallHandler { call, result ->
            if (call.method != "exportDocument") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            if (pendingExportResult != null) {
                result.error("EXPORT_BUSY", "Another export is active", null)
                return@setMethodCallHandler
            }
            val source = call.argument<String>("sourcePath")?.let(::File)
            val suggestedName = call.argument<String>("suggestedName")
            val mimeType = call.argument<String>("mimeType") ?: "application/octet-stream"
            if (source == null || !source.isFile || suggestedName.isNullOrBlank()) {
                result.error("INVALID_SOURCE", "Export source is unavailable", null)
                return@setMethodCallHandler
            }
            pendingExportResult = result
            pendingExportSource = source
            createDocument.launch(
                Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
                    addCategory(Intent.CATEGORY_OPENABLE)
                    type = mimeType
                    putExtra(Intent.EXTRA_TITLE, suggestedName)
                },
            )
        }
    }

    @Suppress("DEPRECATION")
    private fun startVoiceRecording(path: String, result: MethodChannel.Result) {
        try {
            val destination = File(path)
            destination.parentFile?.mkdirs()
            val recorder = MediaRecorder().apply {
                setAudioSource(MediaRecorder.AudioSource.MIC)
                setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
                setAudioEncoder(MediaRecorder.AudioEncoder.AAC)
                setAudioEncodingBitRate(128_000)
                setAudioSamplingRate(44_100)
                setOutputFile(destination.absolutePath)
                prepare()
                start()
            }
            voiceRecorder = recorder
            voiceRecordingPath = destination.absolutePath
            result.success(true)
        } catch (error: Exception) {
            voiceRecorder?.release()
            voiceRecorder = null
            voiceRecordingPath = null
            result.error("RECORDING_START_FAILED", "Voice recording could not start", null)
        }
    }

    private fun stopVoiceRecording(result: MethodChannel.Result) {
        val recorder = voiceRecorder
        val path = voiceRecordingPath
        voiceRecorder = null
        voiceRecordingPath = null
        if (recorder == null || path == null) {
            result.error("NOT_RECORDING", "No voice recording is active", null)
            return
        }
        try {
            recorder.stop()
            recorder.release()
            result.success(path)
        } catch (error: Exception) {
            recorder.release()
            File(path).delete()
            result.error("RECORDING_STOP_FAILED", "Voice recording could not be completed", null)
        }
    }

    override fun onDestroy() {
        try {
            voiceRecorder?.release()
        } catch (_: Exception) {
            // Nothing sensitive is retained when Android tears down recording.
        }
        voiceRecorder = null
        voiceRecordingPath?.let { File(it).delete() }
        voiceRecordingPath = null
        super.onDestroy()
    }
}
