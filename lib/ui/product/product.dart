import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_seven_nike_welcomeback/common/utils.dart';
import 'package:project_seven_nike_welcomeback/data/favorite.manager.dart';
import 'package:project_seven_nike_welcomeback/data/product.dart';
import 'package:project_seven_nike_welcomeback/ui/product/details.dart';
import 'package:project_seven_nike_welcomeback/ui/widgets/images.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.product,
     required this.borderRadius, this.itemWidth = 176 ,  this.itemHeight = 189,
  }) : super(key: key);

  final ProductData product;
  final BorderRadius borderRadius;

final double itemWidth;
final double itemHeight;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        borderRadius: widget.borderRadius,
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: widget.product,))),
        child: SizedBox(
          width: widget.itemWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // برای تصاویر ابعاد ان ها هم عوض بشه
                   AspectRatio(
                aspectRatio: 0.93,
                    child: ImagesLoadingService(
                      imageUrl: widget.product.imageUrl,
                      borderRadius: widget.borderRadius,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: (){
                        if (!favoriteManager.isFavorite(widget.product )){
                          favoriteManager.addFavorite(widget.product);
                        }else{
                          favoriteManager.delete(widget.product);
                        }
                         setState(() {

                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child:  Icon(
                         favoriteManager.isFavorite(widget.product)? CupertinoIcons.heart_fill:CupertinoIcons.heart,
                          size: 24,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(left: 1),
                      child: SizedBox(
                          width: 135,
                          child: Text(
                            widget.product.title,
                            overflow: TextOverflow.visible,
                            style: const TextStyle(fontSize: 12),
                          ),),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Text(
                      widget.product.previousPrice.withPriceLabel,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(decoration: TextDecoration.lineThrough),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Expanded(
                    child: Text(widget.product.price.withPriceLabel),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
