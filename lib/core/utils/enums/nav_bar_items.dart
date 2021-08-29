import 'package:flutter/cupertino.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/features/screens/main/views/explore_view.dart';
import 'package:pratudo/features/screens/main/views/favorites_view.dart';
import 'package:pratudo/features/screens/main/views/profile_view.dart';
import 'package:pratudo/features/screens/main/views/search_view.dart';

enum NavBarItem {
  EXPLORE,
  SEARCH,
  FAVORITES,
  PROFILE,
}

Map<NavBarItem, IconData> navIcon = {
  NavBarItem.EXPLORE: LineAwesomeIcons.compass,
  NavBarItem.SEARCH: LineAwesomeIcons.search,
  NavBarItem.FAVORITES: LineAwesomeIcons.bookmark,
  NavBarItem.PROFILE: LineAwesomeIcons.user,
};

Map<NavBarItem, Widget> navPage = {
  NavBarItem.EXPLORE: ExploreView(),
  NavBarItem.SEARCH: SearchView(),
  NavBarItem.FAVORITES: FavoritesView(),
  NavBarItem.PROFILE: ProfileView(),
};

Map<NavBarItem, String> navText = {
  NavBarItem.EXPLORE: "Explorar",
  NavBarItem.SEARCH: "Buscar",
  NavBarItem.FAVORITES: "Salvos",
  NavBarItem.PROFILE: "Perfil",
};
