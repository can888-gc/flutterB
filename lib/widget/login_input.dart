import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {

  final String title;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType? keyboardType;


  const LoginInput(this.title, this.hint, {Key? key,
    this.onChanged, this.focusChanged,
    this.lineStretch = false, this.obscureText = false, this.keyboardType
  }) : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {

  final _focusNode =  FocusNode();

  @override
  void initState() {
    super.initState();
    //是否获取到光标的监听
    _focusNode.addListener(() {
      print("获取到光标:${_focusNode.hasFocus}");
      if(widget.focusChanged != null){
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: Text(widget.title,style: const TextStyle(fontSize: 16),),
            ),
            _input()
          ],
        )
      ],
    );
  }

  _input() {
    return Expanded(child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      style: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        contentPadding:const EdgeInsets.only(left: 20,right: 20),
        border: InputBorder.none,
        hintText: widget.hint,
        hintStyle: const TextStyle(fontSize: 15,color: Colors.grey)
      ),
    ));
  }
}
