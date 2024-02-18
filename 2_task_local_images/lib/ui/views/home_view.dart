import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

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
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController _controller = TextEditingController();
  List<File>? images;
  String userUrl = '';

  Future<String> get _localPath async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    return documentDirectory.path;
  }

  Future<File> get _localFile async {
    final localPath = await _localPath;
    var firstPath = "$localPath/images";
    var filePathAndName = localPath + path.basename(_controller.text);
    await Directory(firstPath).create(recursive: true);
    File file = File(filePathAndName);
    return file;
  }

  Future<void> _writeImage(String url) async {
    var response = await get(Uri.parse(url));
    var file = await _localFile;
    file.writeAsBytesSync(response.bodyBytes);
    images?.add(file);
    setState(() {});
  }

  Future _readImages() async {
    try {
      final localPath = await _localPath;
      final filesPath = localPath + "/images";
      final filesPathFolder =
          await Directory(filesPath).create(recursive: true);
      images =
          await filesPathFolder.list().map((file) => File(file.path)).toList();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _readImages();
    super.initState();
  }

  @override
  void disposeState() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Load images to file'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            images == null || images?.isEmpty == true
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    flex: 5,
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          final image = images!.elementAt(index);

                          return AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.file(
                                image,
                                fit: BoxFit.fill,
                              ));
                        },
                        itemCount: images?.length)),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Введите URL',
                  suffixIcon: ElevatedButton(
                    child: const Text('LOAD'),
                    onPressed: () async {
                      userUrl = _controller.value.text;
                      await _writeImage(userUrl);
                    },
                  ),
                ),
                onSubmitted: (value) async {
                  userUrl = value;
                  await _writeImage(userUrl);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
