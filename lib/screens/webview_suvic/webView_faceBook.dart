import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSuvicFaceBook extends StatefulWidget {
  @override
  WebViewSuvicFaceBookState createState() => WebViewSuvicFaceBookState();
}

class WebViewSuvicFaceBookState extends State<WebViewSuvicFaceBook> {
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
          initialUrl: 'https://www.facebook.com/AppSuvic',
        ));
  }
}
