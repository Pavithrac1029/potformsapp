
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potformsapp/AUTH/auth_service.dart';
import 'package:potformsapp/BASE%20URL/api.dart';
import 'package:potformsapp/HOME_PAGE/home_page.dart';
import 'package:potformsapp/LOGIN_NEW/login_view.dart';
import 'package:potformsapp/LOGIN_NEW/login_view_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       // ChangeNotifierProvider(create: (_) => MyAuthService()),
        ChangeNotifierProvider(create: (_) => Baseurl()),
        ChangeNotifierProvider(create: (_) => LoginController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: FontGlobal.theme(context),
        home: Loginview(),
      ),
    );
  }
}

class FontGlobal {
  static ThemeData theme(BuildContext context) => ThemeData(
      fontFamily: "Poppins",
      timePickerTheme: TimePickerThemeData(
        backgroundColor: Colors.white,
        hourMinuteShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: Color(0xff27437A), width: 4),
        ),
        dayPeriodBorderSide: const BorderSide(color: Colors.teal, width: 4),
        dayPeriodColor: Colors.blueGrey.shade600,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: Colors.teal, width: 4),
        ),
        dayPeriodTextColor: Colors.white,
        dayPeriodShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: Colors.teal, width: 4),
        ),
        hourMinuteColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? Colors.teal
                : Colors.blueGrey.shade800),
        hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? Colors.white
                : Colors.teal),
        dialHandColor: Colors.blueGrey.shade700,
        dialBackgroundColor: Colors.blueGrey.shade800,
        hourMinuteTextStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        dayPeriodTextStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        helpTextStyle: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
        ),
        dialTextColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? Colors.teal
                : Colors.white),
        entryModeIconColor: Colors.teal,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity);
}
