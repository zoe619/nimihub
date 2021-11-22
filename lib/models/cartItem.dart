import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String type;

  CartItem(
      {@required this.id,
        @required this.name,
        @required this.quantity,
        @required this.price,
        @required this.type
      });
}

class CartMain with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items
  {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  bool addItem(String pdtid, String name, double price, String type)
  {
    if (_items.containsKey(pdtid))
    {
      return false;
//      _items.update(
//          pdtid,
//              (existingCartItem) => CartItem(
//              id: pdtid,
//              name: existingCartItem.name,
//              quantity: existingCartItem.quantity + 1,
//              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          pdtid,
              () => CartItem(
            name: name,
            id: pdtid,
            quantity: 1,
            price: price,
            type: type
          ));

    }
    notifyListeners();
    return true;
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity > 1) {
      _items.update(
          id,
              (existingCartItem) => CartItem(
              id: DateTime.now().toString(),
              name: existingCartItem.name,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price));
    }
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}