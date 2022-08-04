import 'package:abc_barbershop/pages/appointment_details_page.dart';
import 'package:abc_barbershop/providers/appointment_provider.dart';
import 'package:abc_barbershop/providers/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/barber_provider.dart';
import '../widgets/fonts/barber_icon_icons.dart';
import '../size_config.dart';

class AppointmentsPage extends StatelessWidget {
  String appointmentType;
  AppointmentsPage(this.appointmentType, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "$appointmentType Appointments",
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      )),
      body: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Container(
              height: SizeConfig.screenHeight * 0.78,
              child: _buildAppointments(context)),
        ],
      ),
    );
  }

  // Widget _buildAppointments(BuildContext context) {
  //   final provider = Provider.of<AppointmentProvider>(context, listen: true);
  //   final appointments = appointmentType == "Active"
  //       ? provider.activeAppointments
  //       : provider.historyAppointments;
  //   return ListView.builder(
  //     itemCount: appointments.length,
  //     itemBuilder: (ctx, i) => Card(
  //       shape: const BeveledRectangleBorder(),
  //       margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
  //       shadowColor: Colors.black87,
  //       elevation: 8.0,
  //       child: Container(
  //         height: 110.0,
  //         child: Row(
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.only(left: 15.0),
  //               child: Container(
  //                 width: 90.0,
  //                 height: 85.0,
  //                 decoration: BoxDecoration(
  //                   image: DecorationImage(
  //                     fit: BoxFit.cover,
  //                     image: NetworkImage(Provider.of<BarberProvider>(context,
  //                                     listen: false)
  //                                 .barbers
  //                                 .firstWhere((element) =>
  //                                     element.id == appointments[i].barberId)
  //                                 .pictureUrl
  //                                 .isEmpty ||
  //                             Provider.of<BarberProvider>(context,
  //                                     listen: false)
  //                                 .barbers
  //                                 .firstWhere((element) =>
  //                                     element.id == appointments[i].barberId)
  //                                 .pictureUrl
  //                                 .isEmpty
  //                         ? "https://media.istockphoto.com/photos/male-barber-cutting-sideburns-of-client-in-barber-shop-picture-id1301256896?b=1&k=20&m=1301256896&s=170667a&w=0&h=LHqIUomhTGZjpUY12vWg9Ki0lUGz2F0FfXSicsmSpR8="
  //                         : Provider.of<BarberProvider>(context, listen: false)
  //                             .barbers
  //                             .firstWhere((element) =>
  //                                 element.id == appointments[i].barberId)
  //                             .pictureUrl),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               padding: const EdgeInsets.only(left: 10.0),
  //               width: 210.0,
  //               height: 98.0,
  //               child: Column(
  //                 children: <Widget>[
  //                   const SizedBox(height: 5.0),
  //                   Row(children: <Widget>[
  //                     Icon(
  //                       Icons.person,
  //                       color: Theme.of(context).bottomAppBarTheme.color,
  //                       size: 15.0,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 10.0),
  //                       child: Text(
  //                         Provider.of<BarberProvider>(context, listen: false)
  //                                 .barbers
  //                                 .firstWhere((element) =>
  //                                     element.id == appointments[i].barberId)
  //                                 .firstName +
  //                             ' ' +
  //                             Provider.of<BarberProvider>(context,
  //                                     listen: false)
  //                                 .barbers
  //                                 .firstWhere((element) =>
  //                                     element.id == appointments[i].barberId)
  //                                 .lastName,
  //                         style: const TextStyle(
  //                             color: Colors.black54, fontSize: 13.5),
  //                       ),
  //                     )
  //                   ]),
  //                   const SizedBox(height: 5.0),
  //                   Row(children: <Widget>[
  //                     Icon(
  //                       Icons.location_on,
  //                       color: Theme.of(context).bottomAppBarTheme.color,
  //                       size: 15.0,
  //                     ),
  //                     const Padding(
  //                       padding: EdgeInsets.only(left: 10.0),
  //                       child: Text(
  //                         'Geneve, Switzerland',
  //                         style:
  //                             TextStyle(color: Colors.black54, fontSize: 13.5),
  //                       ),
  //                     )
  //                   ]),
  //                   const SizedBox(height: 5.0),
  //                   Row(children: <Widget>[
  //                     Icon(
  //                       BarberIcon.barbero,
  //                       color: Theme.of(context).bottomAppBarTheme.color,
  //                       size: 15.0,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 10.0),
  //                       child: Text(
  //                         Provider.of<ServicesProvider>(context, listen: false)
  //                             .services
  //                             .firstWhere((element) =>
  //                                 element.id == appointments[i].serviceId)
  //                             .name,
  //                         style: const TextStyle(
  //                             color: Colors.black54, fontSize: 13.5),
  //                       ),
  //                     )
  //                   ]),
  //                   const SizedBox(height: 5.0),
  //                   Row(children: <Widget>[
  //                     Icon(
  //                       Icons.access_time,
  //                       color: Theme.of(context).bottomAppBarTheme.color,
  //                       size: 15.0,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 10.0),
  //                       child: Text(
  //                         ' ${DateFormat.yMMMMd().format(appointments[i].bookingStart)}, \n ${DateFormat.Hms().format(appointments[i].bookingStart)} - ${DateFormat.Hms().format(appointments[i].bookingEnd)}',
  //                         style: const TextStyle(
  //                             color: Colors.black54, fontSize: 13),
  //                       ),
  //                     )
  //                   ]),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildAppointments(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context, listen: true);
    final appointments = appointmentType == "Active"
        ? provider.activeAppointments
        : provider.historyAppointments;
    final services =
        Provider.of<ServicesProvider>(context, listen: true).services;
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, i) => Container(
        width: getProportionateScreenWidth(460),
        height: getProportionateScreenHeight(430),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AppointmentDetailsPage(appointments[i].id, false),
                ));
          },
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: constraints.maxHeight * 0.9,
                    child: Card(
                      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
                      elevation: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(60),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.account_circle_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            title: Text(Provider.of<BarberProvider>(context,
                                        listen: false)
                                    .barbers
                                    .firstWhere((element) =>
                                        element.id == appointments[i].barberId)
                                    .firstName +
                                ' ' +
                                Provider.of<BarberProvider>(context,
                                        listen: false)
                                    .barbers
                                    .firstWhere((element) =>
                                        element.id == appointments[i].barberId)
                                    .lastName),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            title: const Text("Geneve, Switzerland"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.design_services,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            title: Text(services
                                .firstWhere((element) =>
                                    element.id == appointments[i].serviceId)
                                .name),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.calendar_month,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            title: Text(
                                ' ${DateFormat.yMMMMd().format(appointments[i].bookingStart)}'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.watch_later,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            title: Text(
                                '${DateFormat.Hms().format(appointments[i].bookingStart)} - ${DateFormat.Hms().format(appointments[i].bookingEnd)}'),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ClipOval(
                      child: Container(
                        width: getProportionateScreenWidth(130),
                        height: getProportionateScreenHeight(125),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.25),
                                  BlendMode.multiply),
                              image: NetworkImage(Provider.of<BarberProvider>(
                                              context,
                                              listen: false)
                                          .barbers
                                          .firstWhere((element) =>
                                              element.id ==
                                              appointments[i].barberId)
                                          .pictureUrl
                                          .isEmpty ||
                                      Provider.of<BarberProvider>(context, listen: false)
                                          .barbers
                                          .firstWhere((element) =>
                                              element.id ==
                                              appointments[i].barberId)
                                          .pictureUrl
                                          .isEmpty
                                  ? "https://media.istockphoto.com/photos/male-barber-cutting-sideburns-of-client-in-barber-shop-picture-id1301256896?b=1&k=20&m=1301256896&s=170667a&w=0&h=LHqIUomhTGZjpUY12vWg9Ki0lUGz2F0FfXSicsmSpR8="
                                  : Provider.of<BarberProvider>(context, listen: false)
                                      .barbers
                                      .firstWhere((element) => element.id == appointments[i].barberId)
                                      .pictureUrl),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
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
