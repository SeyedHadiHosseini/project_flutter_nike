import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_seven_nike_welcomeback/common/utils.dart';
import 'package:project_seven_nike_welcomeback/data/repo/order_repository.dart';
import 'package:project_seven_nike_welcomeback/ui/order/bloc/order_history_bloc.dart';
import 'package:project_seven_nike_welcomeback/ui/widgets/images.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderHistoryBloc(orderRepository)..add(OrderHistoryStarted()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سوابق سفارش'),
        ),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
            builder: (context, state) {
          if (state is OrderHistorySuccess) {
            final orders = state.orders;
            return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Theme.of(context).dividerColor.withOpacity(
                                  0.1,
                                ),
                            width: 1)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 16,right: 16),
                          height: 56,
                          child: Row(
                            children: [
                              const Text('شناسه سفارش'),
                              Text(order.id.toString())
                            ],
                          ),
                        ),const Divider(height: 1,),
                        Container(
                          padding: const EdgeInsets.only(left: 16,right: 16),
                          height: 56,
                          child: Row(
                            children: [
                              const Text('مبلغ'),
                              Text(order.payablePrice.withPriceLabel)
                            ],
                          ),
                        ),
                        const Divider(
                          height: 1,
                        ),
                        SizedBox(
                          height: 132,
                          child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              itemCount: order.items.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index) => Container(
margin: const EdgeInsets.only(left: 4, right: 4),
                                width: 100,
                                height: 100,
                                child: ImagesLoadingService(
                                    
                                    imageUrl: order.items[index].imageUrl , borderRadius: BorderRadius.circular(8)),
                              ),),
                        )
                      ],
                    ),
                  );
                });
          } else if (state is OrderHistoryError) {
            return Center(
              child: Text(state.e.message),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        }),
      ),
    );
  }
}
