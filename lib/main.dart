import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/hicache.dart';
import 'package:flutter_bilibili/http/core/hierror.dart';
import 'package:flutter_bilibili/http/core/hinet.dart';
import 'package:flutter_bilibili/http/request/testrequest.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    HiCache.preInit();
    super.initState();
  }

  void _incrementCounter() async {
    TestRequest request = TestRequest();
    request.add("2", "111");
    request.add("aa", "dd");
    try {
      var result = await HiNet.getInstance().fire(request);
    } on NeedAuth catch (e) {
      print(e);
    } on NeedLogin catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
    // test();
    // test2();
  }

  void test2(){
    HiCache.getInstance().setString("name", "cancan");
    var nameStr = HiCache.getInstance().get("name");
    print(nameStr);
  }

  void test(){
    const jsonString =  "{ \"name\": \"flutter\", \"url\": \"https://coding.imooc.com/class/487.html\" }";
    //json转Map
    Map<String,dynamic> jsonMap = jsonDecode(jsonString);
    print('name:${jsonMap['name']}');
    print('url:${jsonMap['url']}');
    //map转Json
    String json = jsonEncode(jsonMap);
    print('json:${json}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
