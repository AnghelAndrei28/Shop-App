import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
        ),
        body: ProductsGrid());
  }
}
