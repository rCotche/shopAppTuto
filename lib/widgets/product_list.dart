import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app_flutter/global_variables.dart';
import 'package:shop_app_flutter/widgets/product_card.dart';
import 'package:shop_app_flutter/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Bata'];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();

    //Pour set le selectedFilter au lancement de l'application
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    //difference entre inheritedwidget et inheritedmodel
    //inheritedmodel accede au propriete et inheritedwidget au widget

    //Cela permet une optimisation
    //en évitant la reconstruction de tous les widgets
    //descendants lorsqu'une mise à jour spécifique se produit.
    //final size = MediaQuery.of(context).size;
    //final size = MediaQuery.sizeOf(context);// la mm que en haut

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 255, 255, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );

    //SafeArea Creates a widget that avoids operating system interfaces.
    //càd l'heure, la batterie en haut | les boutons de navigation en bas

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Shoes\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              //Creates a widget
              //that expands a child of a [Row], [Column], or [Flex]
              //so that the child fills the available space along the flex widget's main axis.
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //Parce Chip n'a pas de propriete ontap alors je le wrap avec un gesturedetector
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedFilter == filter
                          //Recupere la primaryColor du theme

                          //of(context) est un InheritedWidget
                          //Un InheritedWidget est utilisé pour propager des données ou un état descendant
                          //dans l'arbre des widgets. C'est utile lorsque vous avez besoin
                          //de fournir des données à un grand nombre de widgets enfants
                          //sans avoir à passer explicitement ces données de widget en widget.
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      label: Text(filter),
                      labelStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          //GridView.builder comme ListView.builder
          //on l'utilise qd on connait pas cb item on va devoire afficher

          //child: size.width > 650 ? GridView.builder(
          // : ListView.builder(

          //si le if etait, alors il y aurait pas {}
          //parce que on est dans l'ui
          Expanded(
            //MediaQuery prends la taille du device
            //LayoutBuilder prends en compte les restrictions que les widgets parent ont set up
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 1080) {
                return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //Plus nombre est grd dans notre cas, more shorter sera la carte
                    childAspectRatio: 1.75,
                  ),
                  itemBuilder: ((context, index) {
                    final product = products[index];
                
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailsPage(product: product);
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        //une couleur sur 2
                        backgroundColor: index.isEven
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(245, 247, 249, 1),
                      ),
                    );
                  }),
                );
              } else {
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        //Navigator.of(context).push() est utilisé
                        //pour pousser une nouvelle route sur la pile
                        //de navigation. Cela signifie que lorsque tu
                        //utilises push, tu ajoutes un nouvel écran
                        //au-dessus de l'écran actuel. Par exemple,
                        //si tu as un bouton sur ton écran principal
                        //et que tu veux naviguer vers une nouvelle page
                        //lorsque ce bouton est pressé, tu utiliserais
                        //Navigator.of(context).push() pour afficher cette nouvelle page.
                
                        //pushReplacement sera utilise par exemple après un login screen
                        //car on souhaite pas que l'utilisateur retoutrne sur la page de connexion
                        Navigator.of(context).push(
                          //le change de page entre un ios et un "android" peut changer
                          //c'est pour cela qu'il ya aussi le cupertino version
                          MaterialPageRoute(
                            builder: (context) {
                              //Move to what ?
                              //Move to ProductDetailsPage screen
                              return ProductDetailsPage(product: product);
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        //une couleur sur 2
                        backgroundColor: index.isEven
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(245, 247, 249, 1),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
