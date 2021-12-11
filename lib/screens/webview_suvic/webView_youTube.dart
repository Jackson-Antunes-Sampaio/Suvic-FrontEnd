import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSuvicYouTube extends StatefulWidget {
  @override
  WebViewSuvicYouTubeState createState() => WebViewSuvicYouTubeState();
}

class WebViewSuvicYouTubeState extends State<WebViewSuvicYouTube> {
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
          initialUrl: 'https://www.youtube.com/channel/UCPyHKkz-FyxRgN9kJeYAKoA',
        ));
  }
}
