import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final Color backgroundColor;
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //espace a lexterieur
      margin: const EdgeInsets.all(20),
      //espace àlinterieur
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        //Si on a une classe qui herite de decoration
        //alors la propriete color doit specifie dans la classe
        // sinon une erreur occur
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Rappel "context" aide à localisé ce widget
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '$price €',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Image.asset(
              image,
              height: 175,
            ),
          ),
          /*
          Image(
            image: AssetImage(image),
            height: 175,
          ),*/
        ],
      ),
    );
  }
}
