import 'package:flutter/material.dart';
import 'package:forex_imf_tes/utils/extensions/context_extension.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  final Color? activeColor;
  final Color? inactiveColor;
  const LoadingWidget({
    Key? key,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: context.textColor!,
      size: AppBar().preferredSize.height / 2,
    );
  }
}
