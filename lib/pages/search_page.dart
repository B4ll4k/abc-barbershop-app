import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isSearch = false;

  final TextEditingController _searchTxtBoxController =
      TextEditingController(text: "Search");
  final Map<String, dynamic> _hairStyles = {
    "Mid Fade": "corte1.jpg",
    "High Fade": "corte2.jpg",
    "Caesar": "corte3.jpg",
    "Fringe": "corte4.jpg",
    "Line Up": "corte5.jpg",
    "Maxi Tupé": "corte6.jpg",
    "Military Style": "corte7.jpg",
    "Spiky": "corte8.jpg",
    "Quiff": "corte9.jpg",
    "Undercut": "corte10.jpg",
    "Rizado": "rizado.jpg",
    "Hair and Beard": "hairandbeard.jpg",
    "Hair Color": "haircoloring.jpg",
  };

  List<String> _hairStyleNames = [];

  @override
  void initState() {
    _hairStyleNames = _hairStyles.keys.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 20.0, top: 10.0),
            child: Text(
              'Search',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 0.0,
        ),
        body: ListView(
          children: <Widget>[
            _buildSearchBar(),
            _popularesBuscador(),
          ],
        ));
  }

  Widget _buildSearchBar() {
    return Container(
      height: getProportionateScreenHeight(50),
      margin: EdgeInsets.all(SizeConfig.screenWidth * 0.03),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black38.withAlpha(9),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onTap: () {
                setState(() {
                  //_hairStyleNames = [];
                });
              },
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.red),
                hintText: "Search",
                hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.secondary),
                border: InputBorder.none,
              ),
              onChanged: (String keyword) {
                if (keyword.isEmpty) {
                  setState(() {
                    _hairStyleNames = _hairStyles.keys.toList();
                  });
                } else {
                  setState(() {
                    _hairStyleNames = _hairStyles.keys
                        .where((element) => element
                            .toLowerCase()
                            .contains(keyword.toLowerCase()))
                        .toList();
                  });
                }
              },
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isSearch = !_isSearch;
              });
            },
            icon: Icon(
              _isSearch ? Icons.close : Icons.search,
              color: Theme.of(context).colorScheme.secondary,
            ),
          )
        ],
      ),
    );
  }

  Widget _popularesBuscador() {
    return Container(
      height: SizeConfig.screenHeight * 0.8,
      child: ListView.builder(
        itemCount: _hairStyleNames.length,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.84,
              height: getProportionateScreenHeight(200),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.45), BlendMode.multiply),
                      image: AssetImage(
                          'assets/images/${_hairStyles[_hairStyleNames[index]]}'),
                      fit: BoxFit.cover),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 5.0),
                        blurRadius: 4.0),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        _hairStyleNames[index],
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        width: 23.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }
}
