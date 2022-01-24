import 'package:flutter/material.dart';
import 'package:patta/ui/common_widgets/pariyatti_icons.dart';

class AudioButton extends StatelessWidget {
  final void Function()? onPressed;

  AudioButton({this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        padding: EdgeInsets.zero,
        child: Icon(
          PariyattiIcons.get(IconName.play),
          color: Color(0xff6d695f),
        ),
        onPressed: press,
      ),
    );
  }

  void press() {
    // TODO: this needs to become a stateful widget -sd
    this.onPressed!();
  }
}
