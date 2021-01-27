import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:io';
import 'dart:async';
import 'package:image_gallery/image_gallery.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';


List langTextSettings = ['ENGLISH','TÜRKÇE'];
List lanCalculator = ['CALCULATOR','HESAP MAKİNESİ'];
List lanGallery = ['GALLERY','GALERİ'];
List lanHES = ['HES CODES','HES KODLARI'];
List lanSettings = ['SETTINGS','AYARLAR'];
List lanLanguage = ['LANGUAGE','DİL'];
List lanColor = ['COLOR', 'RENK'];
List lanCalcClear = ['CLEAR', 'TEMİZLE'];
List barColorsEN = ['BLUE', 'RED', 'ORANGE', 'PINK', 'GREEN', 'PURPLE'];
List barColorsTR = ['MAVİ', 'KIRMIZI', 'TURUNCU', 'PEMBE', 'YEŞİL', 'MOR'];
List lanHESTextField = ['Please enter a HES code:', 'Lütfen bir HES kodu giriniz:'];
List lanHESTextFieldButton =['SAVE', 'KAYDET'];
List lanToDo = ['TODO LIST','YAPILACAKLAR LİSTESİ'];
List lanToDoTitle = ['Title:','Başlık:'];
List lanToDoDesc = ['Description:','Açıklama:'];
int language = 0; // 0 = English, 1 = Türkçe
int color = 5; // Default color = Purple's index

void main() {
  runApp(MyApp());
}

Color setColor(int x){
  if(x == 0){ // Blue
    return Colors.blueAccent; }
  if(x == 1){ // Red
    return Colors.redAccent; }
  if(x == 2){ // Orange
    return Colors.orange; }
  if(x == 3){ // Pink
    return Colors.pinkAccent; }
  if(x == 4){ // Green
    return Colors.green; }
  if(x == 5){ // Purple
    return Colors.deepPurple;
  }
  else return Colors.deepPurple;
}

bool visibleColorTR(){
  if (language==0){
    return false;
  }
  else return true;
}
bool visibleColorEN(){
  if (language==1){
    return false;
  }
  else return true;
}

// MAIN PAGE
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY TOOLBOX',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'MY TOOLBOX'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: setColor(color),
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Row(children: [
                Expanded(
                  child: RaisedButton(
                    color: setColor(color),
                    padding: EdgeInsets.all(20),
                    child: Text(lanCalculator[language], style: TextStyle(fontSize: 25, color: Colors.white)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyCalculatorPage()),);
                    },
                  )
                )]
              ),
              SizedBox(height: 75),
              Row(children: [
                Expanded(
                    child: RaisedButton(
                      color: setColor(color),
                      padding: EdgeInsets.all(20),
                      child: Text(lanGallery[language], style: TextStyle(fontSize: 25, color: Colors.white)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyGalleryPage()),);
                      },
                    )
                )]
              ),
              SizedBox(height: 75),
              Row(children: [
                Expanded(
                    child: RaisedButton(
                      color: setColor(color),
                      padding: EdgeInsets.all(20),
                      child: Text(lanHES[language], style: TextStyle(fontSize: 25, color: Colors.white)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHESCodesPage()),);
                      },
                    )
                )]
              ),
              SizedBox(height: 75),
              Row(children: [
                Expanded(
                    child: RaisedButton(
                      color: setColor(color),
                      padding: EdgeInsets.all(20),
                      child: Text(lanToDo[language], style: TextStyle(fontSize: 25, color: Colors.white)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyToDoPage()),);
                      },
                    )
                )]
              ),
            ]
          ),
        drawer: Drawer(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(children: [
                  Expanded(
                      child: Text(lanLanguage[language],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ))
                  )]
                ),
                Column(children: [
                  Center(
                      child: DropdownButton<String>(
                        value: langTextSettings[language],
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 25),
                        underline: Container(
                          height: 2,
                          color: setColor(color),
                        ),
                        onChanged: (String s) {
                          setState(() {
                            if(s=='ENGLISH'){
                              language = 0;
                            }
                            if(s=='TÜRKÇE'){
                              language = 1;
                            }
                          });
                        },
                        items: <String>['ENGLISH', 'TÜRKÇE']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                  )]
                ),
                SizedBox(height: 100),
                Row(children: [
                  Expanded(
                      child: Text(lanColor[language],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ))
                  )]
                ),
                Column(children: [
                  Visibility(
                      visible: visibleColorEN(),
                      child: Center(
                          child: DropdownButton<String>(
                            value: barColorsEN[color],
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black, fontSize: 25),
                            underline: Container(
                              height: 2,
                              color: setColor(color),
                            ),
                            onChanged: (String s) {
                              setState(() {
                                if(s=='BLUE'){
                                  color=0;
                                }
                                if(s=='RED'){
                                  color=1;
                                }
                                if(s=='ORANGE'){
                                  color=2;
                                }
                                if(s=='PINK'){
                                  color=3;
                                }
                                if(s=='GREEN'){
                                  color=4;
                                }
                                if(s=='PURPLE'){
                                  color=5;
                                }
                              });
                            },
                            items: <String>['BLUE', 'RED', 'ORANGE', 'PINK', 'GREEN', 'PURPLE']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                      )
                  ),
                  Visibility(
                      visible: visibleColorTR(),
                      child: Center(
                          child: DropdownButton<String>(
                            value: barColorsTR[color],
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black, fontSize: 25),
                            underline: Container(
                              height: 2,
                              color: setColor(color),
                            ),
                            onChanged: (String s) {
                              setState(() {
                                if(s=='MAVİ'){
                                  color=0;
                                }
                                if(s=='KIRMIZI'){
                                  color=1;
                                }
                                if(s=='TURUNCU'){
                                  color=2;
                                }
                                if(s=='PEMBE'){
                                  color=3;
                                }
                                if(s=='YEŞİL'){
                                  color=4;
                                }
                                if(s=='MOR'){
                                  color=5;
                                }
                              });
                            },
                            items: <String>['MAVİ', 'KIRMIZI', 'TURUNCU', 'PEMBE', 'YEŞİL', 'MOR']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                      )
                  )
                ]),
              ]
          ),
        ),
    );
  }
}

