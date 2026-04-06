import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:telephony_context/telephony_context.dart';

void main() {
  runApp(const TelephonyExampleApp());
}

class TelephonyExampleApp extends StatelessWidget {
  const TelephonyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'telephony_context example',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _output = 'Tap the button to load telephony context.';
  bool _loading = false;

  Future<void> _load() async {
    setState(() {
      _loading = true;
    });
    final TelephonyContext ctx = await TelephonyContextPlugin.getContext();
    final Map<String, dynamic> json = ctx.toJsonWithCollectedAt();
    if (!mounted) return;
    setState(() {
      _loading = false;
      _output = const JsonEncoder.withIndent('  ').convert(json);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('telephony_context'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FilledButton(
              onPressed: _loading ? null : _load,
              child: Text(_loading ? 'Loading…' : 'Load telephony context'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: SelectableText(_output),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
