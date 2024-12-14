import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_seven_nike_welcomeback/common/utils.dart';
import 'package:project_seven_nike_welcomeback/data/favorite.manager.dart';
import 'package:project_seven_nike_welcomeback/data/product.dart';
import 'package:project_seven_nike_welcomeback/theme.dart';
import 'package:project_seven_nike_welcomeback/ui/product/details.dart';
import 'package:project_seven_nike_welcomeback/ui/widgets/images.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لیست عالاقمندی ها'),
      ),
      body: ValueListenableBuilder<Box<ProductData>>(
        valueListenable: favoriteManager.listenable,
        builder: (context, box, child) {
          final products = box.values.toList();
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductDetailsScreen(product: product)));

                },
                onLongPress: (){
                  favoriteManager.delete(product);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 110,
                        height: 110,
                        child: ImagesLoadingService(
                          imageUrl: product.imageUrl,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.title,style: Theme.of(context).textTheme.titleMedium!.apply(color:  LightThemeColor.primaryTextColor),),
                              const SizedBox(height: 24,),
                              Text(product.previousPrice.withPriceLabel,style: Theme.of(context).textTheme.bodySmall! .apply(decoration: TextDecoration.lineThrough),),
                              Text(product.price.withPriceLabel),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
