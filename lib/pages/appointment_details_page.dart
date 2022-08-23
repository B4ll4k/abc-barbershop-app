import 'package:abc_barbershop/models/appointments.dart';
import 'package:abc_barbershop/providers/appointment_provider.dart';
import 'package:abc_barbershop/providers/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../providers/barber_provider.dart';
import '../providers/user_provider.dart';
import '../size_config.dart';

class AppointmentDetailsPage extends StatefulWidget {
  String appointmentId;
  bool _isBooking;
  AppointmentDetailsPage(this.appointmentId, this._isBooking, {Key? key})
      : super(key: key);

  @override
  State<AppointmentDetailsPage> createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  bool _isBookBtnLoading = false;
  Appointment? appointment;
  @override
  Widget build(BuildContext context) {
    print("APpointment Id ${widget.appointmentId}");
    appointment = Provider.of<AppointmentProvider>(context, listen: false)
        .activeAppointments
        .firstWhereOrNull((element) => element.id == widget.appointmentId);
    appointment ??= Provider.of<AppointmentProvider>(context, listen: false)
        .historyAppointments
        .firstWhereOrNull((element) => element.id == widget.appointmentId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          "Appointment Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            if (widget._isBooking) {
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('home');
            } else {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Text(
              "Thank you for booking!",
              style: TextStyle(fontSize: getProportionateScreenHeight(20)),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            _barberProfilePic(context),
            _buildDetails()
          ],
        ),
      ),
    );
  }

  Widget _barberProfilePic(BuildContext context) {
    final barberProvider = Provider.of<BarberProvider>(context, listen: false);
    final barbers = barberProvider.barbers;
    final barber = barbers.firstWhere(
      (element) => element.id == appointment!.barberId,
    );
    return Container(
      // padding: EdgeInsets.only(top: 30.0),
      width: MediaQuery.of(context).size.width,
      height: getProportionateScreenHeight(180),
      child: Column(children: <Widget>[
        ClipOval(
          child: Container(
            width: getProportionateScreenWidth(130),
            height: getProportionateScreenHeight(125),
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.25), BlendMode.multiply),
                    image: NetworkImage(barber.pictureUrl.isEmpty
                        ? "https://media.istockphoto.com/photos/male-barber-cutting-sideburns-of-client-in-barber-shop-picture-id1301256896?b=1&k=20&m=1301256896&s=170667a&w=0&h=LHqIUomhTGZjpUY12vWg9Ki0lUGz2F0FfXSicsmSpR8="
                        : barber.pictureUrl),
                    fit: BoxFit.cover),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 3.0),
                      blurRadius: 10.0)
                ]),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        Flexible(
          child: Container(
            // padding: EdgeInsets.only( top: 20.0 ),
            width: getProportionateScreenWidth(140),
            height: getProportionateScreenHeight(80),
            child: Column(
              children: <Widget>[
                Text(
                  '${barber.firstName} ${barber.lastName}',
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(30),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildDetails() {
    final service = Provider.of<ServicesProvider>(context, listen: false)
        .services
        .firstWhere((element) => element.id == appointment!.serviceId);
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalTime(),
          SizedBox(
            height: getProportionateScreenHeight(28),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Service Chosen",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(15),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(
                service.name,
                style: TextStyle(fontSize: getProportionateScreenHeight(14)),
              )
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(28),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Student Price",
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(15),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Text(
                    "25 CHF",
                    style:
                        TextStyle(fontSize: getProportionateScreenHeight(14)),
                  )
                ],
              ),
              SizedBox(
                width: getProportionateScreenWidth(100),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Normal Price",
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(15),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Text(
                    "${service.price} CHF",
                    style:
                        TextStyle(fontSize: getProportionateScreenHeight(14)),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCalTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: getProportionateScreenHeight(35),
                ),
                Text(
                  DateFormat.yMMMMd().format(appointment!.bookingStart),
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(13),
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              width: getProportionateScreenWidth(100),
            ),
            Column(
              children: [
                Icon(
                  Icons.watch_later,
                  size: getProportionateScreenHeight(35),
                ),
                Text(
                  '${DateFormat.Hms().format(appointment!.bookingStart)} - ${DateFormat.Hms().format(appointment!.bookingEnd)}',
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(13),
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
