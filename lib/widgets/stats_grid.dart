import 'package:flutter/material.dart';
import 'package:ico/data/network.dart';

class StatsGrid extends StatefulWidget {
  @override
  _CoronaVirusAppState createState() => _CoronaVirusAppState();
}
  Future data;
class _CoronaVirusAppState extends State<StatsGrid> {
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData();
    data.then( (value) => {
      print (value[0]['name'])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery
          .of(context)
          .size
          .height * 0.25,
      child: Column(


        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                FutureBuilder(
                  future: data,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.hasData){
                      return _buildStatCard("Kasus Positif", snapshot.data[0]["positif"], Colors.orange);
                    }else{
                      return CircularProgressIndicator();
                    }

                  },
                )

              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                FutureBuilder(
                  future: data,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.hasData){
                      return _buildStatCard("Sembuh", snapshot.data[0]["sembuh"], Colors.green);
                    }else{
                      return CircularProgressIndicator();
                    }

                  },
                ),
                FutureBuilder(
                  future: data,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.hasData){
                      return _buildStatCard("Korban Meninggal", snapshot.data[0]["meninggal"], Colors.red);
                    }else{
                      return CircularProgressIndicator();
                    }

                  },
                )
              ],
            ),
          ),
        ],


      ),
    );
  }

  Widget createTextFromApi() {
    return Container(
        child: FutureBuilder(
          future: data,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData){
              return _buildStatCard("Total Kasus", snapshot.data[0]["positif"], Colors.orange);
            }else{
              return CircularProgressIndicator();
            }

          },
        )
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getData() async {
    Network network = Network("https://api.kawalcorona.com/indonesia/");
    return network.fetchData();
  }
}

