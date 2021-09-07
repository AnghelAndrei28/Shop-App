import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/oders_provider.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import '../widgets/order_item.dart' as Item;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(context, listen: false)
            .fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer<OrdersProvider>(builder: (ctx, orderData, child) => ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, i) => Item.OrderItem(orderData.orders[i]),
              ));
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
