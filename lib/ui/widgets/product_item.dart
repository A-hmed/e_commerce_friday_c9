import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../utils/app_color.dart';

class ProductItem extends StatefulWidget {
  final ProductDM productDM;

  const ProductItem({super.key, required this.productDM});

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
                  imageUrl: widget.productDM.imageCover ?? "",
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
              widget.productDM.title ?? "",
              textAlign: TextAlign.start,
              maxLines: 2,
              style: TextStyle(height: 1),
            ),
            const Spacer(),
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
                const Spacer(),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {},
                    child: const Icon(
                      Icons.add,
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
