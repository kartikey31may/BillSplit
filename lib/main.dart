import 'package:flutter/material.dart';
import 'package:flutter_second/CustomShapeClipper.dart';
import 'package:flutter_second/screens/SplitBillPeople.dart';
import 'package:permission_handler/permission_handler.dart';


void main() => runApp(new FlutterApp());

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UI DESIGN",
      debugShowCheckedModeBanner: false,
      home: ActivityUi(),
    );
  }
}

class ActivityUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[ClipedActivity()],
      ),
    );
  }
}

class ClipedActivity extends StatefulWidget {
  @override
  _ClipedActivityState createState() => _ClipedActivityState();
}

class _ClipedActivityState extends State<ClipedActivity> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 400.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFF46D15), Color(0xFFEF772C)])),
            )),
        //SizedBox(height: 50.0),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          padding: EdgeInsets.all(20.0),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        debugPrint("Menu Button");
                      },
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                      )),
                  Expanded(
                      child: TextField(
                        textDirection: TextDirection.ltr,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0),
                            border: InputBorder.none,
                            hintText: "Search For Entries",
                            hintStyle: TextStyle(color: Colors.black54)),
                      )),
                  GestureDetector(
                      onTap: () {
                        debugPrint("Setting pressed");
                      },
                      child: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ))
                ],
              ),
            ),
          ),
        ), //search bar
        //SizedBox(height: 30.0),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white54),
          margin: EdgeInsets.only(top: 125.0, left: 20.0, right: 20.0),
          padding: EdgeInsets.all(20.0),
          child: Row(children: <Widget>[
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Total Spenditure",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Color(0xFFF46D15),
                      ),
                    ),
                    Text("0.0",
                        style: TextStyle(
                            fontSize: 50.0, color: Colors.black54)),
                  ],
                )),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Left Balance",
                      style: TextStyle(
                          fontSize: 25.0, color: Color(0xFFF46D15)),
                    ),
                    Text("0.0",
                        style: TextStyle(
                            fontSize: 50.0, color: Colors.black54)),
                  ],
                ))
          ]),
        ), //DashBoard
        Container(
            margin: EdgeInsets.only(top: 320.0),
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                    child: Icon(
                      Icons.add,
                      color: Colors.black45,
                    ),
                    elevation: 10.0,
                    tooltip: "Add new Bill",
                    backgroundColor: Colors.orange,
                    onPressed: _onclickfloatingbutton)
              ],
            )),

        Container(
          margin: EdgeInsets.only(top: 400.0, left: 20.0, right: 20.0),
          child: ListTile(
            title: Text("abcdefghijklmnopqrstuvwxyz"),
            subtitle: Text("abcdefghijklmnopqrstuvwxyz"),
            leading: Icon(Icons.arrow_drop_up, color: Colors.green,),
            trailing: Text("40", style: TextStyle(fontSize: 30.0),),
          ),
        ) //list
      ],
    );
  }

  _onclickfloatingbutton() {
    debugPrint("Floating Action button");
    PermissionStatus ps=PermissionStatus.unknown;
    final Future<PermissionStatus> statusFuture =
    PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
    statusFuture.then((PermissionStatus status) async {
    ps = status;

    if(ps == PermissionStatus.denied){
      Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
      PermissionStatus _status = permissions[PermissionGroup.contacts];

      if(_status == PermissionStatus.denied){
        PermissionHandler().openAppSettings().then((bool hasOpened) =>
            debugPrint('App Settings opened: ' + hasOpened.toString()));
      }
      else if(_status ==PermissionStatus.granted){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SplitBillPeople()));
      }
    }else if(ps == PermissionStatus.granted){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplitBillPeople()));
    }
    });
  }

}
