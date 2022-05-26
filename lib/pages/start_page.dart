import 'package:barbershop_app/pages/gallery_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 25.0),
            child: Text('Inicio',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300))),
        // backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 10.0, bottom: 25.0),
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                _head(context),
                _file1(),
                _file2(),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GalleryPage())),
                    child: Container(
                      height: 48.0,
                      width: 300.0,
                      // color: Color.fromRGBO(172, 128, 39, 1.0),
                      child: const Center(
                          child: Text('Galeria',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700))),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(172, 128, 39, 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 6.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // backgroundColor: Colors.white,
    );
  }

  Widget _head(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 45.0, top: 15.0),
          child: Row(
            children: <Widget>[
              Text(
                'Servicios',
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 80.0,
                  width: 300.0,
                  // color: Colors.orange,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Column(children: <Widget>[
                            Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(172, 128, 39, 1.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: new Offset(1.0, 2.0),
                                    blurRadius: 6.0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(height: 10.0),
                                  Container(
                                    width: 30.0,
                                    height: 30.0,
                                    child: Image.asset(
                                        'assets/images/haircut.png'),
                                  ),
                                  Container(
                                    width: 50.0,
                                    height: 20.0,
                                    child: const Center(
                                        child: Text(
                                      'Haircut',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9.0,
                                      ),
                                    )),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(children: <Widget>[
                        Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(1.0, 2.0),
                                blurRadius: 6.0,
                              )
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              Container(
                                width: 30.0,
                                height: 30.0,
                                child: Image.asset('assets/images/beard.png'),
                              ),
                              Container(
                                width: 50.0,
                                height: 20.0,
                                child: const Center(
                                    child: Text(
                                  'Barba',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.0,
                                  ),
                                )),
                              )
                            ],
                          ),
                        ),
                      ]),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(children: <Widget>[
                        Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(1.0, 2.0),
                                blurRadius: 6.0,
                              )
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              Container(
                                width: 30.0,
                                height: 30.0,
                                child:
                                    Image.asset('assets/images/hairstyle.png'),
                              ),
                              Container(
                                width: 50.0,
                                height: 20.0,
                                child: const Center(
                                    child: Text(
                                  'Hairstyle',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.0,
                                  ),
                                )),
                              )
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(children: <Widget>[
                        Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: new Offset(1.0, 2.0),
                                blurRadius: 6.0,
                              )
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              Container(
                                width: 30.0,
                                height: 30.0,
                                child: Image.asset('assets/images/hairdye.png'),
                              ),
                              Container(
                                width: 50.0,
                                height: 20.0,
                                child: Center(
                                    child: Text(
                                  'Colorado',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.0,
                                  ),
                                )),
                              )
                            ],
                          ),
                        ),
                      ]),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(children: <Widget>[
                        Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(1.0, 2.0),
                                blurRadius: 6.0,
                              )
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              Container(
                                width: 30.0,
                                height: 30.0,
                                child: Image.asset('assets/images/haircut.png'),
                              ),
                              Container(
                                width: 50.0,
                                height: 20.0,
                                child: const Center(
                                    child: Text(
                                  'Haircut',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.0,
                                  ),
                                )),
                              )
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _file1() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 45.0, top: 0.0),
          child: Row(children: const <Widget>[
            Text(
              'Más Solicitados',
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300),
            ),
          ]),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 170.0,
                width: 350.0,
                // color: Colors.orange,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: 190.0,
                              height: 160.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.45),
                                        BlendMode.multiply),
                                    image: AssetImage(
                                      'assets/images/corte1.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
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
                                        'Mid Fade',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Container(
                                        width: 23.0,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 190.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(.45),
                                    BlendMode.multiply),
                                image: AssetImage(
                                  'assets/images/corte2.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.0, 5.0),
                                    blurRadius: 4.0),
                              ]),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('High Fade',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300)),
                                    Container(width: 23.0),
                                  ],
                                ),
                                SizedBox(height: 20.0)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 190.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(.45),
                                    BlendMode.multiply),
                                image: AssetImage(
                                  'assets/images/corte3.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.0, 5.0),
                                    blurRadius: 4.0),
                              ]),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('Caesar',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300)),
                                    Container(width: 23.0),
                                  ],
                                ),
                                SizedBox(height: 20.0)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 190.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(.45),
                                    BlendMode.multiply),
                                image: AssetImage(
                                  'assets/images/corte4.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1.0, 5.0),
                                  blurRadius: 6.0,
                                ),
                              ]),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text('Flequillo',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w300)),
                                      Container(width: 23.0),
                                    ]),
                                SizedBox(height: 20.0)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    //Inicio Cuadro Imagen
                    Column(
                      children: <Widget>[
                        Container(
                          width: 190.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(.45),
                                    BlendMode.multiply),
                                image: AssetImage(
                                  'assets/images/corte5.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.0, 5.0),
                                    blurRadius: 5.0),
                              ]),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('Line Up',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300)),
                                    Container(width: 23.0),
                                  ],
                                ),
                                SizedBox(height: 20.0)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: 20.0),
                    //Inicio Cuadro Imagen
                    Column(
                      children: <Widget>[
                        Container(
                          width: 190.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(.45),
                                    BlendMode.multiply),
                                image: AssetImage(
                                  'assets/images/corte6.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.0, 5.0),
                                    blurRadius: 5.0),
                              ]),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('Maxi Tupé',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300)),
                                    Container(width: 23.0),
                                  ],
                                ),
                                SizedBox(height: 20.0)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    //Inicio Cuadro Imagen
                    Column(
                      children: <Widget>[
                        Container(
                          width: 190.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(.45),
                                    BlendMode.multiply),
                                image: AssetImage(
                                  'assets/images/corte7.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.0, 5.0),
                                    blurRadius: 5.0)
                              ]),
                          child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text('Militar O Rapado',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w300)),
                                        Container(width: 23.0),
                                      ]),
                                  SizedBox(height: 20.0)
                                ]),
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    //Inicio Cuadro Imagen
                    Column(
                      children: <Widget>[
                        Container(
                          width: 190.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(.45),
                                    BlendMode.multiply),
                                image: AssetImage(
                                  'assets/images/corte8.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.0, 5.0),
                                    blurRadius: 5.0)
                              ]),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text('Spiky',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w300)),
                                      Container(width: 23.0),
                                    ]),
                                SizedBox(height: 20.0)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    //Inicio Cuadro Imagen
                    Column(
                      children: <Widget>[
                        Container(
                          width: 190.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(.45),
                                    BlendMode.multiply),
                                image: AssetImage(
                                  'assets/images/corte9.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.0, 5.0),
                                    blurRadius: 5.0),
                              ]),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('Tupé',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300)),
                                    Container(width: 23.0),
                                  ],
                                ),
                                SizedBox(height: 20.0)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    //Inicio Cuadro Imagen
                    Column(
                      children: <Widget>[
                        Container(
                          width: 190.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(.45),
                                    BlendMode.multiply),
                                image: AssetImage(
                                  'assets/images/corte10.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.0, 5.0),
                                    blurRadius: 5.0),
                              ]),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('Undercut',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300)),
                                    Container(width: 23.0),
                                  ],
                                ),
                                SizedBox(height: 20.0)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _file2() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 45.0, top: 10.0),
          child: Row(
            children: <Widget>[
              Text(
                'Mejor del Día',
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 170.0,
                width: 350.0,
                // color: Colors.orange,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(.45),
                                  BlendMode.multiply),
                              image: AssetImage(
                                'assets/images/1.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1.0, 5.0),
                                  blurRadius: 4.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(.45),
                                  BlendMode.multiply),
                              image: AssetImage('assets/images/2.jpg'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1.0, 5.0),
                                  blurRadius: 4.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(.45),
                                  BlendMode.multiply),
                              image: AssetImage(
                                'assets/images/3.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1.0, 5.0),
                                  blurRadius: 4.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(.45),
                                  BlendMode.multiply),
                              image: AssetImage(
                                'assets/images/4.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1.0, 5.0),
                                  blurRadius: 4.0),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    //Inicio - Cuadro con atributos de _file2
                    Column(
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(.45),
                                  BlendMode.multiply),
                              image: AssetImage(
                                'assets/images/5.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1.0, 5.0),
                                  blurRadius: 4.0),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    //Inicio - Cuadro con atributos de _file2
                    Column(
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(.45),
                                  BlendMode.multiply),
                              image: AssetImage(
                                'assets/images/6.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1.0, 5.0),
                                  blurRadius: 4.0),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    //Inicio - Cuadro con atributos de _file2
                    Column(
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(.45),
                                  BlendMode.multiply),
                              image: AssetImage(
                                'assets/images/7.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1.0, 5.0),
                                  blurRadius: 4.0),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 20.0,
                    ),
                    //Inicio - Cuadro con atributos de _file2
                    Column(
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(.45),
                                  BlendMode.multiply),
                              image: AssetImage(
                                'assets/images/8.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1.0, 5.0),
                                  blurRadius: 4.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
