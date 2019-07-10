import 'package:flutter/material.dart';

class FadeDemo extends StatefulWidget {
  @override
  _AnimationFadeDemo createState() {
    // TODO: implement createState
    return _AnimationFadeDemo();
  }
}

class _AnimationFadeDemo extends State<FadeDemo> {

  bool _first = false;

  change() {
    setState(() {
      _first = _first ? false : true;
    });
  }

  StatelessWidget createLogo() {
    if (_first) {
      return FlutterLogo(
        style: FlutterLogoStyle.horizontal,
        size: 200,
      );
    } else {
      return FlutterLogo(
        style: FlutterLogoStyle.stacked,
        size: 200,
      );
    }
  }

  StatelessWidget createLogoByFlag(bool flag) {
    if (flag) {
      return FlutterLogo(
        style: FlutterLogoStyle.horizontal,
        size: 200,
      );
    } else {
      return FlutterLogo(
        style: FlutterLogoStyle.stacked,
        size: 200,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Center(
      child: GestureDetector(
//        child: createLogoByFlag(_first),
        onTap: change,
        child: AnimatedCrossFade(firstChild: createLogoByFlag(true),
            secondChild: createLogoByFlag(false),
            crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(seconds: 2)),
      )
      ,
    );
  }
}
