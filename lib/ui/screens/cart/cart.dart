import 'package:e_commerce_friday_c9/data/model/response/cart_product.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/ui/cubits/cart_cubit.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "cart";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartCubit cartCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartCubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Cart",
          style: TextStyle(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder(
        bloc: cartCubit,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: cartCubit.cartDM?.products?.length ?? 0,
                      itemBuilder: (context, index) {
                        var product =
                            cartCubit.cartDM?.products![index].product!;
                        return buildListRow(
                            product!, cartCubit.cartDM!.products![index]);
                      })),
              buildBottomRow(),
            ],
          );
        },
      ),
    );
  }

  buildListRow(ProductDM productDM, CartProduct cartProduct) => Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 2)),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 2)),
              child: Image.network(
                productDM.imageCover ?? "",
                height: 113,
                width: 120,
              ),
            ),
            SizedBox(
              height: 113,
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text("${productDM.title}"),
                  Spacer(),
                  Text("EGP: ${productDM.price}"),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [
                Icon(Icons.delete),
                buildCartOptions(productDM, cartProduct),
              ],
            )
          ],
        ),
      );

  Container buildCartOptions(ProductDM productDM, CartProduct cartProduct) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryColor,
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                cartCubit.removeProductFromCart(productDM.id!);
              },
              child: Icon(
                Icons.remove,
                color: Colors.white,
              )),
          SizedBox(
            width: 8,
          ),
          Text(
            "${cartProduct?.count ?? 0}",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 8,
          ),
          InkWell(
              onTap: () {
                cartCubit.addProductToCart(productDM.id!);
              },
              child: Icon(Icons.add, color: Colors.white)),
        ],
      ),
    );
  }

  buildBottomRow() => SizedBox();
}
