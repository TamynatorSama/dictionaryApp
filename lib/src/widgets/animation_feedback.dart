import 'package:dictionary_app/word_notifier.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationFeedback extends StatefulWidget {
  const AnimationFeedback({super.key});

  @override
  State<AnimationFeedback> createState() => _AnimationFeedbackState();
}

class _AnimationFeedbackState extends State<AnimationFeedback> with SingleTickerProviderStateMixin{

  late AnimationController lottieController;


  @override
  void initState() {
    lottieController = AnimationController(vsync: this,duration: const Duration(microseconds: 500))..addListener(() {
      setState(() {
        
      });
    })..repeat();
    super.initState();
  }


  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context,child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                
                notifier.presentWord == null ? notifier.errors !=null ? notifier.errors!["result"].toString().toLowerCase().contains("sorry")? "assets/106840-search-not-found.json":"assets/NoInternet.json" :  "assets/8852-searching-for-word.json" : notifier.errors !=null ? notifier.errors!["result"].toString().toLowerCase().contains("sorry")? "assets/106840-search-not-found.json":"assets/NoInternet.json" : "assets/8852-searching-for-word.json",
                controller: lottieController,
                onLoaded: (p0) {
                  lottieController.duration = p0.duration;
                  lottieController.forward().then((value) => lottieController.repeat());
                },
                ),
                if(notifier.errors !=null && notifier.errors!["result"].toString().toLowerCase().contains("sorry"))Text("Sorry pal, we couldn't find definitions for the word you were looking for.",textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18, color: const Color(0xff757575)),)
            ],
          ),
        );
      }
    );
  }
}