import 'dart:convert';

class Document {
  final Map<String, Object?> _json;

  Document() : _json = jsonDecode(documentJson);

  // _json is a Map type.
  // _json contains a metadata key.
  // _json is not null.
  // _json['metadata'] is also a Map type.
  // _json['metadata'] contains the keys title and modified.
  // title and localModified are strings and aren't null.
  (String, {DateTime modified}) getMetadata() {
    if (_json
        case {
          'metadata': {
            'title': String title,
            'modified': String localModified,
          }
        }) {
      return (title, modified: DateTime.parse(localModified));
    } else {
      throw const FormatException('Unexpected JSON');
    }
  }

  List<Block> getBlocks() {
    if (_json case {'blocks': List blocksJson}) {
      return <Block>[for (var blockJson in blocksJson) Block.fromJson(blockJson)];
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }

// The JSON contains the data structure you expect: if (_json.containsKey('metadata'))
// The data has the type you expect: if (metadataJson is Map)
// That the data is not null, which is implicitly confirmed in the previous check.
//
// (String, {DateTime modified}) getMetadata() {
//   if (_json.containsKey('metadata')) {
//     var metadataJson = _json['metadata'];
//     if (metadataJson is Map) {
//       var title = metadataJson['title'] as String;
//       var localModified = DateTime.parse(metadataJson['modified'] as String);
//       return (title, modified: localModified);
//     }
//   }
//   throw const FormatException('Unexpected JSON');
// }
}

sealed class Block {
  Block();

  factory Block.fromJson(Map<String, Object?> json) {
    return switch (json) {
      {'type': 'h1', 'text': String text} => HeaderBlock(text),
      {'type': 'p', 'text': String text} => ParagraphBlock(text),
      {'type': 'checkbox', 'text': String text, 'checked': bool checked} =>
          CheckboxBlock(text, checked),
      _ => throw const FormatException('Unexpected JSON format'),
    };
  }
}

class HeaderBlock extends Block {
  final String text;

  HeaderBlock(this.text);
}

class ParagraphBlock extends Block {
  final String text;

  ParagraphBlock(this.text);
}

class CheckboxBlock extends Block {
  final String text;
  final bool isChecked;

  CheckboxBlock(this.text, this.isChecked);
}

const documentJson = '''
{
  "metadata": {
    "title": "My Document",
    "modified": "2023-05-10"
  },
  "blocks": [
    {
      "type": "h1",
      "text": "Chapter 1"
    },
    {
      "type": "p",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "type": "checkbox",
      "checked": true,
      "text": "Learn Dart 3"
    }
  ]
}
''';