// CALCULATOR

class MyCalculatorPage extends StatefulWidget {
  MyCalculatorPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyCalculatorPageState createState() => _MyCalculatorPageState();
}

class _MyCalculatorPageState extends State<MyCalculatorPage> {
  double num1 = 0.0, num2 = 0.0;
  String sValue = "0", _sValue = "0", sOperand;

  void buttonPressed(String button){
    double temp;
    if(button=="C"){
      sOperand = null;
      _sValue = "0";
      num1 = 0.0;
      num2 = 0.0;
    } else if(button=="+" || button=="-" || button=="/" || button=="*"){
        num1 = double.parse(sValue);
        sOperand = button;
        _sValue = "0";
    } else if(button=="."){
        if(_sValue.contains(".")){
          return;
        } else{
          _sValue = _sValue + button;
        }
    } else if(button=="="){
        num2 = double.parse(sValue);
        if (sOperand=="+"){
          temp = num1 + num2;
          _sValue = temp.toString();
        }
        if (sOperand=="-"){
          temp = num1 - num2;
          _sValue = temp.toString();
        }
        if (sOperand=="*"){
          temp = num1 * num2;
          _sValue = temp.toString();
        }
        if (sOperand=="/"){
          temp = num1 / num2;
          _sValue = temp.toString();
        }
        sOperand = null;
        num1 = 0.0;
        num2 = 0.0;
    } else{
      _sValue = _sValue + button;
    }
    setState(() {
      sValue = double.parse(_sValue).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: setColor(color),
        title: Text(lanCalculator[language]),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(10),
            child: Text(sValue,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.black,
                ))
          ),
          Expanded(child: Divider()),
          Column(children: [
            Row(
              children: [
                Expanded(child:
                MaterialButton(
                    child: Text("7", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white54,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("7")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("8", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white54,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("8")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("9", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white54,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("9")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("/", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white24,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("/")
                )
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child:
                MaterialButton(
                    child: Text("4", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white54,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("4")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("5", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white54,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("5")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("6", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white54,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("6")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("X", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white24,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("*")
                )
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child:
                MaterialButton(
                    child: Text("1", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white54,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("1")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("2", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white54,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("2")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("3", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white54,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("3")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("-", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white24,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("-")
                )
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child:
                MaterialButton(
                    child: Text(".", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white54,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed(".")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("0", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white54,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("0")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("=", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white24,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("=")
                )
                ),
                Expanded(child:
                MaterialButton(
                    child: Text("+", style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white24,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("+")
                )
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child:
                MaterialButton(
                    child: Text(lanCalcClear[language], style: TextStyle(fontSize: 30, color: Colors.black)),
                    color: Colors.white24,
                    padding: EdgeInsets.all(25),
                    onPressed: () => buttonPressed("C")
                )
                ),
              ],
            )
          ],)
        ],
        )
      )
    );
  }
}

// GALLERY

class MyGalleryPage extends StatefulWidget {
  @override
  _MyGalleryPageState createState() => _MyGalleryPageState();
}

class _MyGalleryPageState extends State<MyGalleryPage> {
  Map<dynamic, dynamic> allImageInfo = new HashMap();
  List images=new  List();

  @override
  void initState() {
    super.initState();
    getImages();
  }

  Future<void> getImages() async {
    Map<dynamic, dynamic>  imagesMap;
    imagesMap = await FlutterGallaryPlugin.getAllImages;
    setState(() {
      this.images = imagesMap['URIList'] as List;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: setColor(color),
        title: Text(lanGallery[language]),
      ),
      body: GridView.extent(
          maxCrossAxisExtent: 150.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: _buildGridTileList(images.length)
      )
    );
  }

  List<Container> _buildGridTileList(int count)  {
    return List<Container>.generate(
        count, (int index) =>
            Container(child: new Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.file(File(images[index].toString()),
                  width: 125.0,
                  height: 125.0,
                  fit: BoxFit.contain,)
              ],)
            )
    );
  }
}

// HES CODE

class HESCode {  // xxxx - xxxx - xx
  int _id;
  String _firstFourChar;
  String _secondFourChar;
  String _lastTwoChar;

  HESCode(this._id, this._firstFourChar, this._secondFourChar, this._lastTwoChar);

  int get id => _id;
  String get firstFourChar => _firstFourChar;
  String get secondFourChar => _secondFourChar;
  String get lastTwoChar => _lastTwoChar;

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'firstFourChar': _firstFourChar,
      'secondFourChar': _secondFourChar,
      'lastTwoChar': _lastTwoChar,
    };
  }

  String hesToString() {
    String temp;
    temp = _firstFourChar + ' - ' + _secondFourChar + ' - ' + _lastTwoChar;
    return temp;
  }

  HESCode.fromObject(dynamic o){
    this._id = o["id"];
    this._firstFourChar = o["firstFourChar"];
    this._secondFourChar = o["secondFourChar"];
    this._lastTwoChar = o["lastTwoChar"];
  }
}

class HESdb {
  static final HESdb _hesDB = HESdb._internal();
  String hestable = "hescodes";
  String colId = "id";
  String colFirstFourChar = "firstFourChar";
  String colSecondFourChar = "secondFourChar";
  String colLastTwoChar = "lastTwoChar";

  HESdb._internal();

  factory HESdb() {
    return _hesDB;
  }

  static Database _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "hescodes.db";
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $hestable($colId INTEGER PRIMARY KEY, $colFirstFourChar TEXT, $colSecondFourChar TEXT, $colLastTwoChar TEXT)");
  }

  Future<int> insertHES(HESCode hcode) async {
    Database db = await this.db;
    var result = await db.insert(hestable, hcode.toMap());
    return result;
  }

  Future<List> getHES() async {
    List<HESCode> hesList = List<HESCode>();
    Database db = await this.db;
    var result =
    await db.rawQuery("SELECT * FROM $hestable");
    result.forEach((element) {
      hesList.add(HESCode.fromObject(element));
    });
    return hesList;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $hestable"));
    return result;
  }

  Future<int> deleteHES(int id) async {
    Database db = await this.db;
    var result = await db.delete(hestable,  where: "$colId = ?", whereArgs: [id]);
    return result;
  }
}

class MyHESCodesPage extends StatefulWidget {
  MyHESCodesPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHESCodesPageState createState() => _MyHESCodesPageState();
}

class _MyHESCodesPageState extends State<MyHESCodesPage> {
  HESdb hdb = HESdb();
  List<HESCode> hcodes;
  int count = 0;
  bool delete = false;

  void initState() {
    if (hcodes == null) {
      hcodes = List<HESCode>();
      getData();
    }
    super.initState();
  }

  void getData() {
    final hesFuture = hdb.getHES();
    hesFuture.then((result) => {
      setState(() {
        hcodes = result;
        count = hcodes.length;
      })
    });
  }

  void hesDelete(HESCode h){
    if(delete == true) {
      int temp = h._id;
      hdb.deleteHES(temp);
      delete = false;
      setState(() { getData(); });
    }
    else return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: setColor(color),
        title: Text(lanHES[language]),
      ),
      body:hesListItems(),
      floatingActionButton:
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyNewHESCodesPage()), ).then((value) => setState(() { getData(); }));
                },
              tooltip: 'Increment',
              backgroundColor: setColor(color),
              heroTag: null,
              child: Icon(Icons.add),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: (){
                delete = true;
              },
              tooltip: 'Delete',
              backgroundColor: setColor(color),
              heroTag: null,
              child: Icon(Icons.delete),
            ),
          ])
    );
  }

  ListView hesListItems() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) => Card(
        color: Colors.white,
        elevation: 2.0,
        child: ListTile(
          title: Text(this.hcodes[position].hesToString(), style: TextStyle(fontSize: 20, color: Colors.black),),
          onTap: () {
            if(delete == true){
              hesDelete(this.hcodes[position]);
              setState(() {
                delete = false;
                getData();
              });
            }
          },
        )));
  }
}

