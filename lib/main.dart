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
    var (title, :modified) = document.getMetadata();
    var formattedModifiedDate = formatDate(modified); // New
    var blocks = document.getBlocks();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          // New
          Text('Last modified: $formattedModifiedDate'), // New
          Expanded(
            child: ListView.builder(
              itemCount: blocks.length,
              itemBuilder: (context, index) {
                return BlockWidget(block: blocks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BlockWidget extends StatelessWidget {
  final Block block;

  const BlockWidget({
    required this.block,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: switch (block) {
        HeaderBlock(:var text) => Text(
            text,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ParagraphBlock(:var text) => Text(text),
        CheckboxBlock(:var text, :var isChecked) => Row(
            children: [
              Checkbox(value: isChecked, onChanged: (_) {}),
              Text(text),
            ],
          ),
      },
    );
  }
}

// class BlockWidget extends StatelessWidget {
//   final Block block;
//
//   const BlockWidget({
//     required this.block,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     TextStyle? textStyle;
//
//     textStyle = switch (block.type) {
//       'h1' => Theme.of(context).textTheme.displayMedium,
//       'p' || 'checkbox' => Theme.of(context).textTheme.bodyMedium,
//       _ => Theme.of(context).textTheme.bodySmall
//     };
//
//     // switch (block.type) {
//     //   case 'h1':
//     //     textStyle = Theme.of(context).textTheme.displayMedium;
//     //   case 'p' || 'checkbox':
//     //     textStyle = Theme.of(context).textTheme.bodyMedium;
//     //   case _:
//     //     textStyle = Theme.of(context).textTheme.bodySmall;
//     // }
//
//     return Container(
//       margin: const EdgeInsets.all(8),
//       child: Text(
//         block.text,
//         style: textStyle,
//       ),
//     );
//   }
// }

String formatDate(DateTime dateTime) {
  var today = DateTime.now();
  var difference = dateTime.difference(today);

  // Each case of the switch expression is using an object pattern that matches
  // by calling getters on the object's properties inDays and isNegative.
  // The syntax looks like it might be constructing a Duration object,
  // but it's actually accessing fields on the difference object.

  // about when:
  // If the guard clause evaluates to false, the entire pattern is refuted, and execution proceeds to the next case

  return switch (difference) {
    Duration(inDays: 0) => 'today',
    Duration(inDays: 1) => 'tomorrow',
    Duration(inDays: -1) => 'yesterday',
    Duration(inDays: var days) when days > 7 => '${days ~/ 7} weeks from now', // New
    Duration(inDays: var days)
        when days < -7 =>
      '${days.abs() ~/ 7} weeks ago', // New
    Duration(inDays: var days, isNegative: true) => '${days.abs()} days ago',
    Duration(inDays: var days) => '$days days from now',
  };
}
