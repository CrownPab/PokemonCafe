import 'package:flutter/material.dart';
import 'package:pokemon_cafe/data/menu_item.dart';
import 'package:pokemon_cafe/data/order_item.dart';
import 'package:pokemon_cafe/ui/menu_page.dart';
import 'package:pokemon_cafe/ui/shared/xp_text.dart';
import 'package:pokemon_cafe/ui/store_location_page.dart';
import 'package:pokemon_cafe/view_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPage createState() => _CheckoutPage();
}

class _CheckoutPage extends State<CheckoutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
      builder: (context, child, model) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            "Review Order",
          ),
        ),
        body: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    if (model.cart.isNotEmpty) ...[
                      userSection(),
                      pickupStoreSection(),
                      pickupOptionsSection(),
                      prepTimeSection(),
                      checkoutItemSection(model),
                      priceSection(model.cart)
                    ] else ...[
                      userSection(),
                      pickupStoreSection(),
                      pickupOptionsSection(),
                      startOrderSection(),
                    ]
                  ],
                ),
                flex: 90,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: RaisedButton(
                    onPressed: () {
                      showThankYouBottomMessage(context);
                      model.onCheckout(context);
                    },
                    child: const Text(
                      "Place Order",
                    ),
                    color: Colors.red[800],
                    textColor: Colors.white,
                  ),
                ),
                flex: 10,
              )
            ],
          );
        }),
      ),
    );
  }

  showThankYouBottomMessage(BuildContext context) {
    return _scaffoldKey.currentState!.showBottomSheet(
      (context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: const <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: NetworkImage(
                        'https://i.pinimg.com/474x/c5/61/b5/c561b5c2ca8093f1e5c77239232b57f8.jpg'),
                    width: 250,
                  ),
                ),
                flex: 5,
              ),
            ],
          ),
        );
      },
      backgroundColor: Colors.white,
    );
  }

  userSection() {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Kelly Pham",
                    style: CustomTextStyle.textStyleSemiBold
                        .copyWith(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickupStoreSection() {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Card(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Pickup store",
                    style: CustomTextStyle.textStyleSemiBold
                        .copyWith(fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Winchester and Simcoe ~ 2.5 km",
                    style: CustomTextStyle.textStyleSemiBold,
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickupOptionsSection() {
    List<bool> isSelected = [true, false];

    return Container(
      margin: const EdgeInsets.all(4),
      child: Card(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding:
              const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Pickup options",
                    style: CustomTextStyle.textStyleSemiBold
                        .copyWith(fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              ToggleButtons(
                color: Colors.black,
                selectedColor: Colors.white,
                borderColor: Colors.grey,
                fillColor: Colors.red[300],
                selectedBorderColor: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                children: const <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 60, top: 8, right: 60, bottom: 8),
                    child: Text(
                      "In store",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 60, top: 8, right: 60, bottom: 8),
                    child: Text(
                      "Drive-thru",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                  });
                },
                isSelected: isSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }

  prepTimeSection() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: 1,
            onChanged: (isChecked) {},
            activeColor: Colors.red[400],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Prep time: 4 - 10 min",
                style: CustomTextStyle.textStyleSemiBold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  checkoutItemSection(ViewModel model) {
    List<String> sizes = ["Small", "Medium", "Large"];

    return Container(
      margin: const EdgeInsets.all(4),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Colors.grey.shade200)),
            padding:
                const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.network(model.cart[index].menuItem.image,
                              width: 55, height: 55, fit: BoxFit.fitHeight),
                          Column(
                            children: <Widget>[
                              Text(model.cart[index].menuItem.name,
                                  style: CustomTextStyle.textStyleSemiBold
                                      .copyWith(fontSize: 14)),
                              const SizedBox(
                                height: 4,
                              ),
                              XPText(
                                  xp: model.cart[index].menuItem.xp,
                                  fontSize: 12),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(sizes[model.cart[index].size],
                                  style: CustomTextStyle.textStyleRegular),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                  model.cart[index].sugar.toString() + " Sugar",
                                  style: CustomTextStyle.textStyleRegular),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                  model.cart[index].cream.toString() + " Cream",
                                  style: CustomTextStyle.textStyleRegular),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(model.cart[index].notes,
                                  style: CustomTextStyle.textStyleRegular),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "\$${model.cart[index].menuItem.price}",
                            style: CustomTextStyle.textStyleRegular
                                .copyWith(fontSize: 14),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          IconButton(
                              onPressed: () {
                                model.deletefromCart(model.cart[index]);
                              },
                              icon: const Icon(Icons.delete))
                        ])
                  ],
                ));
              },
              itemCount: model.cart.length,
              shrinkWrap: true,
            )),
      ),
    );
  }

  priceSection(List<OrderItem> cart) {
    double subTotal =
        cart.map((i) => i.menuItem.price).toList().reduce((a, b) => a + b);
    double hst = subTotal * 0.13;
    double total = subTotal + hst;
    int xpEarned =
        cart.map((i) => i.menuItem.xp).toList().reduce((a, b) => a + b);

    return Container(
      margin: const EdgeInsets.all(4),
      child: Card(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding:
              const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 4,
              ),
              Text(
                "PRICE DETAILS",
                style: CustomTextStyle.textStyleRegular,
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "XP Earned",
                    style: CustomTextStyle.textStyleRegular,
                  ),
                  XPText(xp: xpEarned, fontSize: 12)
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Subtotal",
                    style: CustomTextStyle.textStyleRegular,
                  ),
                  Text(
                    "\$${double.parse((subTotal).toStringAsFixed(2))}",
                    style: CustomTextStyle.textStyleRegular,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "HST",
                    style: CustomTextStyle.textStyleRegular,
                  ),
                  Text(
                    "\$${double.parse((hst).toStringAsFixed(2))}",
                    style: CustomTextStyle.textStyleRegular,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: CustomTextStyle.textStyleBold.copyWith(fontSize: 14),
                  ),
                  Text(
                    "\$${double.parse((total).toStringAsFixed(2))}",
                    style: CustomTextStyle.textStyleBold.copyWith(fontSize: 14),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  startOrderSection() {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Card(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding:
              const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 4,
              ),
              Text(
                "Start your order",
                style: CustomTextStyle.textStyleSemiBold.copyWith(fontSize: 14),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "As you add menu items, they'll appear here. You'll have a chance to review before placing your order.",
                style: CustomTextStyle.textStyleRegular,
              ),
              const SizedBox(
                height: 8,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red[400],
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  onPressed: () {
                    // causes problems with bottom navigaton
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: const Text("Add items")),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextStyle {
  static var textStyleRegular = const TextStyle(
      fontFamily: "Helvetica",
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 12);

  static var textStyleSemiBold =
      textStyleRegular.copyWith(fontWeight: FontWeight.w600);

  static var textStyleBold =
      textStyleRegular.copyWith(fontWeight: FontWeight.w700);
}
