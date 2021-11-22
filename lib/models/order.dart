
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nimihub_online/models/cartItem.dart';
import 'dart:convert';
import './cartItem.dart';
import 'package:flutter/material.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<String> addOrder(List<CartItem> cartProducts, double total, String name, String email) async
  {
//    final url = 'https://nimi-hub-default-rtdb.firebaseio.com//orders.json';
    final url = 'https://fetch.nimihub.com/dele/api/services/new_mobile/pizza/order.php';

    try {

      var map = Map<String, dynamic>();

      var data =  json.encode({
      'user': name,
        'email': email,
      'total': total,
      'products': cartProducts
          .map((cp) => {
      'id': cp.id,
      'title': cp.name,
      'quantity': cp.quantity,
      'price': cp.price,
       'type':cp.type
      }).toList()});
      map['cart'] = jsonEncode(data);
      map['identity'] = email;



      final response = await http.post(url, headers: {"Accept": "application/json"},
          body: map);

      notifyListeners();
      return json.decode(response.body);



    }
    catch (err)
    {
      print(err);
      throw err;
    }
  }
}