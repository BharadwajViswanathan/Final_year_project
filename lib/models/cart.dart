class CartItem {
  final String name;
  final double cost;
  int quantity;
  final String image;

  CartItem({required this.name, required this.cost,required this.image, this.quantity = 1});
}

class Cart {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(String name, double cost) {
    var existingItem = _items.firstWhere((item) => item.name == name, orElse: () => CartItem(name: '', cost: 0.0, image: ''));

    if (existingItem.name != '') {
      existingItem.quantity++;
    } else {
      _items.add(CartItem(name: name, cost: cost, image: ''));
    }
  }

  void decreaseItemQuantity(String name) {
    var existingItem = _items.firstWhere((item) => item.name == name);

    if (existingItem.quantity > 1) {
      existingItem.quantity--;
    } else {
      _items.remove(existingItem);
    }
  }

  bool containsItem(String name) {
    return _items.any((item) => item.name == name);
  }

  int getItemQuantity(String name) {
    return _items.firstWhere((item) => item.name == name).quantity;
  }

  void removeItem(String name) {
    _items.removeWhere((item) => item.name == name);
  }

  double get totalCost {
    return _items.fold(0, (total, item) => total + (item.cost * item.quantity));
  }

  int get totalItems {
    return _items.fold(0, (total, item) => total + item.quantity);
  }

  void clearCart() {
    _items.clear();
  }
}
