import 'package:dictionary_app/src/model.dart';
import 'package:dictionary_app/src/settings/custom_theme.dart';
import 'package:dictionary_app/src/widgets/animation_feedback.dart';
import 'package:dictionary_app/src/widgets/custom_input_field.dart';
import 'package:dictionary_app/src/widgets/toggle.dart';
import 'package:dictionary_app/src/widgets/word_preview.dart';
import 'package:dictionary_app/word_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: MediaQuery.of(context).padding.vertical),
          child: ListenableBuilder(
              listenable: notifier,
              builder: (context, value) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/images/logo.svg"),
                        Row(
                          children: [
                            PopupMenuButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              offset: const Offset(0, 10),
                              position: PopupMenuPosition.under,
                              itemBuilder: (context) =>
                                  <PopupMenuEntry<FontFamilyName>>[
                                PopupMenuItem(
                                    value: FontFamilyName.inter,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "Sans Serif",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(fontFamily: "Inter"),
                                    )),
                                PopupMenuItem(
                                    value: FontFamilyName.lora,
                                    child: Text(
                                      "Serif",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(fontFamily: "Lora"),
                                    )),
                                PopupMenuItem(
                                    value: FontFamilyName.inconsolata,
                                    child: Text(
                                      "Mono",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(fontFamily: "inconsolata"),
                                    )),
                              ],
                              onSelected: (value) {
                                customTheme.changeFontFamily(value);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    customTheme.fontFamily,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Theme.of(context).primaryColor,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 35,
                              width: 2,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const ShapeDecoration(
                                  color: Colors.grey, shape: StadiumBorder()),
                            ),
                            const Toggle()
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    const CustomInputField(),
                    const SizedBox(height: 26),
                    if (notifier.presentWord == null)
                      const WordPreview(
                        audio: "",
                        wordDisplay: "No Word",
                        phonetic: "/ˈkiːbɔːd/",
                      ),
                    if (notifier.presentWord != null && notifier.errors == null)
                      getDisplayWord(notifier.presentWord!.phonetics),
                    const SizedBox(height: 10),
                    if (notifier.presentWord == null || notifier.errors != null)
                      const Expanded(child: AnimationFeedback()),
                    if (notifier.presentWord != null && notifier.errors == null)
                      Expanded(
                          child: ScrollConfiguration(
                        behavior:
                            const ScrollBehavior().copyWith(overscroll: false),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount:
                                      notifier.presentWord!.meaning.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        notifier.presentWord!.meaning.length) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.maxFinite,
                                            height: 1,
                                            margin:
                                                const EdgeInsets.only(left: 30),
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                          const SizedBox(height: 24),
                                          Text(
                                            "Source",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 17,
                                                    color:
                                                        const Color(0xff757575),
                                                    decoration: TextDecoration
                                                        .underline),
                                          ),
                                          ...List.generate(
                                            notifier.presentWord!.source.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0),
                                              child: Text(
                                                notifier
                                                    .presentWord!.source[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                    // return Text(notifier.presentWord!.meaning[index].partOfSpeech);
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              notifier.presentWord!
                                                  .meaning[index].partOfSpeech,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: double.maxFinite,
                                                height: 1,
                                                margin: const EdgeInsets.only(
                                                    left: 30),
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 32),
                                        Text(
                                          "Meaning",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontSize: 16,
                                                  color:
                                                      const Color(0xff757575)),
                                        ),
                                        const SizedBox(height: 17),
                                        ...List.generate(
                                            notifier.presentWord!.meaning[index]
                                                .definitions.length,
                                            (newIndex) => Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 3.0),
                                                          child: CircleAvatar(
                                                            radius: 3,
                                                            backgroundColor:
                                                                Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 25),
                                                        Expanded(
                                                            child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              notifier
                                                                  .presentWord!
                                                                  .meaning[
                                                                      index]
                                                                  .definitions[
                                                                      newIndex]
                                                                  .definition,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                            if (notifier
                                                                    .presentWord!
                                                                    .meaning[
                                                                        index]
                                                                    .definitions[
                                                                        newIndex]
                                                                    .example !=
                                                                null)
                                                              Column(
                                                                children: [
                                                                  const SizedBox(
                                                                      height:
                                                                          13),
                                                                  Text(
                                                                    '"${notifier.presentWord!.meaning[index].definitions[newIndex].example!}"',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodySmall!
                                                                        .copyWith(
                                                                            color:
                                                                                const Color(0xff757575)),
                                                                  ),
                                                                ],
                                                              ),
                                                          ],
                                                        ))
                                                      ],
                                                    ),
                                                    const SizedBox(height: 13),
                                                  ],
                                                )),
                                        if (notifier.presentWord!.meaning[index]
                                            .synonyms.isNotEmpty)
                                          Column(
                                            children: [
                                              const SizedBox(height: 11),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Synonyms",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            fontSize: 16,
                                                            color: const Color(
                                                                0xff757575)),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                        notifier
                                                            .presentWord!
                                                            .meaning[index]
                                                            .synonyms
                                                            .join(", "),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            )),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        if (notifier.presentWord!.meaning[index]
                                            .antonyms.isNotEmpty)
                                          Column(
                                            children: [
                                              const SizedBox(height: 20),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Anonymys",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            fontSize: 16,
                                                            color: const Color(
                                                                0xff757575)),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                        notifier
                                                            .presentWord!
                                                            .meaning[index]
                                                            .antonyms
                                                            .join(", "),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            )),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 32),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ))
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget getDisplayWord(List<Phonetics> phonetics) {
    var returnable = phonetics
        .where((element) => element.text.isNotEmpty && element.audio.isNotEmpty)
        .toList();

    if (returnable.isNotEmpty) {
      var usable = returnable.first;
      return WordPreview(
          wordDisplay: notifier.presentWord!.word,
          phonetic: usable.text,
          audio: usable.audio);
    } else if (phonetics
            .where((element) => element.audio.isNotEmpty)
            .isNotEmpty &&
        phonetics.where((element) => element.text.isNotEmpty).isNotEmpty) {
      var audio = phonetics.where((element) => element.audio.isNotEmpty).first;
      var phonetic =
          phonetics.where((element) => element.text.isNotEmpty).first;
      return WordPreview(
          wordDisplay: notifier.presentWord!.word,
          phonetic: phonetic.text,
          audio: audio.audio);
    } else if (phonetics
            .where((element) => element.audio.isNotEmpty)
            .isNotEmpty &&
        phonetics.where((element) => element.text.isNotEmpty).isEmpty) {
      var audio = phonetics.where((element) => element.audio.isNotEmpty).first;
      return WordPreview(
          wordDisplay: notifier.presentWord!.word,
          phonetic: "☹️😔",
          audio: audio.audio);
    } else if (phonetics
        .where((element) => element.text.isNotEmpty)
        .isNotEmpty) {
      var optional =
          phonetics.where((element) => element.text.isNotEmpty).first;
      return WordPreview(
          wordDisplay: notifier.presentWord!.word,
          phonetic: optional.text,
          audio: optional.audio);
    } else {
      return WordPreview(
          wordDisplay: notifier.presentWord!.word, phonetic: "☹️😔", audio: "");
    }
  }
}
