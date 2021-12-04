import 'package:flutter/material.dart';
import 'package:pokemon_cafe/data/menu_item.dart';
import 'package:pokemon_cafe/ui/product/size_selector.dart';

class ProductPage extends StatefulWidget {
  final MenuItem menuItem;
  final String collectionName;
  ProductPage({Key? key, required this.menuItem, this.collectionName = ""})
      : super(key: key);
  _ProductPage createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> {
  int selectedSize = 1;

  void _onSelectSize(int index) {
    setState(() {
      selectedSize = index;
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
        Divider()
      ],
    );
  }

  Widget _infoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.menuItem.name,
              textAlign: TextAlign.left,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )),
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
                      selection: selectedSize, callback: _onSelectSize))
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
