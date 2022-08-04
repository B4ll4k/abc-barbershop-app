import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/appointments_page.dart';
import '../providers/appointment_provider.dart';
import '../providers/user_provider.dart';
import 'auth_page.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = "/profilePage";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          _buildMenuOptions(
              context,
              "My Account",
              Icon(
                Icons.person_outline_rounded,
                size: 36,
                color: Theme.of(context).colorScheme.secondary,
              ), () {
            Navigator.of(context, rootNavigator: true)
                .pushNamed("/editProfilePage");
          }),
          const SizedBox(height: 30),
          _buildMenuOptions(
              context,
              "Active Appointments",
              Icon(
                Icons.local_activity_outlined,
                size: 36,
                color: Theme.of(context).colorScheme.secondary,
              ), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentsPage("Active"),
                ));
          }),
          const SizedBox(height: 30),
          _buildMenuOptions(
              context,
              "History Appointments",
              Icon(
                Icons.history,
                size: 36,
                color: Theme.of(context).colorScheme.secondary,
              ), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentsPage("History"),
                ));
          }),
          const SizedBox(height: 30),
          _buildMenuOptions(
              context,
              "Privacy",
              Icon(
                Icons.privacy_tip_outlined,
                size: 36,
                color: Theme.of(context).colorScheme.secondary,
              ), () {
            _launchInWebViewOrVC(Uri.parse("https://abc-barber.ch/privacy/"));
          }),
          const SizedBox(height: 30),
          _buildMenuOptions(
              context,
              "About",
              Icon(
                Icons.abc_outlined,
                size: 36,
                color: Theme.of(context).colorScheme.secondary,
              ), () {
            _launchInWebViewOrVC(Uri.parse("https://abc-barber.ch/about-us/"));
          }),
          const SizedBox(height: 30),
          _buildMenuOptions(
              context,
              "LogOut",
              Icon(
                Icons.logout,
                size: 36,
                color: Theme.of(context).colorScheme.secondary,
              ), () {
            Provider.of<AppointmentProvider>(context, listen: false)
                .setActiveAppointment([]);
            Provider.of<AppointmentProvider>(context, listen: false)
                .setHistoryAppointment([]);
            Provider.of<UserProvider>(context, listen: false).logout();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => AuthPage(true)),
              ),
            );
          }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProfilePic() {
    return Column(
      children: [
        SizedBox(
          height: 140,
          width: 140,
          child: Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            fit: StackFit.expand,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/corte4.jpg"),
              ),
              Positioned(
                bottom: 0,
                right: -4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 3.0),
                    color: const Color.fromARGB(255, 239, 239, 240),
                  ),
                  height: 55,
                  width: 55,
                  child: Center(
                    child: IconButton(
                      iconSize: 25,
                      color: Colors.black38,
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuOptions(
      BuildContext context, String option, Icon icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith((states) =>
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => const Color.fromARGB(255, 239, 239, 240),
            ),
          ),
          onPressed: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                icon,
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6), fontSize: 17),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black.withOpacity(0.6),
                )
              ],
            ),
          )),
    );
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }
}
