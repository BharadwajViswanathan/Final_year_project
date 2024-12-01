import 'package:flutter/material.dart';
import 'package:foodorderapp/models/cart.dart'; // <-- Import Cart model

class CartPage extends StatelessWidget {
  final Cart cart;

  CartPage({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return Dismissible(
                    key: Key(item.name),
                    background: Container(color: Colors.red),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      // Remove item from cart
                      cart.removeItem(item.name);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${item.name} removed from cart")),
                      );
                    },
                    child: CartItemWidget(
                      name: item.name,
                      cost: item.cost,
                      quantity: item.quantity,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total (${cart.totalItems} items): ${cart.totalCost} INR',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Proceed to buy logic
                },
                child: Text('Proceed to Buy'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.pinkAccent,
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final String name;
  final double cost;
  final int quantity;

  CartItemWidget({
    required this.name,
    required this.cost,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Cost: $cost'),
            ],
          ),
          Text('x$quantity'),
        ],
      ),
    );
  }
}
