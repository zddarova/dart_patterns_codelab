import 'package:flutter/material.dart';

import 'data.dart';

void main() {
  runApp(const DocumentApp());
}

class DocumentApp extends StatelessWidget {
  const DocumentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: DocumentScreen(
        document: Document(),
      ),
    );
  }
}

class DocumentScreen extends StatelessWidget {
  final Document document;

  const DocumentScreen({
    required this.document,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var (title, :modified) = document.getMetadata(); // New
    // var (title, modified: localModified) = document.getMetadata(); // New

    return Scaffold(
      appBar: AppBar(
        title: Text(title), // New
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'Last modified $modified', // New
            ),
          ),
        ],
      ),
    );
  }
}
