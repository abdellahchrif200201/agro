import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/features/products/presentaion/widgets/list_products_widget.dart';
import 'package:devti_agro/generated/l10n.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).products,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leadingWidth: 80,
      ),
      drawer: CustomDrawer(
        currentRoute: S.of(context).products,
      ),
      body: const SingleChildScrollView(
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
          ],
        ),
      ),
    );
  }
}
