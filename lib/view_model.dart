import 'package:pokemon_cafe/account.dart';
import 'package:pokemon_cafe/auth.dart';
import 'package:pokemon_cafe/data/menu_item.dart';
import 'package:pokemon_cafe/data/order_item.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pokemon_cafe/crud.dart' as crud;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ViewModel extends Model {
  String? id;
  Auth? auth;
  Account? currentAccount;
  List<OrderItem> cart = [];
  ViewModel.initialize() {
    crud.initializeFirebase().then((value) {
      auth = Auth();
      notifyListeners();
    });
  }
  Function? onSignOut;

  final Map<String, OrderItem> _allItems = {
    // '000000': MenuItem(
    //     '000000',
    //     'PikaChino',
    //     'Dark, rich espresso lies in wait under a smoothed and stretched layer of thick milk foam. An alchemy of barista artistry and craft.',
    //     'assets/images/coffee-cup.png',
    //     4.00,
    //     100,
    //     <String>['Milk', 'Brewed Espresso']),
    // '000001': MenuItem(
    //     '000001',
    //     'Ampharos Americano',
    //     'Espresso shots topped with hot water create a light layer of crema culminating in this wonderfully rich cup with depth and nuance.',
    //     'assets/images/coffee-cup.png',
    //     3.00,
    //     100,
    //     <String>['Water', 'Brewed Espresso']),
    // '000002': MenuItem(
    //     '000002',
    //     'Lapras Latte',
    //     'Our dark, rich espresso balanced with steamed milk and a light layer of foam. A perfect milk-forward warm-up.',
    //     'assets/images/coffee-cup.png',
    //     4.00,
    //     100,
    //     <String>['Milk', 'Brewed Espresso']),
    // '000003': MenuItem(
    //     '000003',
    //     'Snorlax\'s Decaf',
    //     'Espresso shots topped with hot water create a light layer of crema culminating in this wonderfully rich cup with depth and nuance.',
    //     'assets/images/coffee-cup.png',
    //     4.00,
    //     100,
    //     <String>['Milk', 'Brewed Espresso']),
    // '000004': MenuItem(
    //     '000004',
    //     'Articuno\'s Iced Coffee',
    //     'Freshly brewed Iced Coffee Blend served chilled and sweetened over ice. An absolutely, seriously, refreshingly lift to any day.',
    //     'assets/images/coffee-cup.png',
    //     4.00,
    //     100,
    //     <String>['Ice', 'Brewed Espresso', 'Classic Syrup']),
    // '000005': MenuItem(
    //     '000005',
    //     'Jiggly Puff Cold Brew',
    //     'Our slow-steeped custom blend of Cold Brew coffee accented with vanilla and topped with a delicate float of house-made vanilla sweet cream that cascades throughout the cup. It\'s over-the-top and super-smooth.',
    //     'assets/images/coffee-cup.png',
    //     4.00,
    //     100,
    //     <String>['Ice', 'Sweet Cream', 'Brewed Coffee', 'Classic Syrup']),
  };
  Future<List<OrderItem>> searchMenu(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    return [_allItems['000000']!];
  }

  Future<List<MenuItem>> getAllMenuItems() async {
    return await crud.getAllMenuItems();
  }

  Future<Account?> getAccount() async {
    if (auth != null) {
      Account? account = await crud.getAccount(auth!.uid);
      currentAccount = account;
      return account;
    }
  }

  Future<Account?> createAccount(Account account) async {
    await crud.createAccount(account);
    currentAccount = account;
    return account;
  }

  void addToCart(OrderItem item) {
    cart.add(item);
  }

  void deletefromCart(OrderItem item) {
    cart.remove(item);
    notifyListeners();
  }
}
