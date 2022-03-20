// ignore_for_file: prefer_const_constructors

import 'package:file_manager_app/contants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../future_func.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "profile_page",
      child: Scaffold(
        backgroundColor: crgb(244, 247, 250),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                image: DecorationImage(
                  image: AssetImage("images/img1.jpg"),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: col_aud,
                  width: 5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Spacer(),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Max Andy",
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: crgb(30, 30, 50),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: crgb(244, 247, 250),
                                borderRadius: BorderRadius.circular(55.0),
                              ),
                              child: IconButton(
                                splashRadius: 10,
                                constraints: BoxConstraints.tightForFinite(
                                  width: 30,
                                  height: 30,
                                ),
                                padding: const EdgeInsets.all(0),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.check_circle,
                                  color: col_aud,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        GetStorageItems.length.toString() + " éléments trouvés",
                        style: GoogleFonts.nunito(
                          fontSize: 22,
                          color: crgb(30, 30, 50),
                        ),
                      ),
                      titleWidget(title: "Vos activités"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget titleWidget({required String title}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 15),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 5,
            ),
            child: Text(
              title,
              style: GoogleFonts.nunito(
                fontSize: 22,
                color: crgb(30, 30, 50),
              ),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                subtitle: Text("Il y a 3 min"),
                leading: Icon(Icons.history),
                title: Text("Activité récente " + index.toString()),
              );
            },
            itemCount: 4,
          )
        ],
      ),
    ),
  );
}
