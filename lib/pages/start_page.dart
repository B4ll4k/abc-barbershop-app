import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/services_provider.dart';
import '../pages/gallery_page.dart';

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
          padding: EdgeInsets.only(left: 10.0, bottom: 25.0),
          child: Text(
            'Home',
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w500),
          ),
        ),
        // backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 10.0, bottom: 25.0),
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                _servicesBuilder(context),
                _mostRequestedHairStyleBuilder(context),
                _bestStylesSlider(context),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GalleryPage())),
                    child: Container(
                      height: 48.0,
                      width: 300.0,
                      // color: Color.fromRGBO(172, 128, 39, 1.0),
                      child: const Center(
                          child: Text('Gallery',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700))),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(172, 128, 39, 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 6.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // backgroundColor: Colors.white,
    );
  }

  Widget _servicesBuilder(BuildContext context) {
    final provider = Provider.of<ServicesProvider>(context, listen: false);
    final services = provider.services;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 45.0, top: 15.0),
          child: Row(
            children: [
              Text(
                'Services',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'book');
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    height: 95.0,
                    width: double.infinity,
                    // color: Colors.orange,
                    child: ListView.builder(
                      itemCount: services.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, i) => Column(
                        children: <Widget>[
                          Column(children: <Widget>[
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1.0, 2.0),
                                    blurRadius: 6.0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(height: 10.0),
                                  Container(
                                    width: 35.0,
                                    height: 35.0,
                                    child:
                                        Image.network(services[i].pictureUrl),
                                  ),
                                  Container(
                                    width: 50.0,
                                    height: 25.0,
                                    child: Center(
                                        child: Text(
                                      services[i].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                      ),
                                    )),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mostRequestedHairStyleBuilder(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 45.0, top: 0.0),
          child: Row(children: <Widget>[
            Text(
              'Most Requested',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ]),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                height: 170.0,
                width: 350.0,
                // color: Colors.orange,
                child: ListView.builder(
                  itemCount: _mostFrequentedHairStyles.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 190.0,
                    height: 160.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.45),
                              BlendMode.multiply),
                          image: AssetImage(
                            'assets/images/corte${i + 1}.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 5.0),
                              blurRadius: 4.0),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _mostFrequentedHairStyles[i],
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              width: 23.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bestStylesSlider(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 45.0, top: 10.0),
          child: Row(
            children: [
              Text(
                'Best chosen styles',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                height: 170.0,
                width: 350.0,
                // color: Colors.orange,
                child: ListView.builder(
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 200.0,
                    height: 160.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(.45), BlendMode.multiply),
                        image: AssetImage(
                          'assets/images/${i + 1}.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(1.0, 5.0),
                            blurRadius: 4.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
