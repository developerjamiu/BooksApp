import 'package:books/src/widgets/responsive.dart';
import 'package:flutter/material.dart';

class ResponsiveDialog extends StatelessWidget {
  final Widget child;
  const ResponsiveDialog({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal:
            Responsive.isDesktop(context) || Responsive.isLaptop(context)
                ? screenWidth * 0.25
                : 32,
      ),
      child: child,
    );
  }
}
