import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiceButton extends StatelessWidget {
  final void Function() onPressed;
  final String path;

  const DiceButton({
    super.key,
    required this.onPressed,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: FilledButton.tonal(
          onPressed: onPressed,
          child: SvgPicture.asset(
            path,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onSecondary,
              BlendMode.srcIn,
            ),
            height: 42,
          ),
        ),
      ),
    );
  }
}
