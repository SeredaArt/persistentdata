import 'package:flutter/material.dart';
import 'package:persistentdata/model/category.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final item = (ModalRoute.of(context)?.settings.arguments ??
        Category('title', {})) as Category;
    final items = item.items.keys.toList();
    final itemDescr = item.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(item.category),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              items[index],
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/description', arguments: {
                'title': items[index],
                'description': itemDescr[index]
              });
            },
          );
        },
        itemCount: item.items.length,
      ),
    );
  }
}
