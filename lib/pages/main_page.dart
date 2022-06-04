import 'package:flutter/material.dart';

//Switch Routes Pages
import 'package:barbershop_app/pages/about_page.dart';
import 'package:barbershop_app/pages/gallery_page.dart';
import 'package:barbershop_app/pages/profile_page.dart';
import 'package:barbershop_app/pages/start_page.dart';
import 'package:barbershop_app/pages/search_page.dart';

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
        //If you only want the same App bar for all pages
        // appBar: AppBar(
        //   title: Padding(
        //     padding: const EdgeInsets.only(left: 10.0, bottom: 25.0),
        //       child: Text('Inicio',
        //         style: TextStyle(
        //           color: Colors.black,
        //           ),
        //         ),

        //   ),
        //   backgroundColor: Colors.white,

        //   elevation: 0.0,
        //   actions: <Widget>[
        //     IconButton(
        //       padding: const EdgeInsets.only(right: 5.0, bottom:25.0),
        //       icon: Icon(Icons.more_vert, color: Colors.black),
        //       onPressed: () {},
        //       ),
        //   ],
        // ),
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
            _buildOffstageNavigator(4)
          ],
        ),
        // _callPage(_currentIndex),
        bottomNavigationBar: _crearBottomNavigationBar(),
        // backgroundColor: Colors.white,
      ),
    );
  }

  //Metodo para llamar las pa´ginas en el appbar por medio de switch y case
  // Widget _callPage( int paginaActual ) {

  //   switch ( paginaActual ) {
  //     case 0 : return StartPage();
  //       break;
  //     case 1 : return SearchPage();
  //       break;
  //     case 2 : return GalleryPage();
  //       break;
  //     case 3 : return ProfilePage();
  //       break;
  //     case 4 : return AboutPage();
  //       break;
  //     default: return StartPage();
  //   }

  // }

  Widget _crearBottomNavigationBar() {
    return Container(
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).bottomAppBarTheme.color,
        unselectedItemColor: Colors.black,
        elevation: 0.0,
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
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          StartPage(),
          SearchPage(),
          GalleryPage(),
          const ProfilePage(),
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

// class HideBottomNavBar extends StatefulWidget {

//   @override
//   HideBottomNavBarState createState() {
//     return new HideBottomNavBarState();
//   }
// }

// class HideBottomNavBarState extends State>HideBottomNavBar> {

//   String Text
//   return

// }
