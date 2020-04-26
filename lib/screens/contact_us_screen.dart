import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../widgets/main_scaffold.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class ContactUsScreen extends StatefulWidget {
  static const String routeName = "/contact_screen";

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  Geolocator geoLocator = Geolocator();
  Position userCurrentLocation;
  final String url = "http://chimodoshi.com/api/location.php";
  bool _isLoading = false;
  bool _statusValue = false;

  final Connectivity _connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Contact Us",
      body: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        alignment: Alignment.center,
        color: Color(0xFFFFF4F0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton.icon(
              textColor: Colors.white,
              color: Colors.red[500],
              onPressed: () {
                _getCurrentLocation().then((value) {
                  setState(() {
                    userCurrentLocation = value;
                    _statusValue = true;
                  });
                });
              },
              icon: Icon(Icons.my_location, color: Colors.white),
              label: Text(
                "Get User Location",
              ),
            ),
            userCurrentLocation != null
                ? resultText(
                    "User location: latitude:${userCurrentLocation.latitude.toString()}"
                    "\nlongitude: ${userCurrentLocation.longitude.toString()}")
                : resultText("No Location"),
            RaisedButton.icon(
              color: Colors.red[500],
              onPressed: _statusValue
                  ? () {
                      setState(() {
                        _isLoading = true;
                      });
                      _sendUserLocation().then((value) {
                        setState(() {
                          print(value);
                          _isLoading = false;
                          _showDialog("Send User Location",
                              "User current location successfully sent to the server");
                        });
                      }).catchError((value) {
                        setState(() {
                          print(value);
                          _showDialog("Server Error", "Server Can't reach");
                          _isLoading = false;
                        });
                      });
                    }
                  : null,
              icon: Icon(Icons.my_location),
              textColor: Colors.white,
              label: Text("Send User Location"),
            ),
            _isLoading ? CircularProgressIndicator() : Text(""),
          ],
        ),
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    return await geoLocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<http.Response> _sendUserLocation() {
    return http.post(
      url,
      body: json.encode({
        "lat": userCurrentLocation.latitude,
        "lon": userCurrentLocation.longitude
      }),
    );
  }

  _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }

  Widget resultText(String text) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * .6,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(fontSize: 18.0),
      ),
      decoration: BoxDecoration(
        border: Border.all(width: .5),
      ),
    );
  }
}
