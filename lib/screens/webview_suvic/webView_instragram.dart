import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSuvicInstagram extends StatefulWidget {
  @override
  WebViewSuvicInstagramState createState() => WebViewSuvicInstagramState();
}

class WebViewSuvicInstagramState extends State<WebViewSuvicInstagram> {
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
          initialUrl: 'https://www.instagram.com/appsuvic/',
        ));
  }
}
