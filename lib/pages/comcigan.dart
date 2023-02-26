import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

class Comcigan extends StatelessWidget {
  const Comcigan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return const Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: 'http://xn--s39aj90b0nb2xw6xh.kr/',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
