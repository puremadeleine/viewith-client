import 'package:flutter/material.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/widgets/button/rounded_button.dart';
import 'package:viewith/ui/widgets/button/vi_button_type.dart';

class VIButton extends StatelessWidget {
  const VIButton({
    super.key,
    required this.onTap,
    required this.type,
    required this.text,
    this.padding,
    this.isEnabled = true,
  });

  final Function() onTap;

  final VIButtonType type;

  final EdgeInsets? padding;

  final bool isEnabled;

  Color get _backgroundColor {
    if (!isEnabled) return AppDesign.colors.gray100;
    return switch (type) {
      VIButtonType.primary => AppDesign.colors.gray900,
      VIButtonType.kakao => AppDesign.colors.kakao,
      VIButtonType.apple => AppDesign.colors.gray900,
      VIButtonType.disabled => AppDesign.colors.gray100,
    };
  }

  Color get _textColor {
    if (!isEnabled) return AppDesign.colors.gray300;
    return switch (type) {
      VIButtonType.primary => AppDesign.colors.white,
      VIButtonType.kakao => AppDesign.colors.gray900,
      VIButtonType.apple => AppDesign.colors.white,
      VIButtonType.disabled => AppDesign.colors.gray300,
    };
  }

  final String text;

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      onTap: isEnabled ? () => onTap.call() : null,
      text: text,
      backgroundColor: _backgroundColor,
      textColor: _textColor,
      padding: padding,
    );
  }
}
