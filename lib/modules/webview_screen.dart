import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget
{
  final String url;

  WebViewScreen(this.url);

  WebViewController controller = WebViewController();
  
  @override
  Widget build(BuildContext context) {
    controller.loadRequest(Uri.parse(url));
    
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: controller),
    );
  }
}
