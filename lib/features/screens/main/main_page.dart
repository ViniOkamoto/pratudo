import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/enums/nav_bar_items_enum.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/gamification/experience_gained_model.dart';
import 'package:pratudo/features/screens/main/main_store.dart';
import 'package:pratudo/features/stores/shared/user_progress_store.dart';
import 'package:pratudo/features/widgets/app_nav_bar.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
import 'package:pratudo/features/widgets/base_modal.dart';
import 'package:pratudo/features/widgets/custom_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainStore _mainStore = serviceLocator<MainStore>();
  final UserProgressStore _userProgressStore =
      serviceLocator<UserProgressStore>();
  late final disposeReaction;
  List<Widget> pages = navPage.entries.map((e) => e.value).toList();

  @override
  void initState() {
    super.initState();
    _userProgressStore.getUserProgress();
    disposeReaction = reaction(
      (_) => _userProgressStore.experienceGainedModel,
      (experienceGained) {
        if (experienceGained != null) {}
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    disposeReaction();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, Routes.createRecipe),
          backgroundColor: AppColors.highlightColor,
          child: Icon(
            LineAwesomeIcons.edit,
            color: AppColors.whiteColor,
            size: SizeConverter.fontSize(32),
          ),
        ),
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
                      if (_mainStore.pageSelected !=
                          NavBarItemEnum.PROFILE) ...[
                        IconButton(
                          onPressed: () {},
                          icon: Icon(LineAwesomeIcons.list),
                          color: AppColors.lightHighlightColor,
                          iconSize: SizeConverter.fontSize(24),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            Routes.myPerformance,
                          ),
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

class GamificationNotifierModal extends StatelessWidget {
  const GamificationNotifierModal({
    Key? key,
    required this.experienceGainedModel,
    this.bottom,
  }) : super(key: key);

  final ExperienceGainedModel experienceGainedModel;
  final Widget? bottom;
  @override
  Widget build(BuildContext context) {
    return BaseModal(
      title: '',
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Opa, você ganhou *xp*!!',
                  style: AppTypo.h2(color: AppColors.darkColor),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConverter.relativeHeight(16),
                  ),
                  child: Icon(
                    LineAwesomeIcons.trophy,
                    size: SizeConverter.fontSize(86),
                    color: AppColors.orangeColor,
                  ),
                ),
                CustomText(
                  text:
                      'Você ganhou *${experienceGainedModel.gainedExperience}xp* '
                      'por *${experienceGainedModel.reason.toLowerCase()}*',
                  style: AppTypo.h3(color: AppColors.darkerColor),
                ),
              ],
            ),
          ),
        ],
      ),
      bottom: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: bottom ??
            Row(
              children: [
                Expanded(
                  child: AppPrimaryButton(
                    text: 'Voltar',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
      ),
    );
  }
}
