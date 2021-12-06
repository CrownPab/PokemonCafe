import 'package:flutter/material.dart';
import 'package:pokemon_cafe/ui/search_page.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferedSize;
  SearchBar({Key? key})
      : preferedSize = const Size.fromHeight(60),
        super(key: key);

  @override
  _SearchBar createState() => _SearchBar();

  @override
  Size get preferredSize => preferedSize;
}

class _SearchBar extends State<SearchBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _alpha;

  final TextEditingController _textController = TextEditingController();
  FocusNode keyboardFocus = FocusNode();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    isSearching = false;
    keyboardFocus = FocusNode();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _alpha = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    keyboardFocus.dispose();
    super.dispose();
  }

  int get _opacityValue => 255 - (255 * _alpha.value).toInt();

  void _submitSearch(String query, BuildContext context) {
    if (query != '') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SearchPage(query: query)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                'Pokemon Cafe',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(Theme.of(context)
                        .primaryColorDark
                        .withAlpha(_opacityValue)
                        .value)),
              ),
            ),
           /*IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                enableFeedback: !_controller.isCompleted,
                color: Colors.black.withAlpha(_opacityValue),
                onPressed: () {
                  if (!_controller.isCompleted) {
                    _controller.forward();
                    FocusScope.of(context).requestFocus(keyboardFocus);
                  }
                })
          */
          ],
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * (1 - _alpha.value) +
              MediaQuery.of(context).size.width * 0.035,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.93,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  onPressed: () => (_textController.text == "")
                      ? () {
                          _controller.reverse();
                          FocusScope.of(context).unfocus();
                        }()
                      : _textController.clear(),
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    focusNode: keyboardFocus,
                    onSubmitted: (value) => _submitSearch(value, context),
                    decoration: const InputDecoration(
                        hintText: "Search for Menu Items",
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white),
          ),
        ),
      ]),
    );
  }
}
