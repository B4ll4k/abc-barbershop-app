import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
  Widget build(BuildContext context) {
    _hairStyleNames = _hairStyles.keys.toList();
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
            _buscadorSeccion(context),
            _popularesBuscador(),
          ],
        ));
  }

  Widget _buscadorSeccion(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(height: 100.0),
        const SizedBox(
          width: 30.0,
        ),
        Container(
            width: 270.0,
            height: 45.0,
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 5.0),
                  blurRadius: 4.0)
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                      width: 180.0,
                      height: 35.0,
                      child: TextField(
                        controller: _searchTxtBoxController,
                        onEditingComplete: () {
                          if (_searchTxtBoxController.text.isEmpty) {
                            _searchTxtBoxController.text = "Search";
                          }
                        },
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              _hairStyleNames = _hairStyles.keys.toList();
                            });
                          } else {
                            setState(() {
                              _hairStyleNames = _hairStyles.keys
                                  .toList()
                                  .where(
                                    (element) => element
                                        .toLowerCase()
                                        .contains(value.toLowerCase()),
                                  )
                                  .toList();
                            });
                          }
                        },
                        onSubmitted: (value) {
                          setState(() {
                            _hairStyleNames = _hairStyles.keys
                                .toList()
                                .where(
                                  (element) => element
                                      .toLowerCase()
                                      .contains(value.toLowerCase()),
                                )
                                .toList();
                          });
                        },
                      )),
                ),
                Container(
                  width: 50.0,
                  height: 35.0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _hairStyleNames = _hairStyles.keys
                            .toList()
                            .where(
                              (element) => element.toLowerCase().contains(
                                  _searchTxtBoxController.text.toLowerCase()),
                            )
                            .toList();
                      });
                    },
                    child: Icon(
                      Icons.search,
                      size: 28.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }

  Widget _popularesBuscador() {
    return Container(
      height: 900,
      child: ListView.builder(
        itemCount: _hairStyleNames.length,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              width: 370.0,
              height: 160.0,
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
