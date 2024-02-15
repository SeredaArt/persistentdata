import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistentdata/model/category.dart';
import 'package:persistentdata/ui/views/about_view.dart';
import 'package:persistentdata/ui/views/description_view.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeView(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const HomeView(),
        '/about': (BuildContext context) => const AboutPage(),
        '/description': (BuildContext context) => const DescriptionPage(),
      },
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Box<Category>? _categoryBox;

  @override
  void initState() {
    super.initState();

    _initHive();
  }

  void _initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(CategoryAdapter());

    Hive.openBox<Category>('categories').then((values) {
      setState(() {
        _categoryBox = values;
      });
    });
  }

  void _addRecord(String name, Map<String, String> items) async {
    _categoryBox?.add(Category(name, items));
  }

  void _deleteAll() async {
    final rec = _categoryBox?.values.first;

    rec?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Categories'),
      ),
      body: Center(
          child: _categoryBox == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ValueListenableBuilder(
                  valueListenable: _categoryBox!.listenable(),
                  builder: (context, Box<Category> box, widget) {
                    return ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          final item = box.values.elementAt(index);
                          return ListTile(
                            title: Text(item.category,
                                textAlign: TextAlign.center),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/about',
                                arguments: item,
                              );
                            },
                          );
                        });
                  },
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addRecord('Games', {
          'Halo':
              'Halo is a military science fiction media franchise, originally created and developed by Bungie and currently managed and developed by 343 Industries, part of Microsoft',
          'The Witcher':
              'The Witcher (Polish: Wiedźmin [ˈvʲɛd͡ʑmʲin] (Warlock)) is a 2007 action role-playing game developed by CD Projekt Red for Microsoft Windows and CD Projekt on OS X.',
          'THE FINALS':
              'The Finals, stylized in all caps as THE FINALS, is a free-to-play first-person shooter, developed and published by Nexon subsidiary Embark Studios.',
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
