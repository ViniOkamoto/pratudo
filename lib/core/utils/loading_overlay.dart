import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pratudo/core/resources/constants.dart';
import 'package:pratudo/core/theme/colors.dart';

class LoadingOverlay {
  BuildContext _context;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) => _FullScreenLoader(),
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of() {
    return LoadingOverlay._create(Constants.appGlobalKey.currentState!.context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.4,
          child: const ModalBarrier(dismissible: false, color: AppColors.darkestColor),
        ),
        Center(
          child: Lottie.asset(
            "assets/animations/loading_animation.json",
            width: 200,
            height: 200,
          ),
        ),
      ],
    );
  }
}
