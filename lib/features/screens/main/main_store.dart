import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/enums/nav_bar_items.dart';

part 'main_store.g.dart';

class MainStore = _MainStoreBase with _$MainStore;

abstract class _MainStoreBase with Store {
  final PageController navigationController = PageController(
    keepPage: true,
  );

  @observable
  NavBarItem pageSelected = NavBarItem.EXPLORE;

  @action
  selectPage(NavBarItem item) {
    pageSelected = item;
    navigationController.jumpToPage(item.index);
  }
}
