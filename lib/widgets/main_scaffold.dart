import 'package:flutter/material.dart';
import '../screens/contact_us_screen.dart';
import '../screens/services_screen.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  MainScaffold({this.body, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.red[700],
      ),
      body: body,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                width: double.infinity,
                child: Image.asset("images/chimodoshi_logo.png"),
              ),
              decoration: BoxDecoration(color: Colors.red),
            ),
            ListTile(
              enabled: false,
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            ListTile(
              enabled: false,
              leading: Icon(Icons.info_outline),
              title: Text("About us"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ContactUsScreen.routeName);
              },
              leading: Icon(Icons.contacts),
              title: Text("Contact Us"),
            ),
            ListTile(
              enabled: false,
              leading: Icon(Icons.rss_feed),
              title: Text("Blog"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ServicesScreen.routeName);
              },
              leading: Icon(Icons.cloud),
              title: Text("Service"),
            ),
            ListTile(
              enabled: false,
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