// ADDING A NEW HES CODE

class MyNewHESCodesPage extends StatefulWidget {
  MyNewHESCodesPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyNewHESCodesPageState createState() => _MyNewHESCodesPageState();
}

class _MyNewHESCodesPageState extends State<MyNewHESCodesPage> {
  final myController = TextEditingController();
  HESdb hdb = HESdb();
  List<HESCode> hcodes;
  int count = 0;
  int lastid = 0;

  void getData() {
    final hesFuture = hdb.getHES();
    hesFuture.then((result) => {
      setState(() {
        hcodes = result;
        count = hcodes.length;
        for(int i = 0; i < count; i++){
          if(hcodes[i]._id >= lastid){
            lastid = hcodes[i]._id;
          }
        }
      })
    });
  }

  void addNewHES(int id, String s){
    String temp1,temp2,temp3;
    temp1 = s.substring(0,4);
    temp2 = s.substring(4,8);
    temp3 = s.substring(8,10);
    HESCode newHES = new HESCode(id+1, temp1, temp2, temp3);
    hdb.insertHES(newHES);
  }

  @override
  Widget build(BuildContext context) {
    if (hcodes == null) {
      hcodes = List<HESCode>();
      getData();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: setColor(color),
        title: Text(lanHES[language]),
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              Text(lanHESTextField[language],
                style: TextStyle(fontSize: 30, color: Colors.black),
              textAlign: TextAlign.center,),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(fontSize: 30, color: Colors.black),
                decoration: const InputDecoration(
                ),
                controller: myController,
                validator: (value) {
                  if (value.isEmpty) {
                    if (language == 0) {
                      return 'Please enter a code!';
                    } else {
                      return 'Lütfen bir kod giriniz!';
                    }
                  }
                  return null;
                  },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: setColor(color),
                child: Text(lanHESTextFieldButton[language], style: TextStyle(fontSize: 20, color: Colors.white)),
                onPressed: (){
                  addNewHES(lastid, myController.text);
                  Navigator.pop(context);
                  },
              )
            ],
        )
      )
    );
  }
}

