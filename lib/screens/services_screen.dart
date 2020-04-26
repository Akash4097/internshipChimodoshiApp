import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/services_dummy_data.dart';
import '../widgets/main_scaffold.dart';

class ServicesScreen extends StatelessWidget {
  static const String routeName = "/service_screen";
  final List<Map<String, String>> serviceDummyData =
      ServiceScreenDummyData().serviceCardData;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Services",
      body: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 16.0),
        color: Color(0xFFFFF4F0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                alignment: AlignmentDirectional.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "What we offer",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF47d8ca),
                        ),
                      ),
                    ),
                    Text("Our Services",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.w700),
                        )),
                    Text(
                      "Whether it’s a medical emergency, need of restrooms or restaurant or\n"
                      "any transport related issues or any other emergency we are here for you.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        textStyle:
                            TextStyle(fontSize: 16.0, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                width: double.infinity,
              ),
              Wrap(
                spacing: 18.0,
                runSpacing: 18.0,
                children: serviceDummyData.map((data) {
                  return servicesCard(context, data["image"], data["title"],
                      data["description"]);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget servicesCard(
      BuildContext context, String image, String title, String description) {
    return Container(
      padding: EdgeInsets.all(12.0),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: .5),
          borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(
            image: AssetImage(image),
          ),
          Text(
            title,
            style: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(fontSize: 14.0),
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Material(
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Read More",
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.height * .6,
    );
  }
}
