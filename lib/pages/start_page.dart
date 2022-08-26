import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/barbers_page.dart';
import '../providers/services_provider.dart';
import '../providers/user_provider.dart';
import '../providers/appointment_provider.dart';
import '../providers/barber_provider.dart';
import '../size_config.dart';

class StartPage extends StatelessWidget {
  StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<ServicesProvider>(context, listen: false)
            .fetchServices();
        await Provider.of<BarberProvider>(context, listen: false)
            .fetchBarbers();
        await Provider.of<BarberProvider>(context, listen: false)
            .fetchDaysoff();
        await Provider.of<BarberProvider>(context, listen: false)
            .fetchFreeWeekdays();
        await Provider.of<BarberProvider>(context, listen: false)
            .fetchWorkingTime();

        bool isAuth =
            Provider.of<UserProvider>(context, listen: false).isAuth();
        if (isAuth) {
          await Provider.of<AppointmentProvider>(context, listen: false)
              .fetchActiveAppointments(
                  Provider.of<UserProvider>(context, listen: false).user.id);
          await Provider.of<AppointmentProvider>(context, listen: false)
              .fetchHistoryAppointments(
                  Provider.of<UserProvider>(context, listen: false).user.id);
          // await Provider.of<AppointmentProvider>(context, listen: false)
          //     .fetchAllAppointments();
        }
      },
      color: Theme.of(context).colorScheme.secondary,
      child: Scaffold(
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
        body: Stack(
          children: [
            _buildBackgroundImage(),
            _categoriesBuilder(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.black, Colors.black12],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black12, BlendMode.color),
          ),
        ),
      ),
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
                    color: Colors.white.withOpacity(0.7),
                    // decoration: BoxDecoration(
                    //     border: Border.all(
                    //         width: 2.0,
                    //         style: BorderStyle.solid,
                    //         color: Colors.black.withOpacity(0.6))),
                    child: Column(children: [
                      Image.network(
                        services[index].pictureUrl,
                        height: SizeConfig.screenHeight * 0.2,
                        width: SizeConfig.screenWidth * 0.35,
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
