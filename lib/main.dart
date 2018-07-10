import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class MyButton extends AnimatedWidget {
  bool large = false;

  static final _sizeTween = new Tween<double>(begin: 1.0, end: 2.0);
  AnimationController controller;
  MyButton({Key key, Animation<double> animation, AnimationController controller}): super(key: key, listenable: animation)
  {
    this.controller = controller;
  }

  void onPressed() {
    if (!large) {
      controller.forward();
      large = true;
    } else {
      controller.reverse();
      large = false;
    }
  }

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Transform.scale(
      scale: _sizeTween.evaluate(animation),
      child: new RaisedButton(onPressed: onPressed, child: new Text('Click me'),),
    );
  }
}

class _State extends State<MyApp> with TickerProviderStateMixin{

  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text('Widgets here'),
              new MyButton(animation: animation,controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}