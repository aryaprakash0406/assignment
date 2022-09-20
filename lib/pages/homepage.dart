import 'package:flutter/cupertino.dart';
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
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff000087)),
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
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "View More",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Performance",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff000087)),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _performanceList?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: performanceTile(
                                  _performanceList![index].label,
                                  _performanceList![index].changePercent),
                            );
                          }),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "View More",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Row performanceTile(String label, double percent) {
    var modifiedPercent = double.parse(percent.toStringAsFixed(1));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 60,
            child: Text(
              label,
            )),
        Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 20,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffD9D9D9),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(microseconds: 800),
                  height: 20,
                  width:
                      percent > 400 ? 200 : 200 * modifiedPercent.abs() / 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: percent > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          width: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              percent > 0
                  ? const Icon(
                      CupertinoIcons.arrowtriangle_up_fill,
                      size: 10,
                      color: Colors.green,
                    )
                  : const Icon(
                      CupertinoIcons.arrowtriangle_down_fill,
                      size: 10,
                      color: Colors.red,
                    ),
              Text("${(percent).toStringAsFixed(1)}%")
            ],
          ),
        )
      ],
    );
  }

  Row overViewTile(String title, bool isIcon, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        const SizedBox(
          height: 30,
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
