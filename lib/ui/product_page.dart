import 'package:flutter/material.dart';
import 'package:pokemon_cafe/data/menu_item.dart';
import 'package:pokemon_cafe/ui/product/amount_selector.dart';
import 'package:pokemon_cafe/ui/product/notes_field.dart';
import 'package:pokemon_cafe/ui/product/size_selector.dart';
import 'package:pokemon_cafe/ui/shared/xp_text.dart';

class ProductPage extends StatefulWidget {
  final MenuItem menuItem;
  final String collectionName;
  ProductPage({Key? key, required this.menuItem, this.collectionName = ""})
      : super(key: key);
  _ProductPage createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> {
  int selectedSize = 1;
  String notesText = "";
  Map<String, int> customizationOptions = {
    'Sugar': 1,
    'Cream': 1,
  };

  void _onSelectSize(int index) {
    setState(() {
      selectedSize = index;
    });
  }

  void _onUpdateAddons(String key, int amount) {
    setState(() {
      customizationOptions[key] = amount;
    });
  }

  Widget _controllerWrapper(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            )),
        const SizedBox(
          height: 10,
        ),
        child,
        const SizedBox(
          height: 10,
        ),
        const Divider()
      ],
    );
  }

  Widget _infoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.menuItem.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  XPText(widget.menuItem.xp),
                ])),
        Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              widget.menuItem.description,
              textAlign: TextAlign.left,
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            )),
        const Divider()
      ],
    );
  }

  Widget _infoFooter() {
    return Container(
        color: Colors.red,
        child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: _controllerWrapper(
                'Ingredients',
                Container(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 70.0),
                    child: Text(widget.menuItem.ingredients.join(', '))))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              floating: true,
              actions: const [
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.white,
                    ))
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.menuItem.id + widget.collectionName + 'image',
                  child: Image.asset(widget.menuItem.image),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              _infoSection(),
              _controllerWrapper(
                  'Size option',
                  SizeSelector(
                      selection: selectedSize, callback: _onSelectSize)),
              _controllerWrapper(
                  'Customization options',
                  Column(
                      children: customizationOptions.entries
                          .map((e) => AmountSelector(
                              amount: e.value,
                              title: e.key,
                              callback: (updatedAmount) =>
                                  _onUpdateAddons(e.key, updatedAmount)))
                          .toList())),
              _controllerWrapper('Additional notes',
                  NotesField(callback: (value) => notesText = value)),
              _infoFooter()
            ]))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: null,
            label: Text(
              "Add \$${widget.menuItem.price} to Cart",
              style: const TextStyle(fontWeight: FontWeight.bold),
            )));
  }
}
