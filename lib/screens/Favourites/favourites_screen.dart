import 'package:flutter/material.dart';
import 'package:e_ciftcim/models/Product.dart';

class FavouritesScreen extends StatefulWidget {
  static String routeName = "/favourites";

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<Product> favouriteProducts = [];

  @override
  void initState() {
    super.initState();
    // Demo ürünlerden favori olanları al
    favouriteProducts =
        demoProducts.where((product) => product.isFavourite).toList();
  }

  void removeFromFavourites(Product product) {
    // Favorilerden kaldırma işlevselliği burada gerçekleştirilebilir.
    // Örneğin, favori listesinden ürünü kaldırmak için bir fonksiyon kullanabilirsiniz.
    print('${product.title} favorilerden kaldırıldı.');
    setState(() {
      favouriteProducts.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Favoriler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: favouriteProducts.length,
              itemBuilder: (context, index) {
                Product product = favouriteProducts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      product.images[0],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.title),
                    subtitle: Text(product.description),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        removeFromFavourites(product);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
