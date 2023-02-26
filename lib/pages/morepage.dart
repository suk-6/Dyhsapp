import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        appBar: AppBar(
          title: const Text("더보기"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
              child: Column(children: const [
            Text("현재 이 앱은 베타버전으로 많은 오류가 존재합니다."),
            SizedBox(height: 15),
            Text("문의: support@dyhs.kr"),
            SizedBox(height: 15),
            Text("개발: https://suk.kr"),
            SizedBox(height: 15),
            Text("Copyright 2023. suk-6 All rights reserved.")
          ])),
        ));
  }
}
