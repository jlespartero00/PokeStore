import 'package:flutter/foundation.dart';
import 'product.dart';

class CartModel extends ChangeNotifier {
  final List<_CartItem> _items = [];

  List<_CartItem> get items => List.unmodifiable(_items);

  void add(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(_CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void remove(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      remove(product);
      return;
    }
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  double get totalPrice => _items.fold(0, (total, item) => total + item.product.price * item.quantity);

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

class _CartItem {
  final Product product;
  int quantity;

  _CartItem({required this.product, required this.quantity});
}
