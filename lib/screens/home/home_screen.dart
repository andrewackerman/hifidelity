import 'package:flutter/material.dart';
import 'package:hifidelity/components/gradient_raised_button.dart';
import 'package:hifidelity/screens/home/components/deal_carousel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hifidelity/components/gradient_progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // void _drawerMenuButtonClicked(BuildContext cxt) {

  // }

  void _drawerLanguageButtonClicked(BuildContext cxt) {
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext cxt) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 153, 184),
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Image.asset('assets/images/7tk_title.png'),
        ),
        // leading: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 6),
        //   child: IconButton(
        //     icon: Icon(MdiIcons.menu),
        //     onPressed: () => _drawerMenuButtonClicked(cxt),
        //   ),
        // ),
        actions: [
          Row(
            children: [
              Text('EN'),
              Padding(
                padding: EdgeInsets.only(right: 6),
                child: IconButton(
                  icon: Icon(MdiIcons.earth),
                  onPressed: () => _drawerLanguageButtonClicked(cxt),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 246, 246, 246),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(2, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        '7000',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color.fromARGB(255, 16, 65, 131),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        'Tokens Owned',
                        style: TextStyle(
                          color: Color.fromARGB(255, 100, 100, 100),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                // color: Color.fromARGB(255, 16, 65, 131),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 13, 55, 111),
                      Color.fromARGB(255, 16, 65, 131),
                      Color.fromARGB(255, 16, 65, 131),
                      Color.fromARGB(255, 13, 55, 111),
                    ],
                    stops: [
                      0.02,
                      0.05,
                      0.95,
                      0.98,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Level 4',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            )
                          ),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(cxt).style.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                              children: [
                                TextSpan(text: '777', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: ' tokens until '),
                                TextSpan(text: 'Level 5', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: GradientProgressIndicator(value: 0.75),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientRaisedButton(
                            width: 160,
                            height: 35,
                            onPressed: () {},
                            child: Text(
                              'SEE ALL BENEFITS',
                              style: TextStyle(
                                color: Color.fromARGB(255, 16, 65, 131),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment(-0.02, -1),
                              end: Alignment(0.02, 1),
                              colors: [
                                Colors.white,
                                Color.fromARGB(255, 212, 223, 236),
                              ],
                              stops: [
                                0.69,
                                0.71,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 25,
              child: Container(
                color: Color.fromARGB(255, 249, 249, 249),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'Current Deals',
                          style: TextStyle(
                            color: Color.fromARGB(255, 15, 65, 131),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: DealCarousel(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Text('Left Drawer'),
      ),
      endDrawer: Drawer(
        child: Text('Right Drawer'),
      ),
    );
  }
}