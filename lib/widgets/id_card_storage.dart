import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IDStorageCard extends StatelessWidget {
  const IDStorageCard({
    Key? key,
    required this.icondata,
    required this.title,
    required this.usedSpace,
    required this.freeSpace,
  }) : super(key: key);

  final IconData icondata;
  final String title;
  final double usedSpace;
  final double freeSpace;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      color: Colors.white,
      elevation: 0.1,
      shadowColor: Colors.grey.shade100.withOpacity(.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(253, 250, 249, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icondata,
                  color: Color.fromRGBO(0, 192, 250, 1),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 0, right: 20),
                    child: Text(
                      title.length > 15 ? title.substring(0, 15) + ".." : title,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (usedSpace < 1000
                                  ? usedSpace.toString() + " MB"
                                  : (usedSpace / 1000).toStringAsFixed(2) +
                                      " GB") +
                              " utilisé sur ",
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Text(
                          (usedSpace + freeSpace) < 1000
                              ? (usedSpace + freeSpace).toString() + " MB"
                              : ((usedSpace + freeSpace) / 1000)
                                      .toStringAsFixed(2) +
                                  " GB",
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Sera bientôt disponible"),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Text(
                    "Détails",
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.shade500,
                  color: Color.fromRGBO(0, 195, 253, 1),
                  value: usedSpace / (usedSpace + freeSpace),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
