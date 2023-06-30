import 'package:flutter/material.dart';
import 'package:forex_imf_tes/utils/extensions/context_extension.dart';

final Color? defaultColor = Colors.grey[700];

const Color defaultOnSelectColor = Colors.blue;

class BottomNav extends StatefulWidget {
  final int? index;
  final void Function(int i)? onTap;
  final List<BottomNavItem>? items;
  final double? elevation;
  final IconStyle? iconStyle;
  final Color? color;
  final LabelStyle? labelStyle;

  BottomNav({
    Key? key,
    this.index,
    this.onTap,
    this.items,
    this.elevation = 8.0,
    this.iconStyle,
    this.color = Colors.white,
    this.labelStyle,
  })  : assert(items != null),
        assert(items!.length >= 2),
        super(key: key);

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int? currentIndex;
  IconStyle? iconStyle;
  LabelStyle? labelStyle;

  @override
  void initState() {
    currentIndex = widget.index ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    iconStyle = widget.iconStyle ?? IconStyle();
    labelStyle = widget.labelStyle ?? LabelStyle();

    return Material(
      elevation: widget.elevation!,
      color: widget.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: widget.items!.map(
          (b) {
            final int i = widget.items!.indexOf(b);
            final bool selected = i == currentIndex;

            return BMNavItem(
              icon: b.icon!,
              iconSize: selected
                  ? iconStyle!.getSelectedSize()
                  : iconStyle!.getSize(),
              label: parseLabel(b.label!, labelStyle!, selected),
              onTap: () => onItemClick(i),
              textStyle: selected
                  ? labelStyle!.getOnSelectTextStyle()
                  : labelStyle!.getTextStyle(),
              color: selected
                  ? iconStyle!.getSelectedColor()
                  : iconStyle!.getColor(),
            );
          },
        ).toList(),
      ),
    );
  }

  onItemClick(int i) {
    setState(() {
      currentIndex = i;
    });
    if (widget.onTap != null) widget.onTap!(i);
  }

  parseLabel(String label, LabelStyle style, bool selected) {
    if (!style.isVisible()) {
      return null;
    }

    if (style.isShowOnSelect()) {
      return selected ? label : null;
    }

    return label;
  }
}

class BottomNavItem {
  final IconData? icon;
  final String? label;

  BottomNavItem(this.icon, {this.label});
}

class LabelStyle {
  final bool? visible;
  final bool? showOnSelect;
  final TextStyle? textStyle;
  final TextStyle? onSelectTextStyle;

  LabelStyle(
      {this.visible,
      this.showOnSelect,
      this.textStyle,
      this.onSelectTextStyle});

  isVisible() {
    return visible ?? true;
  }

  isShowOnSelect() {
    return showOnSelect ?? false;
  }

  getTextStyle() {
    if (textStyle != null) {
      return TextStyle(
        inherit: textStyle!.inherit,
        color: textStyle!.color ?? defaultOnSelectColor,
        fontSize: textStyle!.fontSize ?? 12.0,
        fontWeight: textStyle!.fontWeight,
        fontStyle: textStyle!.fontStyle,
        letterSpacing: textStyle!.letterSpacing,
        wordSpacing: textStyle!.wordSpacing,
        textBaseline: textStyle!.textBaseline,
        height: textStyle!.height,
        locale: textStyle!.locale,
        foreground: textStyle!.foreground,
        background: textStyle!.background,
        decoration: textStyle!.decoration,
        decorationColor: textStyle!.decorationColor,
        decorationStyle: textStyle!.decorationStyle,
        debugLabel: textStyle!.debugLabel,
        fontFamily: textStyle!.fontFamily,
      );
    }
    return TextStyle(color: defaultColor, fontSize: 12.0);
  }

  getOnSelectTextStyle() {
    if (onSelectTextStyle != null) {
      return TextStyle(
        inherit: onSelectTextStyle!.inherit,
        color: onSelectTextStyle!.color ?? defaultOnSelectColor,
        fontSize: onSelectTextStyle!.fontSize ?? 12.0,
        fontWeight: onSelectTextStyle!.fontWeight,
        fontStyle: onSelectTextStyle!.fontStyle,
        letterSpacing: onSelectTextStyle!.letterSpacing,
        wordSpacing: onSelectTextStyle!.wordSpacing,
        textBaseline: onSelectTextStyle!.textBaseline,
        height: onSelectTextStyle!.height,
        locale: onSelectTextStyle!.locale,
        foreground: onSelectTextStyle!.foreground,
        background: onSelectTextStyle!.background,
        decoration: onSelectTextStyle!.decoration,
        decorationColor: onSelectTextStyle!.decorationColor,
        decorationStyle: onSelectTextStyle!.decorationStyle,
        debugLabel: onSelectTextStyle!.debugLabel,
        fontFamily: onSelectTextStyle!.fontFamily,
      );
    }
    return const TextStyle(color: defaultOnSelectColor, fontSize: 12.0);
  }
}

class IconStyle {
  final double? size;
  final double? onSelectSize;
  final Color? color;
  final Color? onSelectColor;

  IconStyle({this.size, this.onSelectSize, this.color, this.onSelectColor});

  getSize() {
    return size ?? 24.0;
  }

  getSelectedSize() {
    return onSelectSize ?? 24.0;
  }

  getColor() {
    return color ?? defaultColor;
  }

  getSelectedColor() {
    return onSelectColor ?? defaultOnSelectColor;
  }
}

class BMNavItem extends StatelessWidget {
  final IconData? icon;
  final double? iconSize;
  final String? label;
  final void Function()? onTap;
  final Color? color;
  final TextStyle? textStyle;

  const BMNavItem({
    Key? key,
    this.icon,
    this.iconSize,
    this.label,
    this.onTap,
    this.color,
    this.textStyle,
  })  : assert(icon != null),
        assert(iconSize != null),
        assert(color != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkResponse(
      key: key,
      highlightColor: context.highlightColor,
      splashColor: context.splashColor,
      radius: Material.defaultSplashRadius,
      onTap: () => onTap!(),
      child: Padding(
          padding: getPadding(),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Icon(icon, size: iconSize, color: color),
            const Padding(
              padding: EdgeInsets.all(1),
            ),
            label != null ? Text(label!, style: textStyle) : Container()
          ])),
    ));
  }

  getPadding() {
    if (label != null) {
      final double p = ((56 - textStyle!.fontSize!) - iconSize!) / 2;
      return EdgeInsets.fromLTRB(0.0, p, 0.0, p);
    }
    return EdgeInsets.fromLTRB(
        0.0, (56 - iconSize!) / 2, 0.0, (56 - iconSize!) / 2);
  }
}
