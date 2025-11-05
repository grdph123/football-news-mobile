import 'package:flutter/material.dart';
import 'package:football_news/screens/newslist_form.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color; // TAMBAH PARAMETER COLOR

  ItemHomepage(this.name, this.icon, this.color); // UPDATE CONSTRUCTOR
}

class NewsCard extends StatelessWidget {
  final ItemHomepage item;

  const NewsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color, // GUNAKAN COLOR DARI ITEM, BUKAN DARI THEME
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );

          if (item.name == "Add News") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsFormPage()),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}