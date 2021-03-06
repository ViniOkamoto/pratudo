import 'package:flutter/material.dart';

class ConditionalWidget extends StatelessWidget {
  const ConditionalWidget({
    required this.isLoading,
    required this.loadingWidget,
    required this.hasError,
    required this.errorWidget,
    required this.child,
  });

  final bool isLoading;
  final Widget loadingWidget;
  final bool hasError;
  final Widget errorWidget;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget;
    } else if (hasError) {
      return errorWidget;
    } else {
      return child;
    }
  }
}
