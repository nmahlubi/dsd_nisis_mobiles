import 'dart:async';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/case.dart';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_access_to_healthServices/access_to_health_services.dart';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_access_to_socialServies/access_to_social_services.dart';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_access_to_vitalRegistration/access_to_vital_registration.dart';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_household_level_questions/level_asks_questions.dart';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_skills_employment_and_smallBusiness/skills_employment_and_small_business.dart';
import 'package:flutter/material.dart';
import 'domain/repository/authenticate/authenticate_repository.dart';
import 'domain/repository/authenticate/roles/nisis_role_repository.dart';
import 'pages/authenticate/login_authenticate.dart';
import 'sessions/session.dart';
import 'sessions/session_manager.dart';
import 'util/palette.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

final _authenticateRepository = AuthenticateRepository();
final _nisisRoleRepository = NisisRoleRepository();

Future<void> main() async {
  // var appDocDir = await getApplicationDocumentsDirectory();
  WidgetsFlutterBinding.ensureInitialized();
  await _authenticateRepository.initialize(); //1
  await _nisisRoleRepository.initialize(); //1

  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  Session session = Session();

  //Session session = Session();
  StreamController streamController = StreamController();

  void redirectToLoginPage() {
    if (globalNavigatorKey.currentContext != null) {
      Navigator.pop(globalNavigatorKey.currentContext!);
      Navigator.push(
          globalNavigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) =>
                  const LoginAuthenticatePage(title: "Login Page")));
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (globalNavigatorKey.currentContext != null) {
      session.startListener(
          streamController: streamController,
          context: globalNavigatorKey.currentContext!);
    }

    return SessionManager(
      onSessionTimeExpired: () {
        if (globalNavigatorKey.currentContext != null &&
            session.enableLoginPage == true) {
          ScaffoldMessenger.of(globalNavigatorKey.currentContext!)
              .showSnackBar(SnackBar(
                  content: Container(
            color: Colors.black,
            child: const Text(
              'Session Expired',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )));
          redirectToLoginPage();
        }
      },
      //active time 5000= 5 minutes
      duration: const Duration(seconds: 1000),
      streamController: streamController,
      child: MaterialApp(
        title: 'NISIS',
        navigatorKey: globalNavigatorKey,
        theme: ThemeData(primarySwatch: Palette.kToDark),
        routes: {
          '/': (context) =>
               const LoginAuthenticatePage(title: 'Authentification')

        },
      ),
    );
  }
}
