import 'package:flutter/material.dart';
import 'package:nimihub_online/models/cartItem.dart';
import 'package:provider/provider.dart';


class CartPdt extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String name;

  CartPdt(this.id, this.productId, this.price, this.quantity, this.name);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        Provider.of<CartMain>(context, listen: false).removeItem(productId);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$$price')),
          ),
          title: Text(name),
          subtitle: Text('Total: \NGN${(price * quantity)}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
