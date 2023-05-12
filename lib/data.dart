import 'dart:convert';

class Document {
  final Map<String, Object?> _json;
  Document() : _json = jsonDecode(documentJson);

  (String, {DateTime modified}) getMetadata() {
    if (_json.containsKey('metadata')) {
      var metadataJson = _json['metadata'];
      if (metadataJson is Map) {
        var title = metadataJson['title'] as String;
        var localModified = DateTime.parse(metadataJson['modified'] as String);
        return (title, modified: localModified);
      }
    }
    throw const FormatException('Unexpected JSON');
  }
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
      "checked": false,
      "text": "Learn Dart 3"
    }
  ]
}
''';
