import 'package:devti_agro/features/products/presentaion/widgets/product_full_inforamtion.dart';
import 'package:flutter/material.dart';

class ListProductsWidget extends StatelessWidget {
  const ListProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductFullInforamtion()),
        );
      },
      child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(color: const Color(0xffF5F5F5), borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  image: const DecorationImage(
                      image: AssetImage(
                        "assets/images/products.png",
                      ),
                      fit: BoxFit.contain)),
            ),
            title: const Text(
              "Products 1",
              style: TextStyle(color: Colors.black),
            ),
            subtitle: const Text(
              "03 act 2024(06:21)",
              style: TextStyle(color: Color.fromARGB(113, 0, 0, 0)),
            ),
            trailing: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: const Color.fromARGB(132, 76, 175, 79), borderRadius: BorderRadius.circular(50), border: Border.all(color: const Color.fromARGB(255, 29, 105, 31))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("1010"),
                ],
              ),
            ),
          )),
    );
  }
}
