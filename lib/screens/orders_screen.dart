import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/oders_provider.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import '../widgets/order_item.dart' as Item;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders'),),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => Item.OrderItem(orderData.orders[i]),
      ),
      drawer: AppDrawer(),
    );
  }
}
