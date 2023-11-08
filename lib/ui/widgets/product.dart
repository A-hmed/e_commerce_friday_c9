import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/ui/cubits/cart_cubit.dart';
import 'package:e_commerce_friday_c9/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/app_assets.dart';
import '../utils/app_color.dart';

class Product extends StatefulWidget {
  final ProductDM productDM;
  final bool isInCart;

  const Product({super.key, required this.productDM, required this.isInCart});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late CartCubit cartCubit;

  @override
  void initState() {
    super.initState();
    cartCubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(6),
        width: MediaQuery.of(context).size.width * .4,
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightBlue),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.productDM.imageCover ?? "",
                  placeholder: (_, __) => LoadingWidget(),
                  errorWidget: (_, __, ___) => Icon(Icons.error),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * .15,
                ),
                Image.asset(
                  AppAssets.icFav,
                )
              ],
            ),
            Spacer(),
            Text(
              widget.productDM.title ?? "",
              textAlign: TextAlign.start,
              maxLines: 2,
              style: TextStyle(height: 1),
            ),
            Spacer(),
            Row(
              children: [
                Text("Review(${widget.productDM.ratingsAverage})"),
                Icon(
                  Icons.star,
                  color: Colors.amberAccent,
                ),
              ],
            ),
            Row(
              children: [
                Text("EGP ${widget.productDM.price}"),
                Spacer(),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {
                      if (widget.isInCart) {
                        cartCubit.removeProductFromCart(widget.productDM.id!);
                      } else {
                        cartCubit.addProductToCart(widget.productDM.id!);
                      }
                    },
                    child: Icon(
                      widget.isInCart ? Icons.minimize : Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
