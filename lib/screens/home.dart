import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image(
                  image: AssetImage('assets/money-bag.png'),
                  fit: BoxFit.fitHeight,
                ),
              )),
          SliverFillRemaining(
              child: Material(
            child: ListTile(
              title: Text("Some Item"),
              subtitle: Text("Some subtitle"),
              trailing: Icon(Icons.list),
              leading: Icon(Icons.add_box),
            ),
          ))
        ],
      ),
    );
  }
}
