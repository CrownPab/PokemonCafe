import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPage createState() => _CheckoutPage();
}

class _CheckoutPage extends State<CheckoutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red),
      home: Scaffold(
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
                    checkoutItemSection(),
                    priceSection()
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
                        'https://cdn3.vectorstock.com/i/1000x1000/76/82/thank-you-for-your-order-grunge-rubber-stamp-vector-38327682.jpg'),
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

  checkoutItemSection() {
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
            itemBuilder: (context, position) {
              return checkoutListItem();
            },
            itemCount: 3,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }

  checkoutListItem() {
    return Card(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Image(
                image: NetworkImage(
                    'https://globalassets.starbucks.com/assets/ca435e1035e04487b6e2fa872a1f8ba7.jpg?impolicy=1by1_wide_topcrop_630'),
                width: 45,
                height: 55,
                fit: BoxFit.fitHeight,
              ),
              Text("Peppermint Mocha",
                  style:
                      CustomTextStyle.textStyleRegular.copyWith(fontSize: 14)),
              const SizedBox(
                width: 8,
              ),
              Text(
                r'$4.50',
                style: CustomTextStyle.textStyleRegular.copyWith(fontSize: 14),
              )
            ],
          )
        ],
      ),
    );
  }

  priceSection() {
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
              createPriceItem("Subtotal", r'$12.05'),
              createPriceItem("HST", r'$1.57'),
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
                    r'$13.62',
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
