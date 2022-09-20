// To parse this JSON data, do
//
//     final overView = overViewFromJson(jsonString);

import 'dart:convert';

OverView overViewFromJson(String str) => OverView.fromJson(json.decode(str));

String overViewToJson(OverView data) => json.encode(data.toJson());

class OverView {
    OverView({
        required this.id,
        required this.security,
        required this.industryId,
        required this.industry,
        required this.sectorId,
        required this.sector,
        required this.mcap,
        required this.ev,
        required this.evDateEnd,
        required this.bookNavPerShare,
        required this.ttmpe,
        required this.ttmYearEnd,
        required this.overViewYield,
        required this.yearEnd,
        required this.sectorSlug,
        required this.industrySlug,
        required this.securitySlug,
        required this.pegRatio,
    });

    final int id;
    final String security;
    final int industryId;
    final String industry;
    final int sectorId;
    final String sector;
    final double mcap;
    final dynamic ev;
    final dynamic evDateEnd;
    final double bookNavPerShare;
    final double ttmpe;
    final int ttmYearEnd;
    final double overViewYield;
    final int yearEnd;
    final String sectorSlug;
    final String industrySlug;
    final String securitySlug;
    final double pegRatio;

    factory OverView.fromJson(Map<String, dynamic> json) => OverView(
        id: json["ID"],
        security: json["Security"],
        industryId: json["IndustryID"],
        industry: json["Industry"],
        sectorId: json["SectorID"],
        sector: json["Sector"],
        mcap: json["MCAP"].toDouble(),
        ev: json["EV"],
        evDateEnd: json["EVDateEnd"],
        bookNavPerShare: json["BookNavPerShare"].toDouble(),
        ttmpe: json["TTMPE"].toDouble(),
        ttmYearEnd: json["TTMYearEnd"],
        overViewYield: json["Yield"].toDouble(),
        yearEnd: json["YearEnd"],
        sectorSlug: json["SectorSlug"],
        industrySlug: json["IndustrySlug"],
        securitySlug: json["SecuritySlug"],
        pegRatio: json["PEGRatio"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "Security": security,
        "IndustryID": industryId,
        "Industry": industry,
        "SectorID": sectorId,
        "Sector": sector,
        "MCAP": mcap,
        "EV": ev,
        "EVDateEnd": evDateEnd,
        "BookNavPerShare": bookNavPerShare,
        "TTMPE": ttmpe,
        "TTMYearEnd": ttmYearEnd,
        "Yield": overViewYield,
        "YearEnd": yearEnd,
        "SectorSlug": sectorSlug,
        "IndustrySlug": industrySlug,
        "SecuritySlug": securitySlug,
        "PEGRatio": pegRatio,
    };
}
