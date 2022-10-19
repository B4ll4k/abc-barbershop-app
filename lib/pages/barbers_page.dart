import 'package:abc_barbershop/localization/language_constraints.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/book_appointment_page.dart';
import '../providers/barber_provider.dart';

class BarberPage extends StatelessWidget {
  String serviceId;
  BarberPage(this.serviceId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          translation(context).barbers,
          // 'Barbers',
          style: TextStyle(
              fontSize: 19.0, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
      body: _buildBarberCard(context),
    );
  }

  Widget _buildBarberCard(BuildContext context) {
    final provider = Provider.of<BarberProvider>(context, listen: false);
    final barbers = provider.barbers;
    return ListView.builder(
      itemCount: barbers.length,
      itemBuilder: (ctx, i) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BookAppointmentPage(serviceId, barbers[i].id, "appointments"),
          ),
        ),
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
                        fit: BoxFit.fill,
                        image: NetworkImage(barbers[i].pictureUrl.isEmpty
                            ? "https://media.istockphoto.com/photos/male-barber-cutting-sideburns-of-client-in-barber-shop-picture-id1301256896?b=1&k=20&m=1301256896&s=170667a&w=0&h=LHqIUomhTGZjpUY12vWg9Ki0lUGz2F0FfXSicsmSpR8="
                            : barbers[i].pictureUrl),
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
                          size: 17.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            barbers[i].firstName + ' ' + barbers[i].lastName,
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 15),
                          ),
                        )
                      ]),
                      const SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).bottomAppBarTheme.color,
                          size: 17.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Rue de la servette 01,\n 1201 Geneve',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                        )
                      ]),
                      const SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Theme.of(context).bottomAppBarTheme.color,
                          size: 17.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            Provider.of<BarberProvider>(context).workingHours ==
                                    ""
                                ? '9:30am - 8:30pm'
                                : Provider.of<BarberProvider>(context)
                                    .workingHours,
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 15),
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
