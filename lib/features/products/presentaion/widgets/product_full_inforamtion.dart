import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductFullInforamtion extends StatefulWidget {
  const ProductFullInforamtion({super.key});

  @override
  _ProductFullInforamtionState createState() => _ProductFullInforamtionState();
}

class _ProductFullInforamtionState extends State<ProductFullInforamtion> {
  // List<FormationModel> _formationsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            // color: Colors.blue,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg.png'), // Path to your image asset
                      fit: BoxFit.cover, // Adjust the image to cover the entire container
                    ),

                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),

                    color: Colors.amber, // Background color of the AppBar
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 40, left: 30),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.circleChevronLeft,
                            color: Colors.green,
                            size: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 80,
                  right: 80,
                  bottom: 30,
                  child: Container(
                    height: 100,
                    width: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.red,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/products.png'), // Path to your image asset
                          fit: BoxFit.contain, // Adjust the image to cover the entire container
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(color: Color.fromARGB(255, 54, 202, 54), borderRadius: BorderRadius.circular(10)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ref",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "CABMAR52",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(color: Color.fromARGB(255, 201, 207, 201), borderRadius: BorderRadius.circular(10)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Quantite desponible"),
                Text("100"),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(color: Color.fromARGB(255, 201, 207, 201), borderRadius: BorderRadius.circular(10)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("date d'ajoute"),
                Text("10/02/2024 06:25"),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
