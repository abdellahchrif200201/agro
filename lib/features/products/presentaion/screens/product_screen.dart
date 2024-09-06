import 'package:devti_agro/features/products/presentaion/widgets/list_products_widget.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("4 products"),
            ),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
            ListProductsWidget(),
          ],
        ),
      ),
    );
  }
}
