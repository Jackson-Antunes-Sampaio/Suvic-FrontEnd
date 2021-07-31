import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSuvicScreen extends StatefulWidget {
  @override
  WebViewSuvicScreenState createState() => WebViewSuvicScreenState();
}

class WebViewSuvicScreenState extends State<WebViewSuvicScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: WebView(
          initialUrl: 'https://suvic.com.br/',
        ));
  }
}
