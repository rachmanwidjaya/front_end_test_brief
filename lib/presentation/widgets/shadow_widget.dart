import 'package:flutter/material.dart';
import 'package:forex_imf_tes/utils/extensions/context_extension.dart';

class ShadowWidget extends StatelessWidget {
  final Widget? child;
  final double? radius;
  const ShadowWidget({
    Key? key,
    this.child,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 4,
      shadowColor: context.shadowColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 4),
        child: child ?? Container(),
      ),
    );
  }
}
