import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/custom_multi_select_bottom_sheet/custom_multi_select_bottom_sheet_widget.dart';
import 'package:pratudo/features/widgets/custom_multi_select_bottom_sheet/custom_multi_select_chip_display_widget.dart';
import 'package:pratudo/features/widgets/custom_multi_select_bottom_sheet/custom_multi_select_item.dart';

class MultiSelectFormField<T> extends StatefulWidget {
  final List<T> itemsList;
  final Function(List<Object?>) onConfirm;
  final Function(Object? item) onTapChipSelected;
  final List<T?>? selectedItems;
  final String label;
  final List<CustomMultiSelectItem<T?>> builderElement;
  final String hintText;
  final String bottomSheetTitle;

  const MultiSelectFormField({
    required this.itemsList,
    required this.onConfirm,
    required this.onTapChipSelected,
    required this.selectedItems,
    required this.label,
    required this.builderElement,
    required this.hintText,
    required this.bottomSheetTitle,
  });

  @override
  _MultiSelectFormFieldState<T> createState() => _MultiSelectFormFieldState<T>();
}

class _MultiSelectFormFieldState<T> extends State<MultiSelectFormField<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConverter.relativeHeight(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: SizeConverter.relativeWidth(5),
              bottom: SizeConverter.relativeHeight(8),
            ),
            child: Text(
              widget.label,
              style: AppTypo.p3(
                color: AppColors.darkColor,
              ),
            ),
          ),
          Observer(
            builder: (context) {
              return CustomMultiSelectBottomSheetField(
                initialChildSize: 0.4,
                listType: MultiSelectListType.CHIP,
                searchable: true,
                itemsTextStyle: AppTypo.p5(color: AppColors.darkerColor),
                selectedColor: AppColors.highlightColor,
                unselectedColor: AppColors.lightestGrayColor,
                checkColor: AppColors.darkestColor,
                initialValue: widget.selectedItems,
                selectedItemsTextStyle: AppTypo.p5(color: AppColors.whiteColor),
                buttonIcon: Icon(
                  LineAwesomeIcons.plus,
                  color: AppColors.grayColor,
                  size: SizeConverter.fontSize(16),
                ),
                buttonText: Text(
                  widget.hintText,
                  style: AppTypo.p2(color: AppColors.lightGrayColor),
                ),
                title: Text(
                  widget.bottomSheetTitle,
                  style: AppTypo.p2(color: AppColors.darkerColor),
                ),
                items: widget.builderElement,
                onConfirm: (values) {
                  widget.onConfirm(values);
                },
                chipDisplay: CustomMultiSelectChipDisplay(
                  textStyle: AppTypo.p5(color: AppColors.darkestColor),
                  chipColor: AppColors.whiteColor,
                  icon: Icon(
                    LineAwesomeIcons.times,
                    size: SizeConverter.fontSize(13),
                    color: AppColors.darkerColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    side: BorderSide(
                      color: AppColors.lightGrayColor,
                    ),
                  ),
                  onTap: (value) {
                    widget.onTapChipSelected(value);
                    return widget.selectedItems;
                  },
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightestGrayColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
