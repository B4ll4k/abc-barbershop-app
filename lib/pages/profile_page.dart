import 'package:barbershop_app/providers/barber_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:collection';
import 'package:collection/collection.dart';

import '../pages/barbers_page.dart';
import '../models/apponitments.dart';
import '../providers/user_provider.dart';
import '../providers/appointment_provider.dart';
import '../widgets/fonts/barber_icon_icons.dart';
import '../pages/auth_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 25.0, top: 5.0),
              child: Text(
                'Profile',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400),
              )),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              padding:
                  const EdgeInsets.only(right: 10.0, bottom: 25.0, top: 5.0),
              icon: const Icon(Icons.logout, color: Colors.black),
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const AuthPage()),
                  ),
                );
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            _profileMember(context, user.firstName + " " + user.lastName),
            _buildUserAppointmentTab(context),
          ],
        ));
  }

  Widget _profileMember(BuildContext context, String fullName) {
    return Column(children: <Widget>[
      const SizedBox(
        height: 20.0,
      ),
      Container(
        // padding: EdgeInsets.only(top: 30.0),
        width: MediaQuery.of(context).size.width,
        height: 150.0,
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
              height: 40.0,
              child: Column(
                children: <Widget>[
                  Text(
                    fullName,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    ]);
  }

  Widget _buildUserAppointmentTab(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          "Appointments",
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20.0,
        ),
        DefaultTabController(
            length: 2, // length of tabs
            initialIndex: 0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: TabBar(
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      labelColor: Theme.of(context).colorScheme.secondary,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Theme.of(context).colorScheme.secondary,
                      tabs: const [
                        Tab(
                          text: "Active",
                        ),
                        Tab(text: 'History'),
                      ],
                    ),
                  ),
                  Container(
                      height: 400, //height of TabBarView
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.5))),
                      child: TabBarView(children: <Widget>[
                        _buildActiveAppointmentsList(context),
                        _buildHistoryAppointmentsList(context)
                      ]))
                ])),
      ]),
    );
  }

  Widget _buildActiveAppointmentsList(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final barberProvider = Provider.of<BarberProvider>(context);
    final barber = barberProvider.barbers;
    final activeAppointments = appointmentProvider.activeAppointments;
    return ListView.builder(
      itemCount: activeAppointments.length,
      itemBuilder: (ctx, i) => GestureDetector(
        onTap: () {},
        child: Card(
          shape: const BeveledRectangleBorder(),
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
          shadowColor: Colors.black87,
          elevation: 8.0,
          child: Container(
            height: 110.0,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Container(
                    width: 90.0,
                    height: 85.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(barber
                            .firstWhere((element) =>
                                element.id == activeAppointments[i].barberId)
                            .pictureUrl),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  width: 210.0,
                  height: 90.0,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Theme.of(context).bottomAppBarTheme.color,
                          size: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            barber
                                    .firstWhere((element) =>
                                        element.id ==
                                        activeAppointments[i].barberId)
                                    .firstName +
                                ' ' +
                                barber
                                    .firstWhere((element) =>
                                        element.id ==
                                        activeAppointments[i].barberId)
                                    .lastName,
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 13.5),
                          ),
                        )
                      ]),
                      const SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).bottomAppBarTheme.color,
                          size: 15.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Barberia Roma',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 13.5),
                          ),
                        )
                      ]),
                      const SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Icon(
                          BarberIcon.barbero,
                          color: Theme.of(context).bottomAppBarTheme.color,
                          size: 15.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Haircut',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 13.5),
                          ),
                        )
                      ]),
                      const SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Theme.of(context).bottomAppBarTheme.color,
                          size: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            '${barber.firstWhereOrNull((element) => element.id == activeAppointments[i].bookingStart.toString())} - ${barber.firstWhereOrNull((element) => element.id == activeAppointments[i].bookingEnd.toString())}',
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 13.5),
                          ),
                        )
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryAppointmentsList(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final barberProvider = Provider.of<BarberProvider>(context);
    final barber = barberProvider.barbers;
    final historyAppointments = appointmentProvider.activeAppointments;
    return ListView.builder(
      itemCount: historyAppointments.length,
      itemBuilder: (ctx, i) => GestureDetector(
        onTap: () {},
        child: Card(
          shape: const BeveledRectangleBorder(),
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
          shadowColor: Colors.black87,
          elevation: 8.0,
          child: Container(
            height: 110.0,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Container(
                    width: 90.0,
                    height: 85.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(barber
                            .firstWhere((element) =>
                                element.id == historyAppointments[i].barberId)
                            .pictureUrl),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  width: 210.0,
                  height: 90.0,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Theme.of(context).bottomAppBarTheme.color,
                          size: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            barber
                                    .firstWhere((element) =>
                                        element.id ==
                                        historyAppointments[i].barberId)
                                    .firstName +
                                ' ' +
                                barber
                                    .firstWhere((element) =>
                                        element.id ==
                                        historyAppointments[i].barberId)
                                    .lastName,
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 13.5),
                          ),
                        )
                      ]),
                      const SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).bottomAppBarTheme.color,
                          size: 15.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Barberia Roma',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 13.5),
                          ),
                        )
                      ]),
                      const SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Icon(
                          BarberIcon.barbero,
                          color: Theme.of(context).bottomAppBarTheme.color,
                          size: 15.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Haircut',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 13.5),
                          ),
                        )
                      ]),
                      const SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Theme.of(context).bottomAppBarTheme.color,
                          size: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            '${barber.firstWhereOrNull((element) => element.id == historyAppointments[i].bookingStart.toString())} - ${barber.firstWhereOrNull((element) => element.id == historyAppointments[i].bookingEnd.toString())}',
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 13.5),
                          ),
                        )
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
