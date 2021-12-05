import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'step_by_step_store.g.dart';

class StepByStepStore = _StepByStepStoreBase with _$StepByStepStore;

abstract class _StepByStepStoreBase with Store {
  final PageController pageController = PageController();

  @observable
  int page = 0;

  @observable
  Map<String, int> stepLength = {};

  @action
  setStepLength(Map<String, int> value) {
    stepLength = value;
    pageIntervals = getIntervals();
    print(pageIntervals);
  }

  @observable
  Map<String, Map<String, int>> pageIntervals = {};

  @observable
  int currentlyPositionInStep = 0;

  @computed
  String? get titlePage {
    if (page > 0) {
      return getCurrentlySectionName();
    }
    return null;
  }

  getIntervals() {
    Map<String, Map<String, int>> pageIntervals = {};
    String lastSection = '';

    for (int index = 0; index < stepLength.keys.length; index++) {
      String section = stepLength.keys.elementAt(index);
      int startsIn = lastSection.isNotEmpty
          ? (pageIntervals[lastSection]!['endsIn']! + 1)
          : 1;
      int endsIn = startsIn + stepLength[section]!;
      pageIntervals[section] = {
        'startsIn': startsIn,
        'endsIn': endsIn,
      };
      lastSection = section;
    }

    return pageIntervals;
  }

  String getCurrentlySectionName() {
    String currentlySection = '';
    pageIntervals.forEach((key, value) {
      if (page >= value['startsIn']! && page <= value['endsIn']!) {
        currentlySection = key;
      }
    });

    return currentlySection;
  }

  onPageChange(int index) {
    page = index;
  }

  nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  backPage() {
    pageController.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
