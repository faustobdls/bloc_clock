import 'package:flutter/material.dart';
import 'package:flutter_clock/app/home/home_bloc.dart';
import 'package:flutter_clock/app/home/home_module.dart';
import 'package:flutter_clock/app/models/clock.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    HomeModule.to.bloc<HomeBloc>().updateTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: StreamBuilder<Clock>(
                  stream: HomeModule.to.bloc<HomeBloc>().clockFlux,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('');
                    }
                    return Text(
                        '${snapshot.data.hour}:${snapshot.data.minute}:${snapshot.data.second}');
                  }),
            ),
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(0.0, 0.0),
                    spreadRadius: 1,
                    blurRadius: 20,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    spreadRadius: -1,
                    blurRadius: 12,
                  ),
                ],
              ),
              child: StreamBuilder<Clock>(
                  stream: HomeModule.to.bloc<HomeBloc>().clockFlux,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    // print('${snapshot.data.hourAngle}:${snapshot.data.minuteAngle}:${snapshot.data.secondAngle}');
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          top: 125,
                          left: 125,
                          child: Transform.rotate(
                            angle: radians(snapshot.data.hourAngle + 180),
                            alignment: Alignment.topLeft,
                            child: Container(
                              color: Colors.black38,
                              width: 2,
                              height: 100,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 125,
                          left: 125,
                          child: Transform.rotate(
                            angle: radians(snapshot.data.minuteAngle + 180),
                            alignment: Alignment.topLeft,
                            child: Container(
                              color: Colors.black,
                              width: 2,
                              height: 100,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 125,
                          left: 125,
                          child: Transform.rotate(
                            angle: radians(snapshot.data.secondAngle + 180),
                            alignment: Alignment.topLeft,
                            child: Container(
                              color: Colors.red,
                              width: 2,
                              height: 100,
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
