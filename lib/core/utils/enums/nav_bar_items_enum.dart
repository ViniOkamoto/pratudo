import 'package:flutter/cupertino.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/features/screens/main/views/cached_recipes/cached_recipes_view.dart';
import 'package:pratudo/features/screens/main/views/explore/explore_view.dart';
import 'package:pratudo/features/screens/main/views/profile/profile_view.dart';
import 'package:pratudo/features/screens/main/views/search/search_view.dart';

enum NavBarItemEnum {
  EXPLORE,
  SEARCH,
  FAVORITES,
  PROFILE,
}

extension NavBarItemEnumExtension on NavBarItemEnum {
  IconData get icon {
    switch (this) {
      case NavBarItemEnum.EXPLORE:
        return LineAwesomeIcons.compass;
      case NavBarItemEnum.SEARCH:
        return LineAwesomeIcons.search;
      case NavBarItemEnum.FAVORITES:
        return LineAwesomeIcons.bookmark;
      case NavBarItemEnum.PROFILE:
        return LineAwesomeIcons.user;
    }
  }

  Widget get page {
    switch (this) {
      case NavBarItemEnum.EXPLORE:
        return ExploreView();
      case NavBarItemEnum.SEARCH:
        return SearchView();
      case NavBarItemEnum.FAVORITES:
        return CachedRecipesView();
      case NavBarItemEnum.PROFILE:
        return ProfileView();
    }
  }

  String get enumToString {
    switch (this) {
      case NavBarItemEnum.EXPLORE:
        return 'Explorar';
      case NavBarItemEnum.SEARCH:
        return 'Buscar';
      case NavBarItemEnum.FAVORITES:
        return 'Salvos';
      case NavBarItemEnum.PROFILE:
        return 'Perfil';
    }
  }

  bool checkIfIsType(NavBarItemEnum item) {
    return this == item;
  }
}

Map<NavBarItemEnum, Widget> navPage = {
  NavBarItemEnum.EXPLORE: ExploreView(),
  NavBarItemEnum.SEARCH: SearchView(),
  NavBarItemEnum.FAVORITES: CachedRecipesView(),
  NavBarItemEnum.PROFILE: ProfileView(),
};
