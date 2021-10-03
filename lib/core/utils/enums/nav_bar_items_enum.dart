import 'package:flutter/cupertino.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/features/screens/main/views/explore/explore_view.dart';
import 'package:pratudo/features/screens/main/views/favorites_view.dart';
import 'package:pratudo/features/screens/main/views/profile_view.dart';
import 'package:pratudo/features/screens/main/views/search/search_view.dart';

enum NavBarItemEnum {
  EXPLORE,
  SEARCH,
  FAVORITES,
  PROFILE,
}

Map<NavBarItemEnum, IconData> navIcon = {
  NavBarItemEnum.EXPLORE: LineAwesomeIcons.compass,
  NavBarItemEnum.SEARCH: LineAwesomeIcons.search,
  NavBarItemEnum.FAVORITES: LineAwesomeIcons.bookmark,
  NavBarItemEnum.PROFILE: LineAwesomeIcons.user,
};

Map<NavBarItemEnum, Widget> navPage = {
  NavBarItemEnum.EXPLORE: ExploreView(),
  NavBarItemEnum.SEARCH: SearchView(),
  NavBarItemEnum.FAVORITES: FavoritesView(),
  NavBarItemEnum.PROFILE: ProfileView(),
};

Map<NavBarItemEnum, String> navText = {
  NavBarItemEnum.EXPLORE: "Explorar",
  NavBarItemEnum.SEARCH: "Buscar",
  NavBarItemEnum.FAVORITES: "Salvos",
  NavBarItemEnum.PROFILE: "Perfil",
};
