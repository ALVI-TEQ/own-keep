import Flutter
import AVFoundation
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var voiceRecorder: AVAudioRecorder?
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let voiceChannel = FlutterMethodChannel(
      name: "com.alviteq.ownkeep/voice_recorder",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    voiceChannel.setMethodCallHandler { [weak self] call, result in
      guard let self else { return }
      switch call.method {
      case "startRecording":
        guard
          let arguments = call.arguments as? [String: Any],
          let path = arguments["path"] as? String,
          !path.isEmpty
        else {
          result(FlutterError(code: "INVALID_PATH", message: "Recording path is unavailable", details: nil))
          return
        }
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
          DispatchQueue.main.async {
            guard granted else {
              result(FlutterError(code: "MICROPHONE_DENIED", message: "Microphone permission was denied", details: nil))
              return
            }
            self.startVoiceRecording(path: path, result: result)
          }
        }
      case "stopRecording":
        self.stopVoiceRecording(result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  private func startVoiceRecording(path: String, result: FlutterResult) {
    guard voiceRecorder == nil else {
      result(FlutterError(code: "RECORDING_BUSY", message: "A recording is already active", details: nil))
      return
    }
    do {
      let session = AVAudioSession.sharedInstance()
      try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
      try session.setActive(true)
      let settings: [String: Any] = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 44_100,
        AVNumberOfChannelsKey: 1,
        AVEncoderBitRateKey: 128_000,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
      ]
      let recorder = try AVAudioRecorder(url: URL(fileURLWithPath: path), settings: settings)
      recorder.prepareToRecord()
      guard recorder.record() else {
        throw NSError(domain: "OwnKeepVoiceRecorder", code: 1)
      }
      voiceRecorder = recorder
      result(true)
    } catch {
      voiceRecorder = nil
      result(FlutterError(code: "RECORDING_START_FAILED", message: "Voice recording could not start", details: nil))
    }
  }

  private func stopVoiceRecording(result: FlutterResult) {
    guard let recorder = voiceRecorder else {
      result(FlutterError(code: "NOT_RECORDING", message: "No voice recording is active", details: nil))
      return
    }
    let path = recorder.url.path
    recorder.stop()
    voiceRecorder = nil
    try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    result(path)
  }
}
