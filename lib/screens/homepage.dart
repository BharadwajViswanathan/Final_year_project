import 'package:flutter/material.dart';
import 'package:foodorderapp/screens/cartpage.dart';
import 'package:foodorderapp/screens/bottomnavigation.dart';
import 'package:foodorderapp/models/cart.dart'; // <-- Import Cart model

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  Cart cart = Cart(); // Initialize the Cart
  String searchQuery = ''; // For search functionality

  final List<Map<String, dynamic>> foodItems = [
    {"name": "Chicken Biryani", "cost": 55.0},
    {"name": "Mini Meals", "cost": 25.0},
    {"name": "Gobi Manchurian", "cost": 15.0},
    {"name": "Vada", "cost": 10.0},
    {"name": "Pongal", "cost": 15.0},
    {"name": "Chat", "cost": 18.0},
    {"name": "Chappathi", "cost": 8.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CanteenFood",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to CartPage and pass the cart
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: cart), // Pass the cart instance
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase(); // Update the search query
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final foodItem = foodItems[index];
                final foodName = foodItem['name'].toString().toLowerCase();

                // Filter items based on search query
                if (searchQuery.isNotEmpty && !foodName.contains(searchQuery)) {
                  return Container(); // Return empty container for unmatched items
                }

                return ListTile(
                  title: Text(foodItems[index]['name'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("cost: ${foodItems[index]['cost']}"),
                  trailing: cart.containsItem(foodItems[index]['name'])
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            cart.decreaseItemQuantity(foodItems[index]['name']);
                          });
                        },
                      ),
                      Text(cart.getItemQuantity(foodItems[index]['name']).toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            cart.addItem(foodItems[index]['name'], foodItems[index]['cost']);
                          });
                        },
                      ),
                    ],
                  )
                      : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        cart.addItem(foodItems[index]['name'], foodItems[index]['cost']);
                      });
                    },
                    child: Text("Add to Cart"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomnavigation(),
    );
  }
}