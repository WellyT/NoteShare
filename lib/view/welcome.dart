import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noteshare/view/notation_list.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:noteshare/routes/routes.dart';

class WelcomeScreen extends StatelessWidget {
  final PageController _controller = PageController();
  // Passado para um StreamBuilder que já fecha e libera recursos
  // do subscription ao stream (StremBuilder possui um StreamBuilderState)
  //ignore: close_sinks
  final StreamController<int> currentPage = StreamController.broadcast();
  WelcomeScreen({Key key}) : super(key: key);

  void skipToHomePage(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.HOME,
    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>NotationList()),(Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      PageIndicatorContainer(
        length: 4,
        indicatorColor: Colors.grey,
        indicatorSelectorColor: Colors.blue,
        padding: const EdgeInsets.only(bottom: 60, top: 40),
        child: PageView(
          controller: _controller,
          onPageChanged: currentPage.add,
          children: <Widget>[
            createWelcomeRescarContainer(),
            createWelcomeInfoContainer(),
            createWelcomeShareContainer(),
            createWelcomeProntoContainer(context)
          ],
        ),
      ),
      StreamBuilder<int>(
          initialData: 0,
          stream: currentPage.stream,
          builder: (context, snapshot) => snapshot.data < 3
              ? Positioned(
                  right: 25,
                  top: 70,
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        skipToHomePage(context);
                      },
                      child: const Text(
                        'PULAR',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink())
    ]);
  }

  Widget createWelcomeRescarContainer() {
    return templateWelcomePageView(
        Image.asset(
          'assets/img/slide-noteshare.png',
          height: 200,
        ),
        Text(
          'Bem vindo ao NoteShare',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14),
                children: const [
              TextSpan(text: 'O '),
              TextSpan(
                text: 'NoteShare ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text:
                      'é um aplicativo que foi criado para que você possa compartilhar suas anotações')
            ])));
  }

  Widget createWelcomeInfoContainer() => templateWelcomePageView(
        Image.asset(
          'assets/img/slide-info.png',
          height: 200,
        ),
        const Text(
          'O que posso fazer?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14),
                children: const [
                  TextSpan(text: 'Com o '),
                  TextSpan(
                    text: 'NoteShare ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          'é possível criar notas, editar e excluí-las com facilidade e rapidez. ')
                ])),
      );

  Widget createWelcomeShareContainer() => templateWelcomePageView(
        Image.asset(
          'assets/img/slide-share.png',
          height: 200,
        ),
        const Text(
          'Compartilhe!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14),
                children: const [
                  TextSpan(text: 'Suas idéias podem ser '),
                  TextSpan(
                    text: 'Compartilhadas ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'na sua rede social favorita!',
                  )
                ])),
      );

  Widget createWelcomeProntoContainer(BuildContext context) =>
      templateWelcomePageView(
          Image.asset(
            'assets/img/slide-go.png',
            height: 200,
          ),
          const Text(
            'Comece agora!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          FlatButton(
            onPressed: () {
              skipToHomePage(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'CONTINUAR',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.blue,
                ),
              ],
            ),
          ));

  Widget templateWelcomePageView(Image image, Widget title, Widget content) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(left: 25, bottom: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomCenter,
                  child: image),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    title,
                    Container(
                      height: 10,
                    ),
                    content
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
