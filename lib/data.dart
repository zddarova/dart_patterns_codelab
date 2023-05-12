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
