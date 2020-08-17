import 'package:flutter/material.dart';
import 'package:patta/ui/common_widgets/pariyatti_icons.dart';

class ShareButton extends StatelessWidget {
  Function onPressed;

  ShareButton(this.onPressed, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        padding: EdgeInsets.zero,
        child: Icon(
          PariyattiIcons.get(IconName.share),
          color: Color(0xff6d695f),
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
