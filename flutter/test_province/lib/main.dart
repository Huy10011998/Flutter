import 'package:flutter/material.dart';
import 'package:test_province/model/province.dart';
import 'package:test_province/model/service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  List<Province> provinces = List();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() => isLoading = true);

      await Api().getAllProvincesOfVietNam(onSuccess: (values) {
        setState(() {
          isLoading = false;
          provinces = values;
        });
      }, onError: (msg) {
        setState(() => isLoading = false);
        print(msg);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(isLoading.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text('PROVINCES OF VIET NAM'),
          backgroundColor: Colors.green[300],
        ),
        body: isLoading
            ? Center(
                child: Text("loading..."),
              )
            : provinces.isEmpty
                ? Center(
                    child: Text("empty"),
                  )
                : ListView(
                    children: provinces.map((province) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      color: Colors.green[100],
                      child: Text(province.name),
                    );
                  }).toList()));
  }
}
