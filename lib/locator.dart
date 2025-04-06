import 'package:gate_pass/data/services/web/firestore_service.dart';
import 'package:gate_pass/data/services/web/firestore_service.dart';
import 'package:gate_pass/screens/home/notification/notificaton.vm.dart';
import 'package:gate_pass/screens/home/notification/notificaton.vm.dart';
import 'package:get_it/get_it.dart';

import '../data/repository/repository.service.dart';
import '../data/services/local/cache.service.dart';
import '../data/services/local/locale.service.dart';
import '../data/services/local/navigation.service.dart';
import '../data/services/local/storage.service.dart';
import '../data/services/local/theme.service.dart';
import 'data/services/web/auth_service.dart';
import 'data/services/web/location_service.dart';
import 'data/services/web/user_service.dart';
import 'screens/auth/login/login_vm.dart';
import 'screens/auth/signup/signup_vm.dart';
import 'screens/base-vm.dart';
import 'screens/home/book/book.vm.dart';
import 'screens/home/bottom_nav/bottom_nav.vm.dart';
import 'screens/home/communities/communities.vm.dart';
import 'screens/home/history/history.vm.dart';
import 'screens/home/home.vm.dart';
import 'screens/home/home/home_screen.vm.dart';
import 'screens/home/profile/profile.home.vm.dart';


GetIt locator = GetIt.I;

setupLocator() {
  registerViewModel();
  setUpServices();
}

setUpServices(){
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<StorageService>(() => StorageService());
  locator.registerLazySingleton<Repository>(() => Repository());
  locator.registerLazySingleton<AppCache>(() => AppCache());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<FirestoreService>(() => FirestoreService());
  locator.registerLazySingleton<UserService>(() => UserService());
  locator.registerLazySingleton<ThemeModel>(() => ThemeModel());
  locator.registerLazySingleton<LocaleService>(() => LocaleService());
  locator.registerLazySingleton<LocationService>(() => LocationService());
  // locator.registerLazySingleton<ExchangeService>(() => ExchangeService(locator<Dio>()));
  // locator.registerLazySingleton<LocationViewModel>(() => LocationViewModel());
}

registerViewModel(){
  /* TODO Setup viewModels*/
  locator.registerFactory<BaseViewModel>(() => BaseViewModel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<BottomNavigationViewModel>(() => BottomNavigationViewModel());
  locator.registerFactory<HomeScreenViewModel>(() => HomeScreenViewModel());
  locator.registerFactory<BookViewModel>(() => BookViewModel());
  locator.registerFactory<HistoryViewModel>(() => HistoryViewModel());
  locator.registerFactory<ProfileHomeViewModel>(() => ProfileHomeViewModel());
  locator.registerFactory<CommunityViewModel>(() => CommunityViewModel());
  locator.registerFactory<NotificationViewModel>(() => NotificationViewModel());
}