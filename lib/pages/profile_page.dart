import 'package:flutter/material.dart';

// import 'package:barber_booking/src/fonts/barber_icon_icons.dart';

import 'package:barbershop_app/pages/appointment_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 25.0),
              child: Text(
                'Perfil',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300),
              )),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 10.0, bottom: 25.0),
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {},
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            _profileMember(context),
            _capturas(),
            const SizedBox(
              height: 20.0,
            ),
            Row(children: <Widget>[
              Container(
                width: 30.0,
              ),
              const Text('Citas',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300)),
              Container(
                width: 230.0,
              ),
              InkWell(
                child: const Text(
                  'Ver más',
                  style: TextStyle(
                      color: Color.fromRGBO(172, 128, 39, 1.0),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AppointmentPage())),
              ),
            ]),
            const Citas1(),
            const Citas2(),
            const Citas1(),
            const Citas2(),
          ],
        ));
  }

  Widget _profileMember(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(
        height: 20.0,
      ),
      Container(
        // padding: EdgeInsets.only(top: 30.0),
        width: MediaQuery.of(context).size.width,
        height: 240.0,
        child: Column(children: <Widget>[
          Container(
            width: 95.0,
            height: 90.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.25), BlendMode.multiply),
                    image: const AssetImage('assets/images/member4.jpg'),
                    fit: BoxFit.cover),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 3.0),
                      blurRadius: 10.0)
                ]),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Flexible(
            child: Container(
              // padding: EdgeInsets.only( top: 20.0 ),
              width: 140.0,
              height: 50.0,
              child: Column(
                children: const <Widget>[
                  Text(
                    'Iker Elias P.',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Miembro',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Row(children: <Widget>[
            const SizedBox(
              width: 50.0,
            ),
            Container(
                width: 85.0,
                height: 60.0,
                child: const ListTile(
                  title: Text(
                    '12',
                    style: TextStyle(
                        color: Color.fromRGBO(172, 128, 39, 1.0),
                        fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text('Capturas',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0)),
                )),
            const SizedBox(
              width: 20.0,
            ),
            Container(
                width: 85.0,
                height: 60.0,
                child: const ListTile(
                  title: Text(
                    '31',
                    style: TextStyle(
                        color: Color.fromRGBO(172, 128, 39, 1.0),
                        fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text('Citas',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0),
                      textAlign: TextAlign.center),
                )),
            const SizedBox(
              width: 20.0,
            ),
            Container(
                width: 85.0,
                height: 60.0,
                child: const ListTile(
                  title: Text(
                    '123',
                    style: TextStyle(
                        color: Color.fromRGBO(172, 128, 39, 1.0),
                        fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    'Likes',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0),
                    textAlign: TextAlign.center,
                  ),
                )),
          ])
        ]),
      ),
    ]);
  }

  Widget _capturas() {
    return Column(children: <Widget>[
      Row(children: <Widget>[
        Container(
          width: 30.0,
        ),
        const Text('Capturas',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.w300)),
        Container(
          width: 195.0,
        ),
        const Text('Ver más',
            style: TextStyle(
                color: Color.fromRGBO(172, 128, 39, 1.0),
                fontSize: 15.0,
                fontWeight: FontWeight.w300)),
      ]),
      const SizedBox(
        height: 10.0,
      ),
      Row(
        children: <Widget>[
          const SizedBox(
            width: 30.0,
          ),
          Container(
              width: 100.0,
              height: 110.0,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/member1.jpg'),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 4.0)
                  ])),
          const SizedBox(
            width: 15.0,
          ),
          Container(
              width: 100.0,
              height: 110.0,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/member2.jpg'),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 4.0)
                  ])),
          const SizedBox(
            width: 15.0,
          ),
          Container(
              width: 100.0,
              height: 110.0,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/member3.jpg'),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 4.0)
                  ])),
        ],
      )
    ]);
  }
}
