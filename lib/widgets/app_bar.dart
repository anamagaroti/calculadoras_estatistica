import 'package:flutter/material.dart';

import 'text_widget.dart';
import 'theme.dart';

class AppBarWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final List<Widget>? actions;
  final bool? isBack;
  final Widget? leading;
  const AppBarWidget({super.key, required this.onTap, required this.title, this.actions, this.isBack, this.leading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          if (leading != null) leading!,
          (isBack ?? true)
              ? IconButton(
                  onPressed: () {
                    onTap();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                )
              : const SizedBox(),
          Center(
            child: TextWidget(
              textStyleNum: TextStyleNum.headline1,
              text: title,
              fontWeightNum: FontWeightNum.w600,
              textAlign: TextAlign.center,
            ),
          ),
          if (actions?.isNotEmpty == true)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
