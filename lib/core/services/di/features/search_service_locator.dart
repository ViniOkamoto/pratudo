import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/features/screens/main/widgets/filter_modal/filter_store.dart';
import 'package:pratudo/features/screens/search_by_ingredient/search_by_ingredient_store.dart';

Future<void> setupSearchLocator() async {
  serviceLocator.registerFactory<SearchByIngredientStore>(
    () => SearchByIngredientStore(),
  );

  serviceLocator.registerFactory<FilterStore>(
    () => FilterStore(),
  );
}
