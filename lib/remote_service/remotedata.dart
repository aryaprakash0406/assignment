import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paprcliptask/models/performance.dart';
import '../models/overview.dart';

class RemoteData {
  Future<OverView?> fetchOverViewData() async {
    var url = Uri.parse(
        'https://api.stockedge.com/Api/SecurityDashboardApi/GetCompanyEquityInfoForSecurity/5051?lang=en');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return overViewFromJson(json);
    }
    return null;
  }

  Future<List<Performance>?> fetchPerformanceData() async {
    var url = Uri.parse(
        'https://api.stockedge.com/Api/SecurityDashboardApi/GetTechnicalPerformanceBenchmarkForSecurity/5051?lang=en');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return performanceFromJson(json);
    }
    return null;
  }
}
