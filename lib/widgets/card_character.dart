import 'package:flutter/material.dart';

class CardCharacter extends StatelessWidget {
  final String title, sub1, sub2, image;

  const CardCharacter({
    super.key,
    required this.title,
    required this.sub1,
    required this.sub2,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sub1),
            Text(sub2),
          ],
        ),
        trailing: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: CircleAvatar(backgroundImage: Image.asset(image).image),
          );
        }),
      ),
    );
  }
}
