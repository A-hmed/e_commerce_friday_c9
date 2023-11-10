import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/category_dm.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final CategoryDM model;

  const CategoryItem(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      //  margin: EdgeInsets.all(1),
      child: Column(
        children: [
          Spacer(),
          CircleAvatar(
            radius: 30,
            backgroundImage: CachedNetworkImageProvider(
              model.image ?? "",
            ),
          ),
          Spacer(),
          Text(
            model.name ?? "",
            textAlign: TextAlign.center,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
