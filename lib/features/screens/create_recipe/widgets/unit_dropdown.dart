import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/unit_model.dart';
import 'package:pratudo/features/widgets/base_modal.dart';

class UnitDropdown extends StatefulWidget {
  final List<UnitModel> unitList;
  final Function(dynamic) onChanged;
  final UnitModel value;

  const UnitDropdown({
    required this.unitList,
    required this.onChanged,
    required this.value,
  });

  @override
  State<UnitDropdown> createState() => _UnitDropdownState();
}

class _UnitDropdownState extends State<UnitDropdown> {
  @override
  Widget build(BuildContext context) {
    return SelectableFieldWithModal(
      modalItems: widget.unitList,
      onChanged: widget.onChanged,
      value: widget.value,
    );
  }
}

class SelectableFieldWithModal extends StatelessWidget {
  final List<UnitModel> modalItems;
  final Function(dynamic) onChanged;
  final UnitModel value;

  const SelectableFieldWithModal({
    required this.modalItems,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () async {
        final result = await showDialog(
          context: context,
          builder: (context) {
            return _OptionsModal(
              onChanged: onChanged,
              modalItems: modalItems,
              itemSelected: value,
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          left: SizeConverter.relativeWidth(12),
          right: SizeConverter.relativeWidth(10),
          top: SizeConverter.relativeWidth(8),
          bottom: SizeConverter.relativeWidth(8),
        ),
        decoration: BoxDecoration(
          color: AppColors.lightestGrayColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value.abbreviation,
              style: AppTypo.p3(color: AppColors.darkestColor),
            ),
            Icon(
              LineAwesomeIcons.angle_down,
              color: AppColors.highlightColor,
              size: SizeConverter.fontSize(12),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionsModal extends StatelessWidget {
  const _OptionsModal({
    required this.modalItems,
    required this.itemSelected,
    required this.onChanged,
  });

  final List<UnitModel> modalItems;
  final UnitModel itemSelected;
  final Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context) {
    return BaseModal(
      body: Expanded(
        child: Scrollbar(
          isAlwaysShown: true,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              UnitModel unit = modalItems[index];
              return RadioItemWidget(
                groupValue: itemSelected.key,
                onChanged: onChanged,
                value: unit.key,
                text: '${unit.translate} (${unit.abbreviation})',
              );
            },
            itemCount: modalItems.length,
          ),
        ),
      ),
      title: "Unidades de medida",
    );
  }
}

class RadioItemWidget extends StatelessWidget {
  final dynamic value;
  final dynamic groupValue;
  final ValueChanged<dynamic>? onChanged;
  final String text;

  const RadioItemWidget({
    this.groupValue,
    required this.onChanged,
    required this.value,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: value, groupValue: groupValue, onChanged: onChanged),
        Expanded(
          child: Text(
            text,
            style: AppTypo.p2(color: AppColors.darkerColor),
          ),
        ),
      ],
    );
  }
}
