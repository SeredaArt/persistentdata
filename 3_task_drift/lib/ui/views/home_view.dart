import 'package:flutter/material.dart';
import 'package:persistentdata/model/users.dart';
import 'package:persistentdata/ui/views/user_add.dart';

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
        '/add_user': (BuildContext context) => const UserViewPage(),
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
  late MyDataBase _dataBase;
  @override
  void initState() {
    super.initState();
    _dataBase = MyDataBase();
  }

  void _addUser(User user) async {
    await _dataBase.insertUser(user);
  }

  void _deleteUser(User user) async {
    await _dataBase.deleteUser(user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Users'),
      ),
      body: StreamBuilder<List<User>>(
        initialData: const [],
        builder: (BuildContext context, users) {
          return ListView.builder(
            itemCount: users.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var user = users.data!.elementAt(index);
              return ListTile(
                leading:
                    CircleAvatar(foregroundImage: NetworkImage(user.image)),
                title: Text('${user.name} + ${user.lastname}'),
                subtitle: Text(
                  '${user.years} - ${user.phone}',
                ),
                trailing: Row(children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.change_circle_outlined)),
                  IconButton(
                      onPressed: () {
                        _deleteUser(user);
                      },
                      icon: Icon(Icons.delete)),
                ]),
              );
            },
          );
        },
        stream: _dataBase.usersStream,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => () {
          Navigator.of(context).pushNamed('/add_user');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
