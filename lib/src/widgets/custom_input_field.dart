import 'package:dictionary_app/src/settings/custom_theme.dart';
import 'package:dictionary_app/word_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({super.key});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {

  FocusNode focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState(){

    focusNode.addListener(listener);
    super.initState();
  }

  listener(){
    setState(() {});
  }
  @override
  void dispose() {
    focusNode.removeListener(listener);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context,child) {
        return TextFormField(
          textInputAction: TextInputAction.search,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: Theme.of(context).primaryColor,
          autofocus: false,
          controller: _controller,
          focusNode: focusNode,
          decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xffEA2626),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: const Color(0xffEA2626).withOpacity(0.6),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15),
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if(_controller.text.trim().isEmpty) return;
                      focusNode.unfocus();
                      notifier.getWord(_controller.text.trim());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: notifier.gettingWord? ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 20,maxWidth: 20),
                        child: CircularProgressIndicator(strokeWidth: 1.6,color: Theme.of(context).primaryColor,)):SvgPicture.asset("assets/images/icon-search.svg")),
                  ),
                  fillColor: focusNode.hasFocus ? Colors.transparent: customTheme.currentTheme== ThemeMode.light? const Color(0xfff4f4f4):const Color(0xff1f1f1f)
          ),
          style: Theme.of(context).textTheme.headlineSmall,
          validator: (value){
            if(value!.isEmpty){
              return "Whoops, can’t be empty…";
            }
            return null;
          },
          onFieldSubmitted: (value) {
            if(value.isEmpty) return;
             notifier.getWord(value.trim());}
        );
      }
    );
  }
}