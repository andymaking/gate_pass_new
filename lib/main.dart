import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gate_pass/firebase_options.dart';
import 'package:gate_pass/screens/splash/splash_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'data/cache/config.dart';
import 'data/services/local/locale.service.dart';
import 'data/services/local/navigation.service.dart';
import 'data/services/local/theme.service.dart';
import 'locator.dart';
import 'styles/app_style.dart';


Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await dotenv.load(fileName: ".env");
  await GetStorage.init();

  await setupLocator();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  //setup different deployment environment
  Config.appFlavor = Flavor.DEVELOPMENT;

  // Initialize and check login Status
  await locator<LocaleService>().init();


  runApp(const MyApp());
      (dynamic error, dynamic stack) {
    if (kDebugMode) {
      print(error);
      print(stack);
    }
  };
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> configureLocalization() async {
    // Listen for changes in language
    locator<LocaleService>().addListener(_onLanguageChanged);
    // Set initial locale
    await _onLanguageChanged();
  }

  Future<void> _onLanguageChanged() async {
    // Update UI when language changes
    setState(() {});
  }

  init()async{
    FocusManager.instance.primaryFocus?.unfocus();
    await configureLocalization();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    final localeService = LocaleService();
    // ... Use the service
    localeService.dispose(); // Clean up when done
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer<ThemeModel>(
            builder: (context, themeProvider, child) {
              return OKToast(
                  child: ScreenUtilInit(
                    //setup to fit into bigger screens
                    designSize: const Size(390, 844),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (BuildContext context, Widget? child) {
                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        navigatorKey: locator<NavigationService>().navigatorKey,
                        scaffoldMessengerKey: locator<NavigationService>().snackBarKey,
                        title: "Gate Pass",
                        theme: Styles.themeData(isDark: false),
                        // onGenerateRoute: Routers.generateRoute,
                        supportedLocales: locator<LocaleService>().localization.supportedLocales,
                        localizationsDelegates: locator<LocaleService>().localization.localizationsDelegates,
                        home: const SplashScreen(),
                      );
                    },
                  ));
            }
        )
    );
  }
}


