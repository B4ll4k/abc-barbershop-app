import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/book_appointment_page.dart';
import '../widgets/fonts/barber_icon_icons.dart';
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
        title: const Text(
          'Barbers',
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
                        image: NetworkImage(barbers[i].pictureUrl),
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
                            barbers[i].firstName + ' ' + barbers[i].lastName,
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
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            '13-03-2020 3:30pm - 4:40pm',
                            style: TextStyle(
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
