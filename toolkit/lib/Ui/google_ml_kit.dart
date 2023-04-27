import 'package:flutter/material.dart';

import '../data/ml_kit_list.dart';

class GoogleMLKitGridView extends StatelessWidget {
  const GoogleMLKitGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3 / 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: mlKitList.length,
          itemBuilder: (BuildContext ctx, index) {
            return _buildGridTile(
              context,
              mlKitList[index]['mlKitName'],
              mlKitList[index]['imageLink'],
              mlKitList[index]['widgetName'],
            );
          }),
    );
  }

  Widget _buildGridTile(
    BuildContext context,
    String title,
    String imageUrl,
    Widget widgetName,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => widgetName,
                      ));
                },
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
