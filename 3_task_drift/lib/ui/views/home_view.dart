import 'package:flutter/material.dart';
import 'package:persistentdata/model/users.dart';
import 'package:persistentdata/ui/views/user_add.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeView(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/add_user':
            {
              final args = settings.arguments as ScreenArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return UserViewPage(
                    insertUser: args.insertUser,
                  );
                },
              );
            }
          default:
            return MaterialPageRoute(
              builder: (context) {
                return const HomeView();
              },
            );
        }
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

  Future<int> _insertUser(UsersCompanion user) async {
    return await _dataBase.insertUser(user);
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
        builder: (BuildContext context, AsyncSnapshot<List<User>> users) {
          return ListView.builder(
            itemCount: users.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var user = users.data!.elementAt(index);
              return ListTile(
                leading:
                    CircleAvatar(foregroundImage: NetworkImage(user.image)),
                title: Text('${user.name} ${user.lastname}'),
                subtitle: Text(
                  '${user.years} ${user.phone}',
                ),
                trailing: Wrap(children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.change_circle_outlined)),
                  IconButton(
                      onPressed: () {
                        _deleteUser(user);
                      },
                      icon: const Icon(Icons.delete)),
                ]),
              );
            },
          );
        },
        stream: _dataBase.usersStream(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add_user',
              arguments: ScreenArguments(insertUser: _insertUser));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
