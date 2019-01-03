import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:hifidelity/components/gradient_raised_button.dart';
import 'package:hifidelity/model/timespan.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DealCarousel extends StatefulWidget {
  @override
  State createState() => _DealCarouselState();
}

class _DealCarouselState extends State<DealCarousel> {
  final data = [
    DealData(
      icon: 'assets/images/feather_icon.png',
      name: 'Feather Coin',
      normalCost: 1.0,
      newCostFactor: 0.2,
      tokenCount: 140,
      timeRemaining: TimeSpan.fromTime(days: 2, hours: 16, minutes: 1),
    ),
    DealData(
      icon: 'assets/images/aureus_icon.png',
      name: 'Aureus',
      normalCost: 1.0,
      newCostFactor: 0.35,
      tokenCount: 75,
      timeRemaining: TimeSpan.fromTime(days: 7, hours: 0, minutes: 55),
    ),
    DealData(
      icon: 'assets/images/monero_icon.png',
      name: 'Monero',
      normalCost: 1.0,
      newCostFactor: 0.2,
      tokenCount: 250,
      timeRemaining: TimeSpan.fromTime(days: 39, hours: 4, minutes: 21),
    ),
  ];

  var page = 0;

  void leftCarouselButtonPressed() {
    print('left');
    setState(() {
      page--;
    });
  }

  void rightCarouselButtonPressed() {
    print('right');
    setState(() {
      page++;
    });
  }

  Widget timeRemainingWidget(BuildContext cxt) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Container(
          width: 260,
          color: Color.fromARGB(255, 238, 238, 238),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TIME REMAINING',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(255, 131, 131, 131),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  '${data[page].timeRemaining.days.toString().padLeft(2, '0')}d',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 56, 152, 185),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '|',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(255, 131, 131, 131),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '${data[page].timeRemaining.hours.toString().padLeft(2, '0')}h',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 56, 152, 185),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '|',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(255, 131, 131, 131),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '${data[page].timeRemaining.minutes.toString().padLeft(2, '0')}m',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 56, 152, 185),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget carouselWidget(BuildContext cxt) {
    return Container(
      height: 300,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: page > 0 ? leftCarouselButtonPressed : null,
              child: Transform.rotate(
                angle: Math.pi,
                child: page > 0 ? Image.asset('assets/images/carousel_button.png') : Image.asset('assets/images/carousel_button_disabled.png'),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: Image.asset(data[page].icon),
                      ),
                      Text(
                        data[page].name,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: AutoSizeText(
                      'at a',
                      minFontSize: 1,
                      maxFontSize: 999,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LayoutBuilder(
                        builder: (cxt, constraints) { 
                          print(constraints.biggest.width);
                          return Container(
                            width: constraints.biggest.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (100 - (data[page].newCostFactor * 100)).toInt().toString(),
                                  style: TextStyle(
                                    fontSize: 72 * (constraints.biggest.width / 130),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  '%',
                                  style: TextStyle(
                                    fontSize: 18 * (constraints.biggest.width / 130),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                      AutoSizeText(
                        'DISCOUNT',
                        maxLines: 1,
                        minFontSize: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\$${data[page].normalCost.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                              ),
                              TextSpan(
                                text: '\$${(data[page].normalCost * data[page].newCostFactor).toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 56, 152, 185),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                      AutoSizeText(
                        'ON THE DOLLAR',
                        maxLines: 1,
                        minFontSize: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: page < data.length - 1 ? rightCarouselButtonPressed : null,
              child: page < data.length - 1 ? Image.asset('assets/images/carousel_button.png') : Image.asset('assets/images/carousel_button_disabled.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget getDealWidget(BuildContext cxt) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Color.fromARGB(255, 100, 100, 100),
                fontSize: 18,
              ),
              children: [
                TextSpan(
                  text: 'Buy up to ',
                ),
                TextSpan(
                  text: data[page].tokenCount.toString(),
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 152, 185),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' tokens',
                ),
              ],
            ),
          ),
          GradientRaisedButton(
            width: 150,
            height: 35,
            onPressed: () {},
            child: Text(
              'GET THIS DEAL',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            gradient: LinearGradient(
              begin: Alignment(-0.02, -1),
              end: Alignment(0.02, 1),
              colors: [
                Color.fromARGB(255, 15, 65, 131),
                Color.fromARGB(255, 14, 57, 112),
              ],
              stops: [
                0.69,
                0.71,
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext cxt) {
    return Column(
      children: [
        timeRemainingWidget(cxt),
        carouselWidget(cxt),
        getDealWidget(cxt),
      ]
    );
  }
}

class DealData {
  final String icon;
  final String name;
  final double normalCost;
  final double newCostFactor;
  final int tokenCount;
  final TimeSpan timeRemaining;

  DealData({
    this.icon,
    this.name,
    this.normalCost,
    this.newCostFactor,
    this.tokenCount,
    this.timeRemaining,
  });
}