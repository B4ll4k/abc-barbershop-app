import 'package:flutter/material.dart';

import '../size_config.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 20.0, top: 10.0),
          child: Text('Gallery',
              style: TextStyle(
                  fontSize: SizeConfig.screenHeight * 0.020,
                  fontWeight: FontWeight.w400,
                  color: Colors.white)),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
            child: Row(
              children: <Widget>[
                _listGallery(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listGallery() {
    return Flexible(
      child: Row(
        children: <Widget>[
          //°°°Columna Izquierda°°°
          Flexible(
            child: Column(
              children: <Widget>[
                _cardsLeft('assets/images/corte10.jpg', 'Undercut'),
                _cardsLeft('assets/images/rizado.jpg', 'Rizado'),
                _cardsLeft('assets/images/corte8.jpg', 'Spiky'),
                _cardsLeft('assets/images/4.jpg', 'Fade Beard'),
                _cardsLeft('assets/images/corte10.jpg', 'Undercut'),
                _cardsLeft('assets/images/rizado.jpg', 'Rizado'),
                _cardsLeft('assets/images/corte8.jpg', 'Spiky'),
                _cardsLeft('assets/images/4.jpg', 'Fade Beard'),
              ],
            ),
          ),

          //°°°Columna Derecha°°°
          Flexible(
            child: Column(
              children: <Widget>[
                _cardsRight('assets/images/hairandbeard.jpg', 'Hair and Beard'),
                _cardsRight('assets/images/haircoloring.jpg', 'Hair Color'),
                _cardsRight('assets/images/2.jpg', 'Line Up'),
                _cardsRight('assets/images/corte3.jpg', 'Flequillo'),
                _cardsRight('assets/images/hairandbeard.jpg', 'Hair and Beard'),
                _cardsRight('assets/images/haircoloring.jpg', 'Hair Color'),
                _cardsRight('assets/images/2.jpg', 'Line Up'),
                _cardsRight('assets/images/corte3.jpg', 'Flequillo'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardsLeft(String img, String name) {
    return Column(
      children: <Widget>[
        //Card mediana
        Card(
          // margin: EdgeInsets.only( left: 30.0, ),
          shape: const BeveledRectangleBorder(),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: SizeConfig.screenWidth * 0.42,
                    height: SizeConfig.screenHeight * 0.15,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.45),
                              BlendMode.multiply),
                          image: AssetImage(img),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 5.0),
                              blurRadius: 4.0)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 20.0,
                            )
                          ],
                        ),
                        Container(
                          height: 10.0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // const SizedBox(
        //   height: 10.0,
        // ),
      ],
    );
  }

  Widget _cardsRight(String img, String name) {
    return Column(children: <Widget>[
      //Card - pequeña
      Card(
        margin: const EdgeInsets.only(left: 10, top: 5.0),
        shape: const BeveledRectangleBorder(),
        child: Container(
          width: SizeConfig.screenWidth * 0.42,
          height: SizeConfig.screenHeight * 0.15,
          decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.45), BlendMode.multiply),
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 5.0),
                    blurRadius: 4.0)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 10.0,
                  )
                ],
              ),
              Container(
                height: 10.0,
              )
            ],
          ),
        ),
      ),

      const SizedBox(
        height: 10.0,
      ),
    ]);
  }
}
