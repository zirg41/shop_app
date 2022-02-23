import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/app_drawer.dart';
import '/providers/orders.dart' show Orders;
import '/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orders-screen";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;

  Future _obtainOrdersfuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersfuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your orders"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _ordersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.error != null) {
                // Error handling
                return Center(
                  child: Text("An error occured!"),
                );
              } else {
                return Consumer<Orders>(
                  builder: (context, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (context, index) =>
                        OrderItem(orderData.orders[index]),
                  ),
                );
              }
            }
          },
        ));
  }
}
