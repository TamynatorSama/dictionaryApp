class Word {
  final String word;
  final String phonetic;
  final List<Phonetics> phonetics;
  final List<Meaning> meaning;
  final List<String> source;

  Word(
      {required this.word,
      required this.phonetic,
      required this.phonetics,
      required this.meaning,
      required this.source
      });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json["word"],
      phonetic: json["phonetic"]??"",
      source: (json["sourceUrls"]as List).map((e)=>e.toString()).toList(),
      phonetics: (json["phonetics"] as List).map((e) => Phonetics.fromJson(e)).toList(),
      meaning: (json["meanings"] as List).map((e) => Meaning.fromJson(e)).toList()
      );
  }
}

class Phonetics {
  final String text;
  final String audio;
  final String sourceUrl;

  Phonetics({required this.text, required this.audio, required this.sourceUrl});

  factory Phonetics.fromJson(Map<String, dynamic> json) => Phonetics(
      text: json["text"]??"", audio: json["audio"]??"", sourceUrl: json["sourceUrl"]??"");
}

class Meaning {
  final String partOfSpeech;
  final List<Definition>definitions;
  final List<String> synonyms;
  final List<String> antonyms;
  Meaning(
      {
      required this.antonyms,
      required this.definitions,
      required this.partOfSpeech,
      required this.synonyms
      });
  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      antonyms: (json["antonyms"] as List).map((e) => e.toString()).toList(),
      definitions: (json["definitions"] as List).map((e) => Definition.fromJson(e)).toList(),
      partOfSpeech: json["partOfSpeech"]??"",
      synonyms: (json["synonyms"] as List).map((e) => e.toString()).toList(),
      );
  }
}

class Definition{
  final String definition;
  final String? example;

  Definition({required this.definition,this.example});

  factory Definition.fromJson(Map<String,dynamic> json)=>Definition(definition: json["definition"], example: json["example"]);

  
}