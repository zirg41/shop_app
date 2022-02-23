import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products.dart';
import '/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem({
    this.id,
    this.imageUrl,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                try {
                  // НЕ ПОНИМАЮ ПОЧЕМУ ЛИСН ФОЛС
                  // ЕБАНЫЙ ЕБАТЬ
                  print("before await");
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                  print("after await");
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text("Product deleted!"),
                    ),
                  );
                } catch (e) {
                  e.toString();
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text("Deleting failed"),
                    ),
                  );
                }
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
