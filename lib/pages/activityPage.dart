import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

// 活动页面
class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  //  初始动画状态
  FlareControls _controls = FlareControls();

  String _animation = "night_idle";

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(
            'Animation',
            style: TextStyle(color: Colors.blue),
          ),
          GestureDetector(
            onTap: () {
              _controls.play(!isCheck ? 'switch_day' : 'switch_night');
              setState(() {
                _animation = !isCheck ? 'day_idle' : 'night_idle';
                isCheck = !isCheck;
              });
            },
            child: Container(
              height: 160.0,
              width: 180.0,
              child: FlareActor(
                'flrs/switch_daytime.flr',
                alignment: Alignment.center,
                fit: BoxFit.contain,
                controller: _controls,
                animation: _animation,
                callback: (name) {
                  print(name);
                  if (name == 'switch_day' || name == 'switch_night') {

                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
