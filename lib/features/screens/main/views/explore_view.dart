import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/app_search_field.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  _ExploreViewState createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  int currentIndex = 0;
  List<int> list = [1, 2, 3, 4, 5, 6];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConverter.relativeWidth(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacing(height: 24),
                Text(
                  "O que vamos cozinhar hoje?",
                  style: AppTypo.h2(color: AppColors.darkestColor),
                ),
                Spacing(height: 16),
                AppSearchField(
                  hintText: "Digite o nome da receita",
                  textEditingController: TextEditingController(),
                  onChanged: (onChanged) {},
                ),
                Spacing(height: 24),
              ],
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 0.6,
              height: SizeConverter.relativeHeight(300),
              enlargeCenterPage: true,
              onPageChanged: (index, _) {
                setState(
                  () {
                    currentIndex = index;
                  },
                );
              },
            ),
            items: list.map((i) {
              int index = list.indexOf(i);
              return Opacity(
                opacity: index == currentIndex ? 1 : 0.6,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: SizeConverter.relativeWidth(20), horizontal: 1),
                  width: SizeConverter.relativeWidth(268),
                  decoration: BoxDecoration(
                      color: AppColors.highlightColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 10)]),
                  child: Text(
                    'text $i',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
