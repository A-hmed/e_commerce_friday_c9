import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/product_dm.dart';
import 'package:e_commerce_friday_c9/ui/shared_view_models/cart_view_model.dart';
import 'package:e_commerce_friday_c9/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/app_assets.dart';
import '../utils/app_color.dart';

class ProductItem extends StatefulWidget {
  ProductDM model;
  bool isInCart;

  ProductItem(this.model, this.isInCart, {super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(6),
        width: MediaQuery.of(context).size.width * .4,
        margin: const EdgeInsets.all(12),
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
                  imageUrl: widget.model.imageCover ?? "",
                  placeholder: (_, __) => const LoadingWidget(),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * .15,
                ),
                Image.asset(
                  AppAssets.icFav,
                )
              ],
            ),
            const Spacer(),
            Text(
              widget.model.title ?? "",
              textAlign: TextAlign.start,
              maxLines: 2,
              style: TextStyle(height: 1),
            ),
            const Spacer(),
            Row(
              children: [
                Text("Review(${widget.model.ratingsAverage ?? ""})"),
                Icon(
                  Icons.star,
                  color: Colors.amberAccent,
                ),
              ],
            ),
            Row(
              children: [
                Text("EGP ${widget.model.price}"),
                const Spacer(),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {
                      CartViewModel viewModel = BlocProvider.of(context);
                      if (widget.isInCart) {
                        viewModel.removeFromCart(widget.model.id!);
                      } else {
                        viewModel.addProductToCart(widget.model.id!);
                      }
                    },
                    child: Icon(
                      widget.isInCart ? Icons.remove : Icons.add,
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
