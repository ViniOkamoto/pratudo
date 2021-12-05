import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/shared/step_by_step/step_by_step_store.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/back_view.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/next_view.dart';

class StepByStepNavigation extends StatelessWidget {
  const StepByStepNavigation({
    Key? key,
    required StepByStepStore store,
  })  : _store = store,
        super(key: key);

  final StepByStepStore _store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConverter.relativeWidth(16),
            vertical: SizeConverter.relativeHeight(32),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: _store.page > 0,
                child: BackView(
                  onTap: () => _store.backPage(),
                  title: 'Voltar',
                ),
                replacement: Container(),
              ),
              NextView(
                onTap: () => _store.nextPage(),
                title: _getTitleButton(),
              ),
            ],
          ),
        );
      },
    );
  }

  _getTitleButton() {
    if (_store.page == 0) {
      return 'Preparar receita';
    }
    if (_store.hasStepInSection) {
      return 'Próximo passo';
    }
    if (!_store.hasStepInSection && _store.hasSection) {
      return 'Próxima seção';
    }
    if (!_store.hasStepInSection && !_store.hasSection) {
      return 'Finalizar receita';
    }
  }
}
