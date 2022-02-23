import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/app_drawer.dart';
import '/providers/orders.dart' show Orders;
import '/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orders-screen";
  const OrdersScreen();

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => OrderItem(
          orderData.orders[index],
        ),
      ),
    );
  }
}
