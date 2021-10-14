// ignore_for_file: use_key_in_widget_constructors

import 'package:books/src/core/constants/dimensions.dart';
import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  final double height;
  final double width;

  const Spacing.height(this.height) : width = Dimensions.zero;

  const Spacing.tinyHeight() : this.height(Dimensions.tiny);
  const Spacing.smallHeight() : this.height(Dimensions.small);
  const Spacing.mediumHeight() : this.height(Dimensions.medium);
  const Spacing.bigHeight() : this.height(Dimensions.big);
  const Spacing.largeHeight() : this.height(Dimensions.large);

  const Spacing.width(this.width) : height = Dimensions.zero;

  const Spacing.tinyWidth() : this.width(Dimensions.tiny);
  const Spacing.smallWidth() : this.width(Dimensions.small);
  const Spacing.mediumWidth() : this.width(Dimensions.medium);
  const Spacing.bigWidth() : this.width(Dimensions.big);
  const Spacing.largeWidth() : this.width(Dimensions.large);

  const Spacing.empty()
      : width = Dimensions.zero,
        height = Dimensions.zero;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
