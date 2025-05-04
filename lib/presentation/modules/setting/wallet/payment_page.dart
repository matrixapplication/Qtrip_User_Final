import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaymentPage extends StatefulWidget {
  const PaymentPage(this.url, {super.key});
  final String url;
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewController _controller;
  bool isLoading = true;
  @override
  initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {

            setState(() {
              isLoading = false;
            });
            print('urlurl $url');
            if (url.contains('success')) {
              // نجاح

              Future.delayed(Duration(seconds: 2), () {
                if (!mounted) return; // اتأكد ان الـ Widget لسه موجود
                Navigator.pop(context, true); // رجع مع نتيجة success

              });
            } else if (url.contains('fail') || url.contains('error')) {
              // فشل

              Future.delayed(Duration(seconds: 2), () {
                Navigator.pop(context, false); // رجع مع نتيجة failure
              });
            }
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {
            log(error.description.toString());
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إتمام عملية الدفع')),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          if(isLoading)
            Center(child: CircularProgressIndicator())

        ],
      ),
    );
  }
}
