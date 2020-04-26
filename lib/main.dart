import 'package:flutter/material.dart';
import './screens/services_screen.dart';
import './screens/login_screen.dart';
import './screens/contact_us_screen.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: LoginScreen(),

        ),
        routes: {
          ServicesScreen.routeName: (ctx) => ServicesScreen(),
          ContactUsScreen.routeName: (ctx) => ContactUsScreen()
        },
      ),
    );
  }
}
