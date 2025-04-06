import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gate_pass/data/services/web/auth_service.dart';
import 'package:gate_pass/data/services/web/auth_service.dart';
import 'package:gate_pass/data/services/web/firestore_service.dart';
import 'package:gate_pass/data/services/web/firestore_service.dart';
import 'package:gate_pass/data/services/web/location_service.dart';
import 'package:gate_pass/data/services/web/location_service.dart';

import '../../locator.dart';
import '../services/local/navigation.service.dart';
import '../services/local/storage.service.dart';
import '../services/web/user_service.dart';


UserService userService = locator<UserService>();
AuthService authService = locator<AuthService>();
FirestoreService firestoreService = locator<FirestoreService>();
StorageService storageService = locator<StorageService>();
NavigationService navigationService = locator<NavigationService>();
LocationService locationService = locator<LocationService>();

// CALLING THE DOT ENV FILE
String get baseUrl => dotenv.env['BASE_URL']!;
String get productionBaseUrl => dotenv.env['PRODUCTION_BASE_URL']!;
String get publicKey => dotenv.env['FLW_PUBLIC_KEY']!;
String get secretKey => dotenv.env['FLW_SECRET_KEY']!;