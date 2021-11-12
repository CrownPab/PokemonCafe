import 'package:flutter/material.dart';
import 'package:pokemon_cafe/ui/checkout_page.dart';
import 'package:pokemon_cafe/ui/menu_page.dart';
import 'package:pokemon_cafe/ui/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _navigationIndex = 0;

  void _onNavigationTap(int index) {
    setState(() {
      _navigationIndex = index;
    });
  }

  Widget _pageSelector() {
    switch (_navigationIndex) {
      case 0:
        return MenuPage();
      case 1:
        return CheckoutPage();
      default:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageSelector(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Order')
        ],
        currentIndex: _navigationIndex,
        onTap: _onNavigationTap,
      ),
    );
  }
}
