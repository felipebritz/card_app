import 'package:card_app/controllers/credential.dart';
import 'package:card_app/models/user.dart';
import 'package:card_app/services/card_services.dart';
import 'package:card_app/theme/growdev_colors.dart';
import 'package:card_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _checked = true;
  bool _obscureText = true;
  var _user = User();
  var _controllerEmail = TextEditingController(text: 'growdev@growdev.com');
  var _controllerPassword = TextEditingController(text: 'growdev@2020');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(azulGrowdev.value),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
            color: azulGrowdev.shade400,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/growdev_branco.png',
                    height: 100,
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Novo por aqui?',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.signUpPage);
                        },
                        child: Text(
                          'Crie a sua contra aqui',
                          style: TextStyle(
                            color: laranjaGrowdev,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: _controllerEmail,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: azulGrowdev.shade900,
                      hintText: 'E-mail',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      suffixIcon: Icon(Icons.email),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _controllerPassword,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: azulGrowdev.shade900,
                      hintText: 'Senha',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        child: _obscureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _checked,
                        activeColor: azulGrowdev.shade900,
                        onChanged: (value) {
                          setState(() {
                            _checked = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Mantenha-me conectado',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Builder(
                    builder: (BuildContext ctx) {
                      return Container(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          color: laranjaGrowdev,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          onPressed: () {
                            _user.email = _controllerEmail.text;
                            _user.password = _controllerPassword.text;
                            var serv = CardService();
                            serv.login(_user).then((value) {
                              if (value) {
                                userCredential = _user;
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  AppRoutes.listPage,
                                  (Route<dynamic> route) => false,
                                );
                              } else {
                                Scaffold.of(ctx).showSnackBar(
                                  SnackBar(
                                    content: Text('Dados inválidos.'),
                                  ),
                                );
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/* Requisitos mínimos (Telas)
Tela de login
Tela inicial com a lista dos cards criado
Tela de cadastro/edição dos cards
Drawer com o menu sair
Requisitos mínimos (Funcionalidades)
Deve ser possível fazer login
Deve carregar a lista dos cards
Deve ser possível salvar um card
Deve ser possível editar um card
Deve ser possível remover um card
No Drawer precisa mostrar o nome e o e-mail do usuário
Usuário deve permanecer logado até ele clicar no menu Sair do drawer
 */
