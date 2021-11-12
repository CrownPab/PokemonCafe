import 'package:pokemon_cafe/data/menu_item.dart';
import 'package:scoped_model/scoped_model.dart';

class ViewModel extends Model {
  Future<List<MenuItem>> searchMenu(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    return [MenuItem('Something', 'or the other')];
  }
}
