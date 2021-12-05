import 'package:flutter/material.dart';
import 'package:pokemon_cafe/data/menu_item.dart';
import 'package:pokemon_cafe/ui/shared/xp_text.dart';
import 'package:pokemon_cafe/view_model.dart';
import 'package:scoped_model/scoped_model.dart';

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
                    userSection(),
                    pickupStoreSection(),
                    pickupOptionsSection(),
                    prepTimeSection(),
                    checkoutItemSection(model),
                    priceSection(model.cart)
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
                      Image.asset(model.cart[index].image,
                          width: 55, height: 55, fit: BoxFit.fitHeight),
                      Column(
                        children: <Widget>[
                          Text(model.cart[index].name,
                              style: CustomTextStyle.textStyleSemiBold
                                  .copyWith(fontSize: 14)),
                          const SizedBox(
                            height: 4,
                          ),
                          XPText(xp: model.cart[index].xp, fontSize: 12),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "\$${model.cart[index].price}",
                        style: CustomTextStyle.textStyleRegular
                            .copyWith(fontSize: 14),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      IconButton(
                          onPressed: () {
                            model.deletefromCard(model.cart[index]);
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  )
                ],
              ));
            },
            itemCount: model.cart.length,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }

  priceSection(List<MenuItem> cart) {
    double subTotal = cart.map((i) => i.price).toList().reduce((a, b) => a + b);
    double hst = subTotal * 0.13;
    double total = subTotal + hst;
    int xpEarned = cart.map((i) => i.xp).toList().reduce((a, b) => a + b);

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
              createPriceItem("Subtotal", "\$$subTotal"),
              createPriceItem("HST", "\$$hst"),
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
                    "\$$total",
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

  createPriceItem(String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: CustomTextStyle.textStyleRegular,
          ),
          Text(value, style: CustomTextStyle.textStyleRegular)
        ],
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
