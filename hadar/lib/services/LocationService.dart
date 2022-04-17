
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class tst extends StatefulWidget {

  @override
  _tstState createState() => _tstState();
}

class _tstState extends State<tst> {

  Future<Position> getCurrLocation() async{
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrLocation(),
      builder:
          (BuildContext context, AsyncSnapshot<Position> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData) {
          Position position = snapshot.data!;

          return Container(
            height: 30,
            child: Text(position.latitude.toString() + ', ' + position.longitude.toString()),
          );
        }
        return Text("loading..");
      },
    );
  }

}