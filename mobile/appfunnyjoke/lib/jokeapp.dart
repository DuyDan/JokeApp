
import 'package:appfunnyjoke/story.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';


class JokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Cards Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Swipe Cards Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<String> _names = <String>[
    'A child asked his father, "How were people born?" So his father said, "Adam and Eve made babies, then their babies became adults and made babies, and so on. /n "The child then went to his mother, asked her the same question and she told him, "We were monkeys then we evolved to become like we are now."The child ran back to his father and said, "You lied to me!" His father replied, "No, your mom was talking about her side of the family."',
    'Teacher: "Kids,what does the chicken give you?" Student: "Meat!" Teacher: "Very good! Now what does the pig give you?" Student: "Bacon!" Teacher: "Great! And what does the fat cow give you?" Student: "Homework!"',
    'The teacher asked Jimmy, "Why is your cat at school today Jimmy?" Jimmy replied crying, "Because I heard my daddy tell my mommy, "I am going to eat that pussy once Jimmy leaves for school today!"',
    'A housewife, an accountant and a lawyer were asked "How much is 2+2?" The housewife replies: "Four!". The accountant says: "I think its either 3 or 4. Let me run those figures through my spreadsheet one more time." The lawyer pulls the drapes, dims the lights and asks in a hushed voice, "How much do you want it to be?"',
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Story(text: _names[i],),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },

          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: const FlutterLogo(
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text(
                          'Handicrafted by',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'JimHLS',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage:  AssetImage('images/avatar.jpg'),
                  ),
                ],
              ),
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView (
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent[400],
                              border: Border.all(color: Colors.blueAccent)),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "A joke a day keeps the doctor away\n",
                                    style: TextStyle(color: Colors.white,height: 3 ,fontSize: 20),

                                  ),
                                  TextSpan(
                                    text: "If you joke wrong way, your teeth have to pay. (Serious) \n",
                                    style: TextStyle(color: Colors.white,height:2 , fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ),
                    ),

                  ],
                ),
                Container(
                  height: 300,
                  width: 350,
                    child: Stack(children: [
                      Container(
                        height: MediaQuery.of(context).size.height - kToolbarHeight,
                        child: SwipeCards(
                          matchEngine: _matchEngine!,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              alignment: Alignment.topCenter,
                              color: Colors.grey[50],
                              child: Text(
                                _swipeItems[index].content.text,
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                          },
                          onStackFinished: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("That's all the jokes for today! Come back another day!"),
                              duration: Duration(milliseconds: 500),
                            ));
                          },
                          itemChanged: (SwipeItem item, int index) {
                            print("item: ${item.content.text}, index: $index");
                          },
                          leftSwipeAllowed: true,
                          rightSwipeAllowed: true,
                          upSwipeAllowed: true,
                          fillSpace: true,
                          likeTag: Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green)
                            ),
                            child: Text('This is funny'),
                          ),
                          nopeTag: Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red)
                            ),
                            child: Text('This is not funny'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  _matchEngine!.currentItem?.nope();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.greenAccent[400], // Background color
                                ),
                                child: Text("This is not funny")),
                            ElevatedButton(
                                onPressed: () {
                                  _matchEngine!.currentItem?.like();
                                },
                                child: Text("This is funny"))
                          ],
                        ),
                      )
                    ])),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child:  Container(
                      margin: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      height: 150,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFFDFDFDF)),
                        ),
                      ),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "Coder must finished at least 50% of the requirements to be given a pass. Evaluation will be based on speed, code quality and critical thinking. Grading is pessimistic - You will not get an A unless. ",
                                style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 13),

                              ),
                              TextSpan(
                                text: "Copyright 2021 HLS \n",
                                style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 15, height: 2),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ),

              ],
            )
        ),


    );
  }
}