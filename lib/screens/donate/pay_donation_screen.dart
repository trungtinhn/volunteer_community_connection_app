import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:uni_links/uni_links.dart';
import 'package:volunteer_community_connection_app/screens/bottom_nav/bottom_nav.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayDonation extends StatefulWidget {
  final String url;
  const PayDonation({super.key, required this.url});

  @override
  State<PayDonation> createState() => _PayDonationState();
}

class _PayDonationState extends State<PayDonation> {
  StreamSubscription? _sub;
  String paymentStatus = '';
  String paymentUrl = '';
  double _progress = 0.0;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _progress = progress / 100.0;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (url.contains('/api/Vnpay/Callback')) {
              final uri = Uri.parse(url);
              final transactionStatus =
                  uri.queryParameters['vnp_TransactionStatus'];
              final responseCode = uri.queryParameters['vnp_ResponseCode'];
              if (transactionStatus == '00' && responseCode == '00') {
                Get.snackbar(
                  "Giao dịch thành công",
                  "Thanh toán thành công",
                  snackPosition: SnackPosition.BOTTOM,
                );
                Get.to(() => const BottomNavigation());
              } else {
                Get.snackbar(
                  "Giao dịch thất bại",
                  "Thanh toán thất bại",
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            }
          },
          onHttpError: (HttpResponseError error) {
            // Get.snackbar(
            //   "Lỗi HTTP",
            //   "Mô tả: ${error.toString()}",
            //   snackPosition: SnackPosition.BOTTOM,
            // );
          },
          onWebResourceError: (WebResourceError error) {
            // Get.snackbar(
            //   "Lỗi tài nguyên",
            //   "Mô tả: ${error.description}",
            //   snackPosition: SnackPosition.BOTTOM,
            // );
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _initDeepLinkListener() async {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null && uri.scheme == 'vnpay' && uri.host == 'callback') {
        final status = uri.queryParameters['status'];
        final message = uri.queryParameters['message'];
        setState(() {
          paymentStatus = (status == 'success')
              ? 'Thanh toán thành công: $message'
              : 'Thanh toán thất bại: $message';
        });
        _showPaymentResult(paymentStatus);
      }
    }, onError: (err) {
      setState(() {
        paymentStatus = 'Lỗi xử lý callback: $err';
      });
      _showPaymentResult(paymentStatus);
    });
  }

  void _showPaymentResult(String result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result.contains('thành công') ? 'Thành công' : 'Thất bại'),
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thanh toán",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          if (_progress < 1.0) LinearProgressIndicator(value: _progress),
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: kLabelSize15Blackw600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(content, style: kLableSize15Black),
          ),
        ],
      ),
    );
  }
}
