import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/enums/nav_bar_items_enum.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/main/main_store.dart';
import 'package:pratudo/features/stores/shared/user_progress_store.dart';
import 'package:pratudo/features/widgets/app_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainStore _mainStore = serviceLocator<MainStore>();
  final UserProgressStore _userProgressStore = serviceLocator<UserProgressStore>();

  List<Widget> pages = navPage.entries.map((e) => e.value).toList();

  @override
  void initState() {
    super.initState();
    _userProgressStore.getUserProgress();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              Observer(
                builder: (context) {
                  return SliverAppBar(
                    backgroundColor: AppColors.whiteColor,
                    title: SizedBox(
                      width: SizeConverter.relativeWidth(70),
                      child: Image.asset('assets/images/letters.png'),
                    ),
                    actions: [
                      if (_mainStore.pageSelected != NavBarItemEnum.PROFILE) ...[
                        IconButton(
                          onPressed: () {},
                          icon: Icon(LineAwesomeIcons.list),
                          color: AppColors.lightHighlightColor,
                          iconSize: SizeConverter.fontSize(24),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(LineAwesomeIcons.trophy),
                          color: AppColors.yellowColor,
                          iconSize: SizeConverter.fontSize(24),
                        )
                      ]
                    ],
                  );
                },
              ),
            ];
          },
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            children: pages,
            controller: _mainStore.navigationController,
          ),
        ),
        bottomNavigationBar: AppNavBar(
          mainStore: _mainStore,
          userProgressStore: _userProgressStore,
        ),
      ),
    );
  }
}
