import 'package:card_app/models/card.dart';
import 'package:card_app/theme/growdev_colors.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<CardGrowdev> listCard = <CardGrowdev>[
    CardGrowdev(id: 1, title: 'teste', content: 'content teste'),
    CardGrowdev(id: 2, title: 'teste2', content: 'content teste2'),
    CardGrowdev(id: 3, title: 'teste3', content: 'content teste3'),
    CardGrowdev(id: 4, title: 'teste4', content: 'content teste4')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                  color: azulGrowdev.shade900,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: laranjaGrowdev,
                  size: 40,
                ),
              ),
              accountName: Text('Felipe'),
              accountEmail: Text('teste@gmail.com'),
            ),
            ListTile(
              title: Text('Sair'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: listCard.length,
        itemBuilder: (context, index) {
          var card = listCard[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(
                color: laranjaGrowdev,
                width: 3,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: laranjaGrowdev,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            card.id.toString(),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          card.title,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                    indent: 5,
                    endIndent: 5,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    height: 120,
                    child: Text(
                      card.content,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                      maxLines: 7,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(onPressed: () {}, child: Text('Excluir')),
                      FlatButton(onPressed: () {}, child: Text('Editar')),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
