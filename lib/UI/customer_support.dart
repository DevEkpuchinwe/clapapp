import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  var loadingPercentage = 0;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
        onNavigationRequest: (request) {
          if (request.url == 'https://tawk.to') {
            // Block the main Tawk.to landing page
            return NavigationDecision.prevent;
          }
          // Allow all other URLs
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(
        Uri.parse('https://tawk.to/chat/669f0919becc2fed692923c4/1i3ejn3g5'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Support'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
            //controller.javascriptMode: JavascriptMode.unrestricted, // Enable unrestricted JavaScript
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const CircularProgressIndicator(
              color: Colors.deepOrangeAccent,
            ),
        ],
      ),
    );
  }
}

//void main() {
//  runApp(const MaterialApp(
//    home: CustomerSupport(),
//  ));
//}
