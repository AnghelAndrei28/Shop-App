import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/widgets/app_drawer.dart';

import '../providers/cart_provider.dart' show Cart; //first option
import '../widgets/cart_item.dart' as ci;
import '../providers/oders_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
        ),
        drawer: AppDrawer(),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    OrderButton(cart),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => ci.CartItem(
                  id: cart.items.values.toList()[i].id,
                  title: cart.items.values.toList()[i].title,
                  quantity: cart.items.values.toList()[i].quantity,
                  price: cart.items.values.toList()[i].price,
                  productId: cart.items.keys.toList()[i],
                ),
              ),
            ),
          ],
        ));
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;

  OrderButton(this.cart);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isloading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: _isloading ? CircularProgressIndicator() : Text(
          'ORDER NOW',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: (widget.cart.totalAmount <= 0 || _isloading)
            ? null
            : () async {
          setState(() {
            _isloading = true;
          });
               await Provider.of<OrdersProvider>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(),
                  widget.cart.totalAmount,
                );
          setState(() {
            _isloading = false;
          });
                widget.cart.clear();
              });
  }
}
