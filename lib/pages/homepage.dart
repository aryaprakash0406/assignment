import 'package:flutter/material.dart';
import 'package:paprcliptask/models/performance.dart';
import 'package:paprcliptask/remote_service/remotedata.dart';

import '../models/overview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RemoteData _remoteData = RemoteData();
  OverView? _overView;
  List<Performance>? _performanceList;
  bool isLoaded = false;

  getData() async {
    _overView = await _remoteData.fetchOverViewData();
    _performanceList = await _remoteData.fetchPerformanceData();
    if (_overView != null && _performanceList != null) {
      isLoaded = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stocks"),
      ),
      body: isLoaded
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Overview",
                        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                      overViewTile("Sector", true, _overView!.sector),
                      overViewTile("Industry", true, _overView!.industry),
                      overViewTile(
                          "Market Cap.", false, _overView!.mcap.toString()),
                      overViewTile("Enterprise Value (EV)", false,
                          _overView!.ev.toString()),
                      overViewTile("Book Value / Share", false,
                          _overView!.bookNavPerShare.toString()),
                      overViewTile("Price-Earning Ratio (PE)", false,
                          _overView!.ttmpe.toString()),
                      overViewTile(
                          "PEG Ratio", false, _overView!.pegRatio.toString()),
                      overViewTile("Dividend Yeild", false,
                          _overView!.overViewYield.toString()),
                    ],
                  ),
                )
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Row overViewTile(String title, bool isIcon, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            isIcon
                ? const Icon(
                    Icons.account_balance,
                    color: Colors.orange,
                  )
                : Container(),
            const SizedBox(
              width: 10,
            ),
            value == "null" ? const Text("-") : Text(value)
          ],
        )
      ],
    );
  }
}
