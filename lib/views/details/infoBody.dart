import 'package:flutter/material.dart';
import 'package:floaps/templates/Pokemon.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InfoBody extends StatefulWidget {
  final Pokemon pok;

  InfoBody(this.pok);

  @override
  _InfoBodyState createState() => _InfoBodyState();
}

class _InfoBodyState extends State<InfoBody> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> images = carouselTiles(widget.pok.sprites);
    List<Widget> dots = [];

    for (int i = 0; i < images.length; i++) {
      dots.add(Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == i
                ? Color.fromRGBO(0, 0, 0, 0.9)
                : Color.fromRGBO(0, 0, 0, 0.4)),
      ));
    }
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            CarouselSlider(
              enableInfiniteScroll: true,
              reverse: false,
              height: MediaQuery.of(context).size.height * 0.3,
              viewportFraction: 0.3,
              items: images,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              enlargeCenterPage: true,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: dots),
          ],
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Card(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('Weight'),
                    subtitle: Text(
                      widget.pok.weight.toString(),
                    ),
                  ),
                ),
              ),
              Card(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('Height'),
                    subtitle: Text(
                      widget.pok.height.toString(),
                    ),
                  ),
                ),
              ),
              Card(child: gauge(5, 2.55)),
              Card(child: gauge(4, 1.9)),
              Card(child: gauge(3, 2.3)),
              Card(child: gauge(2, 1.94)),
              Card(child: gauge(1, 2.3)),
              Card(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('Order'),
                    subtitle: Text(
                      widget.pok.data['order'].toString(),
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

  List<Widget> carouselTiles(Map<dynamic, dynamic> sprites) {
    List<Widget> tiles = List();
    sprites.forEach((key, value) {
      if (value != null) {
        tiles.add(
          Card(
              child: Container(
            height: 250,
            width: 180,
            child: Stack(
              children: <Widget>[
                Center(child: Image.network(value)),
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      key,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  bottom: 0,
                  left: 0,
                  right: 0,
                )
              ],
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(0, 2), blurRadius: 8),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              border: Border.all(color: Colors.blue, width: 4),
            ),
          )),
        );
      }
    });
    return tiles;
  }

  Widget gauge(int index, double max) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              widget.pok.stats[index]['stat']['name'],
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
          AnimatedCircularChart(
            size: Size(120, 120),
            initialChartData: <CircularStackEntry>[
              CircularStackEntry(
                <CircularSegmentEntry>[
                  CircularSegmentEntry(
                    widget.pok.stats[index]['base_stat'] / max,
                    Colors.blue[400],
                    rankKey: 'completed',
                  ),
                  CircularSegmentEntry(
                    100 - widget.pok.stats[index]['base_stat'] / max,
                    Colors.blueGrey[600],
                    rankKey: 'remaining',
                  ),
                ],
                rankKey: 'progress',
              ),
            ],
            chartType: CircularChartType.Radial,
            percentageValues: true,
            holeLabel: widget.pok.stats[index]['base_stat'].toString(),
            labelStyle: TextStyle(
              color: Colors.blueGrey[600],
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
