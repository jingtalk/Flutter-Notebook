import 'package:flutter/material.dart';

/**
 * 我们可以简单认为Stateful widget 和Stateless widget有两点不同：

    Stateful widget可以拥有状态，这些状态在widget生命周期中是可以变的，而Stateless widget是不可变的。
    Stateful widget至少由两个类组成：

    一个StatefulWidget类。
    一个 State类； StatefulWidget类本身是不变的，但是 State类中持有的状态在widget生命周期中可能会发生变化。
 */

class HomeScreen extends StatefulWidget {
  @override
  State createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController;
  TextEditingController _pwController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _pwController = TextEditingController();
    super.initState();
  }

  /// Scaffold 是 Material库中提供的一个widget, 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性。
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
    );
  }

  /// TextField 用于文本输入
  /// TextEditingController 编辑框的控制器，通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件。
  /// 大多数情况下我们都需要显式提供一个controller来与文本框交互。如果没有提供controller，则TextField内部会自动创建一个。
  /// InputDecoration：用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
  /// obscureText：是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换
  Widget _buildTextField(TextEditingController controller, bool obscureText, String labelText) {
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
//              hintText: "提示语"
//              fillColor: Colors.white
          ),
        ),
      ),
    );
  }
}
