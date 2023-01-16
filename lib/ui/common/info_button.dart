import 'package:flutter/material.dart';
import 'package:patta/ui/common/toggle.dart';

class InfoButton extends StatelessWidget {
  final void Function()? onPressed;
  final Toggle toggle;

  const InfoButton({required this.toggle, this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: this.toggle.onToggle,
        builder: (context, snapshot) {
          final isActive = (snapshot.hasData && snapshot.data != null && snapshot.data == true);

          Icon icon;
          if (isActive) {
            icon = Icon(
              Icons.info,
              color: Theme.of(context).colorScheme.onSecondary,
            );
          } else {
            icon = Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.onSecondary,
            );
          }
          return MaterialButton(
            padding: EdgeInsets.zero,
            child: icon,
            onPressed: () {
              if (isActive) {
                this.toggle.off();
              } else {
                this.toggle.on();
              }
              this.onPressed!();
            },
          );
        },
      ),
    );
  }
}
