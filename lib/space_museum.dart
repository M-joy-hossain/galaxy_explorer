import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class space_museum extends StatefulWidget {
  const space_museum({super.key});

  @override
  State<space_museum> createState() => _MuseumLevelScreenState();
}

class _MuseumLevelScreenState extends State<space_museum> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final params = const PlatformWebViewControllerCreationParams();

    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset('assets/museum_level.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Space Museum")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
