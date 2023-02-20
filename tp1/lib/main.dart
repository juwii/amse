import 'package:flutter/material.dart';

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
  bool? checkedValue_book = true;
  bool? checkedValue_films = true;
  bool? checkedValue_sports = true;
  var number_like = 0;
  List<bool> is_liked = [false, false, false, false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
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
          color: Colors.red,
          alignment: Alignment.center,
          child: Text('Nombre de médias aimés : $number_like'),
        ),
       ListView(
          shrinkWrap: true,
          children: [
            CheckboxListTile(
              title: Text("Livres"),
              value: checkedValue_book,
              onChanged: (newValue) {
                setState(() {
                  checkedValue_book = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
            CheckboxListTile(
              title: Text("Films"),
              value: checkedValue_films,
              onChanged: (newValue) {
                setState(() {
                  checkedValue_films = newValue;
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
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
            Card(clipBehavior: Clip.hardEdge,
              color: Colors.grey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                  if(is_liked[0]){
                    dislike_media(0);
                  } else {
                      like_media(0);
                  }
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('This is 1 item'),
                ),
              ),
            ),
            Card(clipBehavior: Clip.hardEdge,
              color: Colors.grey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                  if(is_liked[1]){
                    dislike_media(1);
                  } else {
                      like_media(1);
                  }
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('This is 2 item'),
                ),
              ),
            ),
            Card(clipBehavior: Clip.hardEdge,
              color: Colors.grey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                  if(is_liked[2]){
                    dislike_media(2);
                  } else {
                      like_media(2);
                  }
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('This is 3 item'),
                ),
              ),
            ),
            Card(clipBehavior: Clip.hardEdge,
              color: Colors.grey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                  if(is_liked[3]){
                    dislike_media(3);
                  } else {
                      like_media(3);
                  }
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('This is 4 item'),
                ),
              ),
            ),
            Card(clipBehavior: Clip.hardEdge,
              color: Colors.grey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                  if(is_liked[4]){
                    dislike_media(4);
                  } else {
                      like_media(4);
                  }
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('This is 5 item'),
                ),
              ),
            ),
            Card(clipBehavior: Clip.hardEdge,
              color: Colors.grey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                  if(is_liked[5]){
                    dislike_media(5);
                  } else {
                      like_media(5);
                  }
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('This is 6 item'),
                ),
              ),
            ),
            Card(clipBehavior: Clip.hardEdge,
              color: Colors.grey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                  if(is_liked[6]){
                    dislike_media(6);
                  } else {
                      like_media(6);
                  }
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('This is 7 item'),
                ),
              ),
            ),
            Card(clipBehavior: Clip.hardEdge,
              color: Colors.grey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                  if(is_liked[7]){
                    dislike_media(7);
                  } else {
                      like_media(7);
                  }
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('This is 8 item'),
                ),
              ),
            ),
            Card(clipBehavior: Clip.hardEdge,
              color: Colors.grey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                  if(is_liked[8]){
                    dislike_media(8);
                  } else {
                      like_media(8);
                  }
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('This is 9 item'),
                ),
              ),
            ),
            Card(clipBehavior: Clip.hardEdge,
              color: Colors.grey,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                  if(is_liked[9]){
                    dislike_media(9);
                  } else {
                      like_media(9);
                  }
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('This is 10 item'),
                ),
              ),
            ),
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

  void like_media(var index) {
      number_like++;
      is_liked[index] = true;
  }

  void dislike_media(var index) {
    number_like--;
    is_liked[index] = false;
  }
}