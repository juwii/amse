import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  final List<Map<String, dynamic>> _allMedias = [
    {"id": 1, "name": "Harry Potter", "Category": "livre", "aime": false, "data": "Book about Harry Potter"},
    {"id": 2, "name": "Eragon", "Category": "livre", "aime": false, "data": "Book about Eragon"},
    {"id": 3, "name": "Basket", "Category": "sport", "aime": false, "data": "Basket is a team sport"},
    {"id": 4, "name": "Avatar 2", "Category": "film", "aime": false, "data": "Second film about blue aliens"},
    {"id": 5, "name": "Star wars", "Category": "film", "aime": false, "data": "All is in the name"},
    {"id": 6, "name": "Compilation coupe du monde", "Category": "sport", "aime": false, "data": "You really care about that sport?"},
    {"id": 7, "name": "Jane Eyre", "Category": "livre", "aime": false, "data": "An amazing english romance book"},
    {"id": 8, "name": "Bienvenue chez les chtis", "Category": "film", "aime": false, "data": "Welcome to the North of France!"},
    {"id": 9, "name": "Hockey", "Category": "sport", "aime": false, "data": "A cool sport"},
    {"id": 10, "name": "Les 10 petits nègres", "Category": "livre", "aime": false, "data": "A scary book about crimes"},
  ];
  bool? checkedValue_book = true;
  bool? checkedValue_films = true;
  bool? checkedValue_sports = true;
  bool? checkedValue_aimes = false;
  var number_like = 0;
  bool isLoaded = false;

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundMedias = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundMedias = _allMedias;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter() {
    List<Map<String, dynamic>> results = [];
    if (checkedValue_book == true) {
      results = _allMedias
          .where((media) =>
              media["Category"].toLowerCase().contains("livre"))
          .toList();
    }
    if (checkedValue_films == true) {
      results += _allMedias
          .where((media) =>
              media["Category"].toLowerCase().contains("film"))
          .toList();
    }
    if (checkedValue_sports == true) {
      results += _allMedias
          .where((media) =>
              media["Category"].toLowerCase().contains("sport"))
          .toList();
    }
    if (checkedValue_aimes == true) {
      results = results
          .where((media) =>
              media["aime"])
          .toList();
    }

    // Refresh the UI
    setState(() {
      _foundMedias = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!isLoaded) {
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Welcome to MyBibliotheque !"),
            content: Text("Let's start discovering new medias!"),
            icon: Icon(Icons.celebration),
            actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                isLoaded = true;
              },
              child: Container(
                color: Colors.green,
                padding: const EdgeInsets.all(14),
                child: const Text("Got it!",
                style: TextStyle(
                  color: Colors.black,
                  ),
                ),
              ),
            ),
            ],
            )
          );
    }
    );
    }
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_online),
            label: 'Media',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.info),
            icon: Icon(Icons.bookmark_border),
            label: 'About',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.grey,
          alignment: Alignment.center,
          child: Text('Nombre de médias aimés : $number_like'),
        ),
       ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Column()
            //CheckboxListTile(
              title: Text("Livres"),
              value: checkedValue_book,
              onChanged: (newValue) {
                setState(() {
                  checkedValue_book = newValue;
                  _runFilter();
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
           // ),
            CheckboxListTile(
              title: Text("Films"),
              value: checkedValue_films,
              onChanged: (newValue) {
                setState(() {
                  checkedValue_films = newValue;
                  _runFilter();
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
            CheckboxListTile(
              title: Text("Sports"),
              value: checkedValue_sports,
              onChanged: (newValue) {
                setState(() {
                  checkedValue_sports = newValue;
                  _runFilter();
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
            CheckboxListTile(
              title: Text("Medias aimés"),
              value: checkedValue_aimes,
              onChanged: (newValue) {
                setState(() {
                  checkedValue_aimes = newValue;
                  _runFilter();
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
                  
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const PageScrollPhysics(),
                      itemCount: _foundMedias.length,
                      itemBuilder: (context, index) => Container(
                        height: 200,
                        
                        child: Card(
                          key: ValueKey(_foundMedias[index]["id"]),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.grey,
                                    Colors.blue,
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1.5, 0.0),
                                  stops: [0.0, 1.5],
                                  tileMode: TileMode.clamp),
                            ),
                            child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: _foundMedias[index]["aime"]
                                    ? Icon(
                                      Icons.favorite,
                                      size: 40
                                      )
                                    : const Icon(
                                    Icons.favorite_border,
                                    size: 40,
                                    ),
                                    onPressed: () {
                                      change_like(index);
                                      setState(() {
                                          _foundMedias[index]["aime"] = !_foundMedias[index]["aime"];
                                          });
                                    }
                                  
                                ),
                              ],
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(_foundMedias[index]['name'], 
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                                Text('${_foundMedias[index]['Category']}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                  ),)
                              ],
                            ),
                          
                          onLongPress: () {
                            HapticFeedback.heavyImpact();
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("More data"),
                                content: Text(_foundMedias[index]["data"]),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                      child: Container(
                                        color: Colors.green,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("Got it!",
                                        style: TextStyle(
                                          color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                          
                ),
              ),
            )
          ],
        ),
        Container(
          color: Colors.grey,
          alignment: Alignment.center,
          child: ListView(
          shrinkWrap: true,
          children:  <Widget>[
            new Center(child: Text("Media app")),
            new Center(child: Text("Developers: Cédric Prast and Juliette Létondot")),
            new Center(child: Text("v1.0")),
            new Center(child: Text("@Copyrights IMT company")),
          ],
        ),
        ),
      ][currentPageIndex],
    );
  }

  void change_like(var index) {
    if(_foundMedias[index]["aime"]){
        dislike_media(index);
      } else {
        like_media(index);
    }
  }

  void like_media(var index) {
      number_like++;
  }

  void dislike_media(var index) {
    number_like--;
  }
}