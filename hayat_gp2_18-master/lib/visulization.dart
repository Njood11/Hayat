import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  Chart(this.Cid, {Key? key}) : super(key: key);
  var Cid;

  @override
  _ChartState createState() => _ChartState(this.Cid);
}

class _ChartState extends State<Chart> {
  var Cid;
  _ChartState(this.Cid);
  List<GDPData> chartData = [
    GDPData('Donations : ', 0),
    GDPData('Contracts : ', 0),
    GDPData('People covered : ', 0),
  ];
  late TooltipBehavior _tooltipBehavior;
  int donations = 0;
  int contracts = 0;
  int quantity = 0;
  List<ParseObject> allDonations = <ParseObject>[];
  List<ParseObject> qlist = <ParseObject>[];

  void getDonations(String? CID) async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('donations'))
          ..whereEqualTo("RequesterCHOid", CID);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        allDonations = apiResponse.results as List<ParseObject>;
        donations = allDonations.length;
      });
    } else {
      donations = 0;
    }
    for (int i = 0; i < allDonations.length; i++) {
      int q = allDonations[i].get('aq');
      quantity = quantity + q;
    }
    setState(() {
      chartData = [
        GDPData('Donations : $donations', donations),
        GDPData('Contracts : $contracts', 20),
        GDPData('People covered : $quantity', quantity),
      ];
    });
  }

  void getQuantity(String? CID) async {
/*
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('donations'))
          ..whereEqualTo("RequesterCHOid", CID)
          ..keysToReturn(["aq"]);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        qlist = apiResponse.results as List<ParseObject>;
        for (var i = 0; i < qlist.length; i++) {
          var q = int.parse(qlist[i].toString());
          quantity = quantity + q;
          print(quantity);
        }
      });
    } else {
      quantity = 0;
    }*/

    getDonations(Cid);
    for (int i = 0; i <= allDonations.length; i++) {
      var q = int.parse(allDonations[i].get('aq'));
      quantity = quantity + q;
      print(quantity);
    }
  }

  List<GDPData> getChartData() {
    chartData = [
      GDPData('Donations : $donations', donations),
      GDPData('Contracts : $contracts', 2490),
      GDPData('People covered : $quantity', quantity),
    ];
    return chartData;
  }

  @override
  void initState() {
    super.initState();
    getDonations(Cid);
    chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Hayat food donation',
          ),
          backgroundColor: Colors.teal[200],
          elevation: 0.0,
        ),
        body: SfCircularChart(
          title: ChartTitle(
              text: 'Statistics for this year',
              textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              textStyle: TextStyle(fontSize: 18)),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            PieSeries<GDPData, String>(
              dataSource: chartData,
              xValueMapper: (GDPData data, _) => data.continent,
              yValueMapper: (GDPData data, _) => data.gdp,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              enableTooltip: true,
            )
          ],
        ));
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
