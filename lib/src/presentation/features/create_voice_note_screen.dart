import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:vault_domain/vault_domain.dart';
import 'package:vault_ingestion/vault_ingestion.dart';

import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';
import '../../platform/trusted_external_activity.dart';

class CreateVoiceNoteScreen extends ConsumerStatefulWidget {
  const CreateVoiceNoteScreen({super.key});

  @override
  ConsumerState<CreateVoiceNoteScreen> createState() =>
      _CreateVoiceNoteScreenState();
}

class _CreateVoiceNoteScreenState extends ConsumerState<CreateVoiceNoteScreen> {
  static const _recorder = MethodChannel('com.alviteq.ownkeep/voice_recorder');
  bool _recording = false;
  bool _saving = false;
  String? _path;
  String? _error;

  @override
  void dispose() {
    if (_recording) {
      unawaited(_discardActiveRecording());
    } else if (_path case final path?) {
      final file = File(path);
      if (file.existsSync()) file.deleteSync();
    }
    super.dispose();
  }

  Future<void> _discardActiveRecording() async {
    try {
      final path = await _recorder.invokeMethod<String>('stopRecording');
      if (path != null) {
        final file = File(path);
        if (file.existsSync()) await file.delete();
      }
    } on Object {
      // Native teardown also releases the recorder on process destruction.
    }
  }

  Future<void> _toggleRecording() async {
    if (_recording) {
      final path = await _recorder.invokeMethod<String>('stopRecording');
      if (mounted) {
        setState(() {
          _recording = false;
          _path = path;
        });
      }
      return;
    }
    if (_path case final previousPath?) {
      final previous = File(previousPath);
      if (previous.existsSync()) await previous.delete();
    }
    final directory = await getTemporaryDirectory();
    final path =
        '${directory.path}/voice-${DateTime.now().millisecondsSinceEpoch}.m4a';
    try {
      await TrustedExternalActivity.run(
        () => _recorder.invokeMethod<bool>('startRecording', <String, Object>{
          'path': path,
        }),
      );
      if (mounted) {
        setState(() {
          _recording = true;
          _path = null;
          _error = null;
        });
      }
    } on PlatformException catch (error) {
      if (mounted) {
        setState(
          () => _error = error.code == 'MICROPHONE_DENIED'
              ? 'Microphone permission is required.'
              : 'Voice recording could not start.',
        );
      }
    }
  }

  Future<void> _save() async {
    final path = _path;
    if (path == null) return;
    setState(() => _saving = true);
    final file = File(path);
    try {
      await ref
          .read(ingestionControllerProvider)
          ?.importCandidate(
            IngestionCandidate(
              logicalFilename:
                  'Voice note-${DateTime.now().millisecondsSinceEpoch}.m4a',
              mimeType: 'audio/mp4',
              length: await file.length(),
              source: DocumentImportSource.filePicker,
              openRead: file.openRead,
            ),
          );
      ref.invalidate(allDocumentsProvider);
      ref.invalidate(recentDocumentsProvider);
      if (mounted) Navigator.of(context).pop(true);
    } finally {
      if (file.existsSync()) {
        file.deleteSync();
      }
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Voice Note')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_recording ? Icons.mic : Icons.mic_none, size: 88),
            const SizedBox(height: 16),
            Text(
              _recording
                  ? 'Recording… tap Stop when finished.'
                  : _path == null
                  ? 'Record an encrypted voice note.'
                  : 'Recording ready to save.',
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _saving ? null : _toggleRecording,
              icon: Icon(_recording ? Icons.stop : Icons.mic),
              label: Text(
                _recording
                    ? 'Stop'
                    : _path == null
                    ? 'Record'
                    : 'Record again',
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _path == null || _saving || _recording ? null : _save,
              icon: const Icon(Icons.lock),
              label: const Text('Save to OwnKeep'),
            ),
          ],
        ),
      ),
    ),
  );
}