// TO DO LIST

class MyToDo {
  int _id;
  String _title;
  String _desc;

  MyToDo(this._id, this._title, this._desc);

  int get id => _id;
  String get title => _title;
  String get desc => _desc;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': _title,
      'desc': _desc
    };
  }

  MyToDo.fromObject(dynamic o){
    this._id = o["id"];
    this._title = o["title"];
    this._desc = o["desc"];
  }
}

class ToDodb {
  static final ToDodb _todoDB = ToDodb._internal();
  String todotable = "mytodo";
  String colId = "id";
  String colTitle = "title";
  String colDesc = "desc";

  ToDodb._internal();

  factory ToDodb() {
    return _todoDB;
  }

  static Database _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "mytodo.db";
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $todotable($colId INTEGER PRIMARY KEY, $colTitle TEXT, $colDesc TEXT)");
  }

  Future<int> insertToDo(MyToDo td) async {
    Database db = await this.db;
    var result = await db.insert(todotable, td.toMap());
    return result;
  }

  Future<List> getToDo() async {
    List<MyToDo> myTodoList = List<MyToDo>();
    Database db = await this.db;
    var result =
    await db.rawQuery("SELECT * FROM $todotable");
    result.forEach((element) {
      myTodoList.add(MyToDo.fromObject(element));
    });
    return myTodoList;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $todotable"));
    return result;
  }

  Future<int> deleteToDo(int id) async {
    Database db = await this.db;
    var result = await db.delete(todotable,  where: "$colId = ?", whereArgs: [id]);
    return result;
  }
}

