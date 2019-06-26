import 'package:flutter/material.dart';

/*
* 延迟动画
* */

class HomeScreen extends StatefulWidget {
  @override
  State createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _nameController, _pwController;

  Animation _animationTitle, _animationTextField, _animationButton;
  AnimationController _animationController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _pwController = TextEditingController();

    /// 共用一个 AnimationController
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 2, milliseconds: 50));

    /// 交错动画
    /// 我们可以给不同动画指定起始点和终止点来决定它们的开始时间和终止时间。
    _animationTitle = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn));
    _animationTextField = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 1.0, curve: Curves.fastOutSlowIn)));
    _animationButton = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn)));
    _animationController.forward();

//    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            body: SafeArea(
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 80.0),
                  Transform(
                    transform: Matrix4.translationValues(
                        _animationTitle.value * width, 0.0, 0.0),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 32.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80.0),
                  Transform(
                    transform: Matrix4.translationValues(
                        _animationTextField.value * width, 0.0, 0.0),
                    child: _buildTextField(_nameController, false, "name"),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        _animationTextField.value * width, 0.0, 0.0),
                    child: _buildTextField(_pwController, true, "password"),
                  ),
                  const SizedBox(height: 40.0),
                  Transform(
                      transform: Matrix4.translationValues(
                          _animationButton.value * width, 0.0, 0.0),
                      child: ButtonBar(
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {},
                            child: Text('login'),
                            color: Colors.white,
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTextField(
      TextEditingController controller, bool obscureText, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
//              filled: true,
            labelText: labelText,
//              fillColor: Colors.white
          ),
        ),
      ),
    );
  }
}
