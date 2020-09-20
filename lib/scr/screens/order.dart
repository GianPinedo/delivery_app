import 'package:flutter/material.dart';
import 'package:delivery_app/scr/helpers/style.dart';
import 'package:delivery_app/scr/models/order.dart';
import 'package:delivery_app/scr/providers/app.dart';
import 'package:delivery_app/scr/providers/user.dart';
import 'package:delivery_app/scr/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';
//import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    //final f = new DateFormat('yyyy-MM-dd hh:mm');
    //print(formatDate(DateTime(user.orders[0].createdAt), [yy, '-', M, '-', d]));
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Mis pedidos"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: ListView.builder(
          itemCount: user.orders.length,
          itemBuilder: (_, index) {
            OrderModel _order = user.orders[index];
            return ListTile(
              leading: CustomText(
                text: "S/ ${_order.total / 100}",
                weight: FontWeight.bold,
              ),
              title: Text(
                _order.description,
              ),
              subtitle: Text(
                _order.createdAt,
              ),
              trailing: CustomText(
                text: _order.status,
                color: green,
              ),
            );
          }),
    );
  }
}
