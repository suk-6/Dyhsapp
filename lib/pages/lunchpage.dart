import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

_callAPI(String date) async {
  const mscode = "J10";
  const sccode = "7531328";

  var url = Uri.parse(
      "https://open.neis.go.kr/hub/mealServiceDietInfo?ATPT_OFCDC_SC_CODE=$mscode&SD_SCHUL_CODE=$sccode&MLSV_FROM_YMD=$date&MLSV_TO_YMD=$date&Type=json");

  var response = await http.get(url);

  print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');

  return response.body;
}

class LunchPage extends StatelessWidget {
  const LunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // final DateTime now = DateTime.now();
    // final DateFormat formatter = DateFormat('yyyyMMdd');
    // final String date = formatter.format(now);
    // print(date); // something like 20130420

    // const String date = "20220321";

    // final response = _callAPI(date);
    // final parsedJson = json.decode(response).cast<Map<String, dynamic>>();
    // print(parsedJson['mealServiceDietInfo'][1]['row']);
    return const Text("현재 개발 중인 페이지입니다.");
    // return Container(
    //     child: FutureBuilder(
    //         future: parsedJson["DDISH_NM"],
    //         builder: (context, snapshot) {
    //           if (snapshot.hasData) {
    //             return Text(snapshot as String);
    //           } else if (!snapshot.hasData) {
    //             return Text("급식을 불러오지 못 했습니다.");
    //           }
    //           return CircularProgressIndicator();
    //         }));
  }
}
