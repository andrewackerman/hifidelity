import 'package:flutter/material.dart';
import 'package:hifidelity/components/gradient_raised_button.dart';

class DealCarousel extends StatefulWidget {
  @override
  State createState() => _DealCarouselState();
}

class _DealCarouselState extends State<DealCarousel> {
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
                  '02d',
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
                  '16h',
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
                  '00m',
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

  Widget carousel(BuildContext cxt) {
    return Container(color: Colors.blue, height: 300);
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
                  text: '140',
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
        carousel(cxt),
        getDealWidget(cxt),
      ]
    );
  }
}