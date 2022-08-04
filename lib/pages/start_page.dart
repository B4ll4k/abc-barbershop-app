import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/barbers_page.dart';
import '../providers/services_provider.dart';
import '../size_config.dart';

class StartPage extends StatelessWidget {
  final List<String> _mostFrequentedHairStyles = [
    "Mid Fade",
    "High Fade",
    "Caesar",
    "Fringe",
    "Line Up",
    "Maxi Tupé",
    "Military Style",
    "Spiky",
    "Quiff",
    "Undercut"
  ];

  StartPage({Key? key}) : super(key: key);

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
      body: _categoriesBuilder(context),
    );
  }

  Widget _categoriesBuilder(BuildContext context) {
    final servicesProvider =
        Provider.of<ServicesProvider>(context, listen: false);
    final services = servicesProvider.services;

    return ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) => Container(
              child: Container(
                width: SizeConfig.screenWidth * 0.2,
                height: SizeConfig.screenHeight * 0.255,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.12,
                    vertical: SizeConfig.screenWidth * 0.04),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BarberPage(services[index].id),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 8.0,
                    shadowColor: Colors.black,
                    // decoration: BoxDecoration(
                    //     border: Border.all(
                    //         width: 2.0,
                    //         style: BorderStyle.solid,
                    //         color: Colors.black.withOpacity(0.6))),
                    child: Column(children: [
                      Visibility(
                        child: Image.asset(
                          "assets/images/Haircut.png",
                          height: SizeConfig.screenHeight * 0.2,
                          width: SizeConfig.screenWidth * 0.35,
                        ),
                        visible: services[index].name == "Haircut",
                      ),
                      Visibility(
                        child: Image.asset(
                          "assets/images/Barber.png",
                          height: SizeConfig.screenHeight * 0.2,
                          width: SizeConfig.screenWidth * 0.35,
                        ),
                        visible: services[index].name == "Barber",
                      ),
                      Visibility(
                        child: Image.asset(
                          "assets/images/Haircut and Barber.png",
                          height: SizeConfig.screenHeight * 0.2,
                          width: SizeConfig.screenWidth * 0.35,
                        ),
                        visible: services[index].name == "Haircut and Barber",
                      ),
                      Visibility(
                        child: Image.asset(
                          "assets/images/Hair wash.png",
                          height: SizeConfig.screenHeight * 0.2,
                          width: SizeConfig.screenWidth * 0.35,
                        ),
                        visible: services[index].name == "Hair wash",
                      ),
                      Visibility(
                        child: Image.asset(
                          "assets/images/Students and Retired.png",
                          height: SizeConfig.screenHeight * 0.2,
                          width: SizeConfig.screenWidth * 0.35,
                        ),
                        visible: services[index].name == "Students & Retired",
                      ),
                      Visibility(
                        child: Image.asset(
                          "assets/images/kids.png",
                          height: SizeConfig.screenHeight * 0.2,
                          width: SizeConfig.screenWidth * 0.35,
                        ),
                        visible: services[index].name == "Kids under 12 yrs",
                      ),
                      Text(
                        services[index].name,
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth * 0.06,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ),
              ),
            ));
  }
}
