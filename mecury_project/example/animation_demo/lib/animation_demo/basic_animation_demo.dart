import 'package:flutter/material.dart';

/*
* 基础动画
* */

class HomeScreen extends StatefulWidget {
  @override
  State createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _nameController, _pwController;

  /// Animation是一个抽象类，它用于保存动画的插值和状态；
  /// Animation对象的输出值可以是线性的、曲线的、一个步进函数或者任何其他曲线函数。
  /// 可以通过Animation对象的value属性获取动画的当前值。
  /// addListener() 可以给Animation添加帧监听器，在每一帧都会被调用。主要用于UI重建
  /// addStatusListener()可以给Animation添加“动画状态改变”监听器；
  Animation _animation;

  /// AnimationController用于控制动画，它包含动画的启动forward()、停止stop() 、反向播放 reverse()等方法。
  AnimationController _animationController;

  /// Flutter中通过Curve（曲线）来描述动画过程，Curve可以是线性的(Curves.linear)，也可以是非线性的。
  /// CurvedAnimation 将动画过程定义为一个非线性曲线. 支持自定义。
  ///
  /// Tween的唯一职责就是定义从输入范围到输出范围的映射。
  /// Tween构造函数需要begin和end两个参数。支持自定义。
  /// 要使用Tween对象，需要调用其animate()方法，然后传入一个控制器对象。
  ///
  /// 创建一个AnimationController时，需要传递一个vsync参数，它接收一个TickerProvider类型的对象，它的主要职责是创建Ticker。
  /// 用于获取屏幕刷新的回调
  @override
  void initState() {
    _nameController = TextEditingController();
    _pwController = TextEditingController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pwController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  ///
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            body: Transform(
              transform:
                  Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
              child: SafeArea(
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 80.0),
                    Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 32.0),
                      ),
                    ),
                    const SizedBox(height: 80.0),
                    _buildTextField(_nameController, false, "name"),
                    _buildTextField(_pwController, true, "password"),
                    const SizedBox(height: 40.0),
                    ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          child: Text('login'),
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
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
              filled: true, labelText: labelText, fillColor: Colors.white),
        ),
      ),
    );
  }
}
