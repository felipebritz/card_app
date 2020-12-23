import 'package:card_app/controllers/credential.dart';
import 'package:card_app/models/card.dart';
import 'package:card_app/services/card_services.dart';
import 'package:card_app/theme/growdev_colors.dart';
import 'package:card_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var cardService = CardService();
  List<CardGrowdev> listCard = <CardGrowdev>[];

  @override
  void initState() {
    super.initState();
    cardService.getAllCards().then((value) {
      setState(() {
        listCard = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.cardPage,
                arguments: CardGrowdev(),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    listCard.add(value);
                  });
                }
              });
            },
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
              accountName: Text(userCredential.name),
              accountEmail: Text(userCredential.email),
            ),
            ListTile(
              title: Text('Sair'),
              onTap: () {
                userCredential = null;
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginPage,
                  (Route<dynamic> route) => false,
                );
              },
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
                          card.title == null ? '' : card.title,
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
                      card.content == null ? '' : card.content,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                      maxLines: 7,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        onPressed: () {
                          _showMyDialog().then(
                            (value) {
                              if (value) {
                                cardService.deleteCard(card).then((value) {
                                  if (value) {
                                    setState(() {
                                      listCard.removeAt(index);
                                    });
                                  }
                                });
                              }
                            },
                          );
                        },
                        child: Text('Excluir'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.cardPage,
                            arguments: card,
                          ).then((_) {
                            setState(() {});
                          });
                        },
                        child: Text('Editar'),
                      ),
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

  Future<bool> _showMyDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Card'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Exclusão de card!'),
                Text('Você deseja excluir o card?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