class MyToDoPage extends StatefulWidget {
  MyToDoPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyToDoPageState createState() => _MyToDoPageState();
}

class _MyToDoPageState extends State<MyToDoPage> {
  ToDodb tdb = ToDodb();
  List<MyToDo> tdlist;
  int count = 0;
  bool delete = false;

  void initState() {
    if (tdlist == null) {
      tdlist = List<MyToDo>();
      getData();
    }
    super.initState();
  }

  void getData() {
    final todoFuture = tdb.getToDo();
    todoFuture.then((result) => {
      setState(() {
        tdlist = result;
        count = tdlist.length;
      })
    });
  }

  void todoDelete(MyToDo t){
    if(delete == true) {
      int temp = t._id;
      tdb.deleteToDo(temp);
      delete = false;
      setState(() { getData(); });
    }
    else return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: setColor(color),
          title: Text(lanToDo[language]),
        ),
        body:todoListItems(),
        floatingActionButton:
        Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyNewToDoPage()), ).then((value) => setState(() { getData(); }));
                },
                tooltip: 'Increment',
                backgroundColor: setColor(color),
                heroTag: null,
                child: Icon(Icons.add),
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                onPressed: (){
                  delete = true;
                },
                tooltip: 'Delete',
                backgroundColor: setColor(color),
                heroTag: null,
                child: Icon(Icons.delete),
              ),
            ])
    );
  }

  ListView todoListItems() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) => Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(this.tdlist[position]._title.toString(), style: TextStyle(fontSize: 20, color: Colors.black),),
              subtitle: Text(this.tdlist[position]._desc.toString(), style: TextStyle(fontSize: 17, color: Colors.black45),),
              onTap: () {
                if(delete == true){
                  todoDelete(this.tdlist[position]);
                  setState(() {
                    delete = false;
                    getData();
                  });
                }
              },
            )));
  }
}

// ADDING A NEW TO DO

class MyNewToDoPage extends StatefulWidget {
  MyNewToDoPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyNewToDoPageState createState() => _MyNewToDoPageState();
}

class _MyNewToDoPageState extends State<MyNewToDoPage> {
  final myControllerTitle = TextEditingController();
  final myControllerDesc = TextEditingController();
  ToDodb tdb = ToDodb();
  List<MyToDo> tdlist;
  int count = 0;
  int lastid = 0;

  void getData() {
    final todoFuture = tdb.getToDo();
    todoFuture.then((result) => {
      setState(() {
        tdlist = result;
        count = tdlist.length;
        for(int i = 0; i < count; i++){
          if(tdlist[i]._id >= lastid){
            lastid = tdlist[i]._id;
          }
        }
      })
    });
  }

  void addNewToDo(int id, String stitle, String sdesc){
    MyToDo newTodo = new MyToDo(id+1, stitle, sdesc);
    tdb.insertToDo(newTodo);
  }

  @override
  Widget build(BuildContext context) {
    if (tdlist == null) {
      tdlist = List<MyToDo>();
      getData();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: setColor(color),
          title: Text(lanToDo[language]),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(lanToDoTitle[language],
                  style: TextStyle(fontSize: 30, color: Colors.black),
                  textAlign: TextAlign.center,),
                SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(fontSize: 30, color: Colors.black),
                  decoration: const InputDecoration(
                  ),
                  controller: myControllerTitle,
                  validator: (value) {
                    if (value.isEmpty) {
                      if (language == 0) {
                        return 'Please enter a title!';
                      } else {
                        return 'Lütfen bir başlık giriniz!';
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(lanToDoDesc[language],
                  style: TextStyle(fontSize: 30, color: Colors.black),
                  textAlign: TextAlign.center,),
                SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(fontSize: 30, color: Colors.black),
                  decoration: const InputDecoration(
                  ),
                  controller: myControllerDesc,
                  validator: (value) {
                    if (value.isEmpty) {
                      if (language == 0) {
                        return 'Please enter the description!';
                      } else {
                        return 'Lütfen bir açıklama giriniz!';
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: setColor(color),
                  child: Text(lanHESTextFieldButton[language], style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: (){
                    addNewToDo(lastid, myControllerTitle.text, myControllerDesc.text);
                    Navigator.pop(context);
                  },
                )
              ],
            )
        )
    );
  }
}