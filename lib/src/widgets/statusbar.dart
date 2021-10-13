import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum StatusbarType { light, dark }

extension StatusbarTypeExtension on StatusbarType {
  bool get isLight => this == StatusbarType.light;
  bool get isDark => this == StatusbarType.dark;
}

class Statusbar extends StatelessWidget {
  final StatusbarType statusbarType;
  final Widget child;

  const Statusbar({
    Key? key,
    required this.child,
  })  : statusbarType = StatusbarType.light,
        super(key: key);

  const Statusbar.dark({
    Key? key,
    required this.child,
  })  : statusbarType = StatusbarType.dark,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            statusbarType.isLight ? Brightness.dark : Brightness.light,
      ),
      child: child,
    );
  }
}
