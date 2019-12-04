import 'package:flutter/material.dart';

void main() => runApp(MyApp());
bool interupteur =false;
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Sama Calorie'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //bool interupteur = false;
  int itemSelected;
  int calorieBase;
  int calorieAvecActivite;
  double sliderTaille = 0.0;
  double poids;
  double age;
  Map mapActivite = {
    0: "Faible",
    1: "Modere",
    2: "Fort"
  };
  List<Widget> radios() {
    List<Widget> r = [];
    for(int x = 0; x < 3; x++) {
      Row row = new Row(
        children: <Widget>[
          Text('Choix numéro ${x+1}'),
          Radio(
              value: x,
              groupValue: itemSelected,
              onChanged: (int i) {
                setState(() {
                  itemSelected = i;
                });
              }
          )
        ],
      );
      r.add(row);
    }
    return r;
  }
  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    return new GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(new FocusNode())),
      child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: (interupteur)?Colors.blue:Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: Text(
                'Remplissez tous les champs pour obtenir votre besoin journalier en calories.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,

                textScaleFactor: 1.1,
              ),
              ),
            Card(
              margin: EdgeInsets.all(20.0),
              elevation: 15.0,
              child: Container(
                width: largeur / 1,
                height: 440.0,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Femme',style: TextStyle(color: Colors.pink),),
                          Switch(
                              activeColor: (interupteur)?Colors.blue:Colors.pink,
                              inactiveTrackColor: Colors.pink,
                              value: interupteur,
                              onChanged: (bool b) {
                                setState(() {
                                  //initState();
                                  interupteur = b;
                                });
                              }
                          ),
                          Text('Homme',style: TextStyle(color: Colors.blue),)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                          color: (interupteur)?Colors.blue:Colors.pink,
                          elevation: 10.0,
                        child: Text(
                          (age == null)?'Appuyer pour entrer votre age':'Votre age est de : ${age.toInt()} ans',
                            style: TextStyle(
                              color: Colors.white
                            ),
                        ),
                          onPressed: chooseAge
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Text(
                          'Votre taille est de: ${sliderTaille.toInt()} cm',
                        style: TextStyle(
                            color: (interupteur)?Colors.blue:Colors.pink,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Slider(
                        activeColor: (interupteur)?Colors.blue:Colors.pink,
                          inactiveColor: Colors.grey,
                          value: sliderTaille,
                          min: 0.0,
                          max: 200.0,
                          onChanged: (double t) {
                            setState(() {
                              sliderTaille = t;
                            });
                          }
                      ),
                    ),
                    Container(
                      child: TextField(
                       keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                            labelText: 'Entrer votre poids en kilos'
                        ),
                        onChanged: (String p) {
                         setState(() {
                           poids = double.tryParse(p);
                         });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Text(
                        'Quelle est votre activité sportive',
                        style: TextStyle(
                            color: (interupteur)?Colors.blue:Colors.pink,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: rowRadio()/*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Radio(value: null, groupValue: null, onChanged: null),
                              Text(
                                'Faible',
                                style: TextStyle(
                                    color: (interupteur)?Colors.blue:Colors.pink,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Radio(value: null, groupValue: null, onChanged: null),
                              Text(
                                'Modere',
                                style: TextStyle(
                                    color: (interupteur)?Colors.blue:Colors.pink,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Radio(value: null, groupValue: null, onChanged: null),
                              Text(
                                'Forte',
                                style: TextStyle(
                                    color: (interupteur)?Colors.blue:Colors.pink,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),*/
                    )
                  ],
                ),
              )
            ),
             RaisedButton(
              onPressed: calculerNbrCalories,
              child: Text('Calculer'),
              color: (interupteur)?Colors.blue:Colors.pink,
              textColor: Colors.white,
              //autofocus: true,
              elevation: 10.0,
            ),
          ],
        ),
      ),
    )
    );
  }
  Future<Null> chooseAge() async {
    DateTime choix = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1500),
        lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year
    );
    if (choix != null) {
      var difference = DateTime.now().difference(choix); // Ceci permet d'avoir la difference entre l'année en cours et celle choisie
      var jours = difference.inDays;
      var ans = (jours / 365);
      setState(() {
        age = ans;
      });
    }
  }

  Row rowRadio() {
    List<Widget> l = [];
    mapActivite.forEach((key, value) {
      Column c = new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
              value: key,
              groupValue: itemSelected,
              activeColor: (interupteur)?Colors.blue:Colors.pink,
              onChanged: (Object i) {
                setState(() {
                  itemSelected = i;
                });
              }),
          Text(
          '$value',
          style: TextStyle(
          color: (interupteur)?Colors.blue:Colors.pink,
          ),
          )
        ],
      );
      l.add(c);
    });
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: l,
    );
  }

  void calculerNbrCalories() {
    if (age != null && poids != null && itemSelected != null) {
      if (interupteur) {
        calorieBase = (66.4730 + (13.7516 * poids) + (5.0033 * sliderTaille) - (6.7550 * age)).toInt();
      } else {
        calorieAvecActivite = (655.0955 + (9.5634 * poids) + (1.8496 * sliderTaille) - (4.6756 * age)).toInt();
      }
      switch(itemSelected) {
        case 0:
          calorieAvecActivite = (calorieBase * 1.2).toInt();
          break;
        case 1:
          calorieAvecActivite = (calorieBase * 1.2).toInt();
          break;
        case 2:
          calorieAvecActivite = (calorieBase * 1.2).toInt();
          break;
        default:
          calorieAvecActivite = calorieBase;
          break;
      }
      setState(() {
        dialogue();
      });
    } else {
      alerte();
    }
  }

  Future<Null> dialogue() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return new SimpleDialog(
            title: Text('Votre besoin en calorie',style: TextStyle(color: (interupteur)?Colors.blue:Colors.pink),),
            contentPadding: EdgeInsets.all(15.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child:
                Text('Votre besoin de base est de: $calorieBase'),
                //(interupteur)?Colors.blue:Colors.pink
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child:
                Text('Votre besoin avec activité sportive est de: $calorieAvecActivite'),
                //(interupteur)?Colors.blue:Colors.pink
              ),
              RaisedButton(onPressed: () {
                Navigator.pop(buildContext);
              },
                color: (interupteur)?Colors.blue:Colors.pink,
                child: Text('OK',style: TextStyle(color: Colors.white),),
              )
            ],
          );
        }
    );
  }

  Future<Null> alerte() async {
    return showDialog(
        context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
          return new AlertDialog(
            title: Text('Erreur'),
            content: Text('Tous les champs ne sont pas remplis'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(buildContext);
                  },
                  child: Text('OK', style: TextStyle(color: Colors.red),)
              )
            ],
          );
      }
    );
  }
}
