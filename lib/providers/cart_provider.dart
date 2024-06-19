import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{
  //une liste de Map<String, dynamic>
  final List<Map<String, dynamic>> cart = [];

  void addProduct(Map<String, dynamic> product){
    //cart cest la liste
    //add pour ajouter queleque chose dans la liste
    //ajouter quoi ? un Map<String, dynamic>
    cart.add(product);
    //la classe ChangeNotifier est utilisée pour créer 
    //des objets qui peuvent notifier les écouteurs (ou les widgets) [widget = ecouteur]
    //lorsqu'un changement de données se produit.

    //La méthode notifyListeners est appelée 
    //pour signaler à ces écouteurs que les données 
    //ont été mises à jour, les invitant ainsi à reconstruire 
    //les parties de l'interface utilisateur qui dépendent de ces données.
    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product){
    cart.remove(product);
    notifyListeners();
  }
}