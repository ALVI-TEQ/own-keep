import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vault_domain/vault_domain.dart';
import 'package:vault_ingestion/vault_ingestion.dart';

import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';

class CreateContactScreen extends ConsumerStatefulWidget {
  const CreateContactScreen({super.key});

  @override
  ConsumerState<CreateContactScreen> createState() =>
      _CreateContactScreenState();
}

class _CreateContactScreenState extends ConsumerState<CreateContactScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    setState(() => _saving = true);
    final card =
        'BEGIN:VCARD\r\nVERSION:3.0\r\nFN:${_escape(name)}\r\nTEL:${_escape(_phone.text.trim())}\r\nEMAIL:${_escape(_email.text.trim())}\r\nEND:VCARD\r\n';
    final bytes = utf8.encode(card);
    await ref
        .read(ingestionControllerProvider)
        ?.importCandidate(
          IngestionCandidate(
            logicalFilename:
                '${name.replaceAll(RegExp(r'[^A-Za-z0-9 _-]'), '')}.vcf',
            mimeType: 'text/vcard',
            length: bytes.length,
            source: DocumentImportSource.filePicker,
            openRead: () => Stream.value(bytes),
          ),
        );
    ref.invalidate(allDocumentsProvider);
    ref.invalidate(recentDocumentsProvider);
    if (mounted) Navigator.of(context).pop(true);
  }

  String _escape(String value) => value
      .replaceAll('\\', '\\\\')
      .replaceAll(';', r'\;')
      .replaceAll(',', r'\,')
      .replaceAll('\n', r'\n');

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('New Contact')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        TextField(
          controller: _name,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Name *',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _phone,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Phone',
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 28),
        FilledButton.icon(
          onPressed: _saving ? null : _save,
          icon: const Icon(Icons.lock),
          label: Text(_saving ? 'Saving…' : 'Save encrypted contact'),
        ),
      ],
    ),
  );
}
