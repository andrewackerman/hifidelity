import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hifidelity/blocs_test/stats_bloc/bloc.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/components/localization_drawer.dart';
import 'package:hifidelity/components/navigation_drawer.dart';
import 'package:hifidelity/screens/dashboard/components/deal_carousel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hifidelity/components/gradient_progress_indicator.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  StatsBloc _statsBloc;

  @override
  void initState() {
    super.initState();
    _statsBloc = BlocProvider.of<StatsBloc>(context);
  }

  void _drawerLanguageButtonClicked(BuildContext cxt) {
    _scaffoldKey.currentState.openEndDrawer();
  }

  Widget tokensOwnedBar(BuildContext cxt) {
    return Container(
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
      child: BlocBuilder(
        bloc: _statsBloc,
        builder: (BuildContext context, StatsState state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: AppInheritedWidget.of(cxt).language.code == 'ja-JP'
              ? [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    AppInheritedWidget.of(cxt)
                        .text('TokensOwned', category: 'overview'),
                    style: TextStyle(
                      color: Color.fromARGB(255, 100, 100, 100),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    (state is StatsLoaded)
                        ? state.totalTokens.toString()
                        : AppInheritedWidget.of(cxt)
                          .text('Loading', category: 'overview'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color.fromARGB(255, 16, 65, 131),
                    ),
                  ),
                ),
              ]
              : [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    (state is StatsLoaded)
                      ? state.totalTokens.toString()
                      : AppInheritedWidget.of(cxt)
                        .text('Loading', category: 'overview'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color.fromARGB(255, 16, 65, 131),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    AppInheritedWidget.of(cxt)
                        .text('TokensOwned', category: 'overview'),
                    style: TextStyle(
                      color: Color.fromARGB(255, 100, 100, 100),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
          );
        }),
    );
  }

  Widget tokenProgressBar(BuildContext cxt) {
    return Container(
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
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: BlocBuilder(
              bloc: _statsBloc,
              builder: (BuildContext context, StatsState state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (state is StatsLoaded)
                      ? AppInheritedWidget.of(cxt)
                        .text('Level', category: 'overview') + '${state.currentLevel}'
                      : AppInheritedWidget.of(cxt)
                        .text('Loading', category: 'overview'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      )),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(cxt).style.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                        children: AppInheritedWidget.of(cxt).language.code ==
                          'ja-JP'
                          ? (state is StatsLoaded
                            ? [
                              TextSpan(
                                text: AppInheritedWidget.of(cxt)
                                  .text('Level', category: 'overview') + '${state.currentLevel + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: AppInheritedWidget.of(cxt)
                                  .text('TokensUntil', category: 'overview')),
                              TextSpan(
                                text: '${state.tokensUntilNextLevel}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            ]
                            : [
                              TextSpan(
                                text: AppInheritedWidget.of(cxt)
                                  .text('Loading', category: 'overview')),
                              ]
                          )
                          : (state is StatsLoaded
                            ? [
                              TextSpan(
                                text: '${state.tokensUntilNextLevel}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: AppInheritedWidget.of(cxt)
                                  .text('TokensUntil', category: 'overview')),
                              TextSpan(
                                text: AppInheritedWidget.of(cxt)
                                  .text('Level', category: 'overview') + '${state.currentLevel + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            ]
                            : [
                              TextSpan(
                                text: AppInheritedWidget.of(cxt)
                                  .text('Loading', category: 'overview')),
                            ]
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GradientProgressIndicator(value: 0.75),
          ),
        ],
      ),
    );
  }

  Widget dealCarouselBar(BuildContext cxt) {
    return Container(
      color: Color.fromARGB(255, 249, 249, 249),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                AppInheritedWidget.of(cxt)
                    .text('CurrentDeals', category: 'overview'),
                style: TextStyle(
                  color: Color.fromARGB(255, 15, 65, 131),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    AppInheritedWidget.of(cxt)
                      .text('ComingSoon', category: 'overview'),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ), // DealCarousel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext cxt) {
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 57, 153, 184),
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Center(child: Image.asset('assets/images/7tk_title.png')),
          ),
          actions: [
            InkWell(
              onTap: () => _drawerLanguageButtonClicked(cxt),
              child: Row(
                children: [
                  Text(AppInheritedWidget.of(cxt).language.displayCode),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 12),
                    child: Icon(MdiIcons.earth, size: 32),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: tokensOwnedBar(cxt),
              ),
              Expanded(
                flex: 5,
                child: tokenProgressBar(cxt),
              ),
              Expanded(
                flex: 26,
                child: dealCarouselBar(cxt),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
        drawer: NavigationDrawer(),
        endDrawer: LocalizationDrawer(),
      ),
      onWillPop: () {},
    );
  }
}
