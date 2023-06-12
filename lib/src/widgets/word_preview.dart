import 'package:dictionary_app/word_notifier.dart';
import 'package:flutter/material.dart';

class WordPreview extends StatelessWidget {
  final String wordDisplay;
  final String phonetic;
  final String audio;
  const WordPreview(
      {super.key,
      required this.wordDisplay,
      required this.phonetic,
      required this.audio});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              wordDisplay,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              phonetic,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 20, color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        if (audio.isNotEmpty)
          GestureDetector(
            onTap: () {
              notifier.playAudio(audio);
            },
            child: CircleAvatar(
              radius: (MediaQuery.of(context).size.width * 0.076).clamp(24, 28),
              backgroundColor: Theme.of(context).shadowColor,
              child: Icon(
                Icons.play_arrow,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ),
          )
      ],
    );
  }
}
