import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_seven_nike_welcomeback/common/utils.dart';
import 'package:project_seven_nike_welcomeback/data/repo/banner_repository.dart';
import 'package:project_seven_nike_welcomeback/data/repo/product_repository.dart';
import 'package:project_seven_nike_welcomeback/ui/home/bloc/home_bloc.dart';
import 'package:project_seven_nike_welcomeback/ui/list/list.dart';
import 'package:project_seven_nike_welcomeback/ui/product/product.dart';
import 'package:project_seven_nike_welcomeback/ui/widgets/error.dart';
import 'package:project_seven_nike_welcomeback/ui/widgets/slider.dart';


import '../../data/product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepository: productRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeSuccess) {
            return ListView.builder(
                physics: defaultScrollPhysics,
                itemCount: 5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Container(
                        height: 56.0,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/img/nike_logo.png',
                          height: 80.0,
                          fit: BoxFit.fitHeight,
                        ),
                      );
                    case 2:
                      return BannerSlider(
                        banners: state.banner,
                      );

                    case 3:
                      return _HorizontalProductList(
                        title: 'جدیدترین',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ProductListScreen(
                                  sort: ProductSort.latest),
                            ),
                          );
                        },
                        products: state.latesProducts,
                      );
                    case 4:
                      return _HorizontalProductList(
                        title: 'پربازدیدترین',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ProductListScreen(
                                  sort: ProductSort.popular),
                            ),
                          );
                        },
                        products: state.popularProducts,
                      );

                    default:
                      return Container();
                  }
                });
          } else if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeError) {
            return AppErrorWidget(
              exception: state.exception,
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
              },
            );
          } else {
            throw Exception('state is not supported');
          }
        }),
      )),
    );
  }
}

class _HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductData> products;

  const _HorizontalProductList({
    Key? key,
    required this.title,
    required this.onTap,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                  onPressed: onTap,
                  child: const Text(
                    'مشاهده همه',
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            physics: defaultScrollPhysics,
            padding: const EdgeInsets.only(left: 8, right: 8),
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              final product = products[index];
              return ProductItem(
                product: product,
                borderRadius: BorderRadius.circular(12),
              );
            }),
          ),
        )
      ],
    );
  }
}
