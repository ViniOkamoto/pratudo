import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class BaseModal extends StatelessWidget {
  const BaseModal({
    required this.body,
    this.bottom,
    required this.title,
  });

  final String title;
  final Widget body;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          left: SizeConverter.relativeWidth(16),
          right: SizeConverter.relativeWidth(16),
          top: SizeConverter.relativeHeight(16),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 160,
          horizontal: SizeConverter.relativeWidth(24),
        ),
        constraints: BoxConstraints(
          maxHeight: 340,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Material(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ModalHeader(title: title),
                          Spacing(height: 16),
                          body,
                        ],
                      ),
                    ),
                    bottom ?? Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModalHeader extends StatelessWidget {
  final String title;
  _ModalHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTypo.h3(color: AppColors.darkestColor),
        ),
        SizedBox(
          width: SizeConverter.relativeWidth(18),
          height: SizeConverter.relativeWidth(18),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pop(context, false),
            icon: Icon(LineAwesomeIcons.times),
            color: AppColors.darkColor,
            iconSize: SizeConverter.fontSize(18),
          ),
        )
      ],
    );
  }
}
