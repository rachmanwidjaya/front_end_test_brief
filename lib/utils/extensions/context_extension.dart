import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get canvasColor => Theme.of(this).canvasColor;
  Color? get textColor => Theme.of(this).textTheme.bodyLarge!.color;
  Color get cardColor => Theme.of(this).cardColor;
  Color get cardLightColor => ThemeData.light().cardColor;
  Color get cardDarkColor => ThemeData.dark().cardColor;
  Color? get iconThemeColor => Theme.of(this).iconTheme.color;
  Color get disabledColor => Theme.of(this).disabledColor;
  Color get hintColor => Theme.of(this).hintColor;
  Color get shadowColor => Theme.of(this).shadowColor;
  Color get highlightColor => Theme.of(this).highlightColor;
  Color get splashColor => Theme.of(this).splashColor;
  Color? get appBarBackgroundColor =>
      Theme.of(this).appBarTheme.backgroundColor;
  Color? get bmnavUnselectedColor =>
      Theme.of(this).bottomNavigationBarTheme.unselectedItemColor;
  Color? get bmnavSelectedColor =>
      Theme.of(this).bottomNavigationBarTheme.selectedItemColor;
  Color? get bmnavBackgroundColor =>
      Theme.of(this).bottomNavigationBarTheme.backgroundColor;
  double get sizeWidth => MediaQuery.of(this).size.width;
  double get sizeHeight => MediaQuery.of(this).size.height;
  double get paddingTop => MediaQuery.of(this).padding.top;
  TextTheme get textTheme => Theme.of(this).textTheme;
  List<Shadow> get shadow => [
        const Shadow(
          offset: Offset(1.0, 1.0),
          blurRadius: 1.0,
          color: Colors.black,
        ),
        Shadow(
          offset: const Offset(1.0, 1.0),
          blurRadius: 3.0,
          color: Theme.of(this).disabledColor,
        ),
      ];
}
