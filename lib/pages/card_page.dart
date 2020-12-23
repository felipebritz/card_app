import 'package:card_app/models/card.dart';
import 'package:card_app/services/card_services.dart';
import 'package:card_app/theme/growdev_colors.dart';
import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  var _controllerTitle = TextEditingController();
  var _controllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CardGrowdev card = ModalRoute.of(context).settings.arguments;

    _controllerTitle.text = card.title;
    _controllerContent.text = card.content;

    return Scaffold(
      appBar: AppBar(
        title: Text(card.id == null ? 'Card: Novo' : 'Card ${card.id}: Editar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _controllerTitle,
                      decoration: InputDecoration(
                        hintText: 'Título',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _controllerContent,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: 'Conteúdo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: laranjaGrowdev,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Text(
                  'Salvar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                onPressed: () {
                  card.title = _controllerTitle.text;
                  card.content = _controllerContent.text;
                  var cardService = CardService();
                  if (card.id == null) {
                    cardService.createCard(card).then(
                      (value) {
                        if (value > 0) {
                          card.id = value;
                          Navigator.pop(context, card);
                        }
                      },
                    );
                  } else {
                    cardService.updateCard(card).then(
                      (value) {
                        if (value) {
                          Navigator.pop(context);
                        }
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
