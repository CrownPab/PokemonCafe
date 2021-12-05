import 'package:pokemon_cafe/account.dart';
import 'package:pokemon_cafe/data/menu_item.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pokemon_cafe/crud.dart' as crud;

class ViewModel extends Model {
  ViewModel.initialize() {
    crud.initializeFirebase();
  }

  String? id;
  Future<List<MenuItem>> searchMenu(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    return [MenuItem('Something', 'or the other')];
  }

  Future<Account?> getAccount() async {
    return await crud.getAccount(id ?? "E09hPBjLbidu4gHF4KxH");
  }
}
