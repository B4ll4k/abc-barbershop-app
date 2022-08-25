import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/barbers_page.dart';
import '../providers/services_provider.dart';
import '../size_config.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 20.0, top: 10.0),
          child: Text(
            'Home',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w400),
          ),
        ),
        // backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: _servicesWidgetBuilder(context),
    );
  }

  Widget _servicesWidgetBuilder(BuildContext context) {
    final servicesProvider =
        Provider.of<ServicesProvider>(context, listen: false);
    final services = servicesProvider.services;
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, i) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BarberPage(services[i].id),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: getProportionateScreenHeight(200),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(13.0),
            image: DecorationImage(
                opacity: 0.6,
                image: NetworkImage(services[i].pictureUrl),
                fit: BoxFit.cover),
          ),
          margin: EdgeInsets.all(SizeConfig.screenWidth * 0.015),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Padding(
                padding: EdgeInsets.all(SizeConfig.screenHeight * 0.016),
                child: Text(
                  services[i].name,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: SizeConfig.screenHeight * 0.031),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
