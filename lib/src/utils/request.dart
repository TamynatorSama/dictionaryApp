import 'dart:convert';
import 'dart:io';

import 'package:dictionary_app/src/model.dart';
import 'package:http/http.dart' as http;

class DictionaryRequest {
  static Future<Map<String, dynamic>> getWords(String word) async {
    String url = "https://api.dictionaryapi.dev/api/v2/entries/en/$word";

    try {
      var response = await http.get(Uri.parse(url));
      var usable = jsonDecode(response.body);

      if (response.statusCode == 404) {
        return ({
          "status": false,
          "result":
              "Sorry pal, we couldn't find definitions for the word you were looking for."
        });
      }

      return ({
        "status": true,
        "result": Word.fromJson((usable as List).first)
      });
    } on SocketException {
      return ({"status": false, "result": "Opss no internet connection"});
    } catch (e) {
      return ({"status": false, "result": 'unable to process request'});
    }
  }
}
