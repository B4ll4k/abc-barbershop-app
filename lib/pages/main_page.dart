import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Switch Routes Pages
import './gallery_page.dart';
import './profile_page.dart';
import './start_page.dart';
import './search_page.dart';
import './auth_page.dart';
import '../providers/user_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> {
  int _currentIndex = 0;
  //Valores para el HideBottomNavBar
  // ScrollController = _scrollControler;
  bool visible = true;
  //If the app does not close when clicking the back buttons of the Gallery we can use this list
  // List <Widget> _widgetOptions = <Widget>[
  //   StartPage(),
  //   SearchPage(),
  //   GalleryPage(),
  //   ProfilePage(),
  //   AboutPage(),
  // ];

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    // void initState() {
    //   super.initState();
    //   _scrollController = ScrollController();
    //   _scrollController.addListener(() {
    //     if ( _scrollController.position.userScrollDirection == ScrollDirection.reverse) {
    //       setState
    //     }
    //   });
    // }
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentIndex].currentState!.maybePop();
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
          ],
        ),
        bottomNavigationBar: _crearBottomNavigationBar(),
        // backgroundColor: Colors.white,
      ),
    );
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor: Colors.black.withOpacity(0.6),
      elevation: 40.0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          backgroundColor: Colors.white,
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.photo), label: 'Gallery'),
        BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity), label: 'Profile'),
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.info_outline), label: 'About'),
      ],
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          StartPage(),
          const SearchPage(),
          const GalleryPage(),
          Provider.of<UserProvider>(context).isAuth()
              ? const ProfilePage()
              : AuthPage(true),
          //const AboutPage(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }
}
