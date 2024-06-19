import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    //utilise la syntaxe d'un inherited widget puisque c'en est un
    //du coup il va aller chercher l'ancestor le plus proche
    //l'ancestor le proche d'un Provider<String> c'est mon hello world dans le main
    //print(Provider.of<String>(context));//exemple

    //avant cart c'etait les valeur dans global variable
    //maintenant cart c'est ce qu'il y a dans notre provider
    //RAPPEL Povider equivalent de SESSION en web

    //final cart = Provider.of<CartProvider>(context).cart;
    final cart =
        context.watch<CartProvider>().cart; //mm chose que la ligne au dessus

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return ListTile(
            //met nimporte quel widget au debut du listtile
            leading: CircleAvatar(
              //peut pas mettre car Image.asset(cartItem['imageUrl'].toString()
              //est un widget et AssetImage est une classe
              //propriete backgroundImage ne veut pas de widget
              backgroundImage: AssetImage(
                (cartItem['imageUrl']) as String,
              ),
              //taille du cercle
              radius: 30,
            ),
            trailing: IconButton(
              onPressed: () {
                //showDialog est une fonction(offert par flutter)
                //qui va nous permettre d'afficher un UI
                showDialog(
                  context: context,
                  builder: (context) {
                    //Dialog() est un recipient pour créer un modal custom

                    //AlertDialog basic modal
                    return AlertDialog(
                      title: Text(
                        'Delete title',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: const Text(
                          'Are u sur u want to remove the product from ur cart ?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Provider.of<CartProvider>(context, listen: false)
                            //     .removeProduct(cartItem);
                            context.read<CartProvider>().removeProduct(
                                cartItem); //mm chose que la ligne au dessus
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            title: Text(
              cartItem['title'].toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text('Size: ${cartItem['size']}'),
          );
        },
      ),
    );
  }
}
