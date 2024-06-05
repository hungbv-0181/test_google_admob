import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class NativeView extends StatefulWidget {
  final String adUnitID;
  final String adType; // banner or mediumRectangle

  const NativeView({super.key, required this.adUnitID, required this.adType, });

  @override
  State<StatefulWidget> createState() => _NativeViewState();
}

class _NativeViewState extends State<NativeView> {
  late UiKitView uiKitView;

  @override
  void initState() {
    super.initState();

    var params = {
      "adUnitID": widget.adUnitID,
      "adType": widget.adType,
    };
    uiKitView = UiKitView(
      viewType: "plugins/native_view",
      creationParams: params,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: widget.adType == "banner" ? 50 : 250,
      child: uiKitView,
    );
  }
}
