import 'package:flutter/material.dart';
import 'package:pokemon_cafe/data/menu_item.dart';
import 'package:pokemon_cafe/data/order_item.dart';
import 'package:pokemon_cafe/ui/checkout_page.dart';
import 'package:pokemon_cafe/ui/product/amount_selector.dart';
import 'package:pokemon_cafe/ui/product/notes_field.dart';
import 'package:pokemon_cafe/ui/product/size_selector.dart';
import 'package:pokemon_cafe/ui/shared/xp_text.dart';
import 'package:pokemon_cafe/view_model.dart';
import 'package:scoped_model/scoped_model.dart';

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
  late OrderItem selectedItem;

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

  Widget _infoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        widget.menuItem.name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      )),
                  XPText(xp: widget.menuItem.xp),
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
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
        builder: (context, child, model) => Scaffold(
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
                      child: Image.network(widget.menuItem.image),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  _infoSection(context),
                  (widget.menuItem.properties['hasSizes'])
                      ? _controllerWrapper(
                          'Size option',
                          SizeSelector(
                              selection: selectedSize, callback: _onSelectSize))
                      : SizedBox(),
                  (widget.menuItem.properties['isDrink'])
                      ? _controllerWrapper(
                          'Customization options',
                          Column(
                              children: customizationOptions.entries
                                  .map((e) => AmountSelector(
                                      amount: e.value,
                                      title: e.key,
                                      callback: (updatedAmount) =>
                                          _onUpdateAddons(
                                              e.key, updatedAmount)))
                                  .toList()))
                      : SizedBox(),
                  _controllerWrapper('Additional notes',
                      NotesField(callback: (value) => notesText = value)),
                  _infoFooter()
                ]))
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  selectedItem = OrderItem(
                      widget.menuItem,
                      selectedSize,
                      customizationOptions['Sugar'],
                      customizationOptions['Cream'],
                      notesText);
                  model.addToCart(selectedItem);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CheckoutPage()));
                },
                label: Text(
                  "Add \$${widget.menuItem.price} to Cart",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ))));
  }
}
