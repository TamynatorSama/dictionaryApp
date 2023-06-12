import 'package:dictionary_app/src/model.dart';
import 'package:dictionary_app/src/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

WordNotifier notifier = WordNotifier();

class WordNotifier with ChangeNotifier {
  bool gettingWord = false;
  Map<String, dynamic>? errors;
  static AudioPlayer player = AudioPlayer();
  Word? presentWord;

  playAudio(String audio) async {
    if (player.state == PlayerState.playing) return;
    await player.play(UrlSource(audio));
  }

  getWord(String word) async {
    gettingWord = true;
    notifyListeners();
    var response = await DictionaryRequest.getWords(word);
    if (response["status"]) {
      errors = null;
      notifyListeners();
      presentWord = response["result"];
    } else {
      errors = response;
    }
    gettingWord = false;
    notifyListeners();
  }
}
