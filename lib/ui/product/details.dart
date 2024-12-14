import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_seven_nike_welcomeback/common/utils.dart';
import 'package:project_seven_nike_welcomeback/data/product.dart';
import 'package:project_seven_nike_welcomeback/data/repo/cart_repository.dart';
import 'package:project_seven_nike_welcomeback/theme.dart';
import 'package:project_seven_nike_welcomeback/ui/product/bloc/product_bloc.dart';
import 'package:project_seven_nike_welcomeback/ui/product/comment/comment_list.dart';
import 'package:project_seven_nike_welcomeback/ui/widgets/images.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductData product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  StreamSubscription<ProductState>? stateSubscription;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  @override
  void dispose () {
    stateSubscription?.cancel();
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartRepository);
         stateSubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartSuccess) {
              _scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text('با موفقیت به سبد خرید شما اضافه شد')));
            }else if (state is ProductAddToCartError){
              _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(state.exception.message)));
            }
          });
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: SizedBox(
                width: MediaQuery.of(context).size.width - 48,
                child: BlocBuilder<ProductBloc,ProductState>(

                  builder: (context , state) => FloatingActionButton.extended(
                      onPressed: () {
                        BlocProvider.of<ProductBloc>(context).add(CartAddButtonClick(widget.product.id));
                      }, label: state is ProductAddToCartButtonLoading ? CupertinoActivityIndicator(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ):const Text('افزودن به سبد خرید ')),
                )),
            body: CustomScrollView(
              physics: defaultScrollPhysics,
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 0.8,
                  flexibleSpace: ImagesLoadingService(
                    imageUrl: widget.product.imageUrl,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  foregroundColor: LightThemeColor.primaryTextColor,
                  actions: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              widget.product.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.product.previousPrice.withPriceLabel,
                                  style: Theme.of(context).textTheme.bodySmall!.apply(
                                      decoration: TextDecoration.lineThrough),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(widget.product.price.withPriceLabel),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        //موقتا
                        const Center(
                          child: Text(
                            'این کتونی بسیار برای دیویدن و راه رفتن مناسب است و تقریبا هیچ فشار مخربی را نمیذارد به پا و زانوان شما انتقال داده شود',
                            style: TextStyle(height: 1.4),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('نظرات کاربران'),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'ثبت نظر',
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CommentList(productId: widget.product.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
