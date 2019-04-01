import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_second/widget/loader.dart';


class SplitBillPeople extends StatefulWidget {
  @override
  _SplitBillPeopleState createState() => _SplitBillPeopleState();
}

class _SplitBillPeopleState extends State<SplitBillPeople> {
  Iterable<Contact> _contacts = [], _initialContacts = [];

  @override
  void initState() {
    // TODO: implement initState
    refreshContacts();
    super.initState();
  }

  refreshContacts() async {
      var contacts = await ContactsService.getContacts();
      setState(() {
        _initialContacts = contacts;
        _contacts = _initialContacts;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Material(
          child: Container(
              margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Material(
                      elevation: 6.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                          child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextField(
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20.0),
                                border: InputBorder.none,
                                hintText: "Search For People",
                                hintStyle: TextStyle(color: Colors.black54)),
                                onChanged: _refreshList,
                          )),
                        ],
                      ))),

                SizedBox(height:10.0),
                  Expanded(child: getListView())
                ],
              )),
        ));
  }

  Widget getListView(){

    if(_initialContacts.isEmpty) {
      return Container(
          child: Loader()
      );
    }

    var listView = ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (context, index){ //_contacts.elementAt(index).displayName //items[index]
        Iterable<Item> Phones= _contacts.elementAt(index).phones;
        String number = "";
        Image ig;
        if(Phones.isNotEmpty){
        number = Phones.first.value;
        }else{
         number = "No Number Found";
        }
        Uint8List image = _contacts.elementAt(index).avatar;

        return ListTile(
          onTap: _selectedContacts(_contacts.elementAt(index)),
          leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: (image.isNotEmpty) ? MemoryImage(image) : AssetImage('assets/person.png'),
              )
              )
          ),
          subtitle: Text(number),
          title: Text(_contacts.elementAt(index).displayName),
        );
      },
    );

    return listView;
  }

  void _refreshList(String value) {
    debugPrint(value);
    Iterable<Contact> temp;
    List<Contact> temp2=[];
    int length = _initialContacts.length;
    if(value!="" && length > 0){
      for(Contact t in _initialContacts){
        if(t.displayName.toLowerCase().startsWith(value.toLowerCase())){
          temp2.add(t);
          debugPrint(t.displayName);
        }
      }
      temp = temp2;
      setState(() {
        _contacts=temp;
        debugPrint(_contacts.length.toString());
      });
    }else{
      setState(() {
        _contacts=_initialContacts;
      });
    }

  }

  _selectedContacts(Contact contact) {

  }
}
