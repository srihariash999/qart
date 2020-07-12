import 'package:get_it/get_it.dart';
import 'package:qart_assignment/models/home_page_model.dart';
import 'package:qart_assignment/services/homepage_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<HomepageService>(() => HomepageService());

  // register models
  locator.registerFactory<HomepageModel>(() => HomepageModel());
}
