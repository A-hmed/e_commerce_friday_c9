import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_friday_c9/data/model/product_details_args.dart';
import 'package:e_commerce_friday_c9/data/model/response/cart_product.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/ui/screens/product_details/product_details_view_model.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_color.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_states.dart';
import 'package:e_commerce_friday_c9/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cart_cubit.dart';

class ProductDetails extends StatefulWidget {
  static String routeName = "product details";

  ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late ProductDM productDM;

  CartProduct? cartProduct;

  ProductDetailsViewModel viewModel = getIt();

  late CartCubit cartCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartCubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as ProductDetailsArgs;
    productDM = args.productDM;
    cartProduct = args.cartProduct;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          productDM.title ?? "",
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildSlider(context),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text("Unit Price:"),
                Spacer(),
                Text("${productDM.price ?? " "}")
              ],
            ),
            buildProductInfo(),
            Text("Description"),
            Text("${productDM.description}"),
            Spacer(),
            BlocBuilder<CartCubit, dynamic>(
              builder: (context, state) {
                if (cartCubit.cartDM != null &&
                    cartCubit.cartDM!.products != null) {
                  bool isProductInTheList = false;
                  for (int i = 0; i < cartCubit.cartDM!.products!.length; i++) {
                    print(
                        "Product: ${cartCubit.cartDM!.products![i].product!.title}");
                    if (productDM.id ==
                        cartCubit.cartDM!.products![i].product?.id) {
                      isProductInTheList = true;
                      cartProduct = cartCubit.cartDM!.products![i];
                    }
                  }
                  if (!isProductInTheList) {
                    cartProduct = null;
                  }
                }
                return state is BaseLoadingState
                    ? LoadingWidget()
                    : Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Text("Total price"),
                                Text(
                                    "${(cartProduct?.count ?? 0) * (cartProduct?.price ?? 0)}")
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: cartProduct == null
                                ? buildAddButton()
                                : buildCartOptions(),
                          )
                        ],
                      );
              },
            )
          ],
        ),
      ),
    );
  }

  Container buildCartOptions() {
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

  ElevatedButton buildAddButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          cartCubit.addProductToCart(productDM.id!);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_shopping_cart_outlined),
            Text("Add to cart")
          ],
        ));
  }

  Stack buildSlider(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          child: CarouselSlider(
            options: CarouselOptions(
                aspectRatio: 2.5,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                onPageChanged: (index, _) {
                  viewModel.setImageIndex(index);
                }),
            items: productDM.images!
                .map((imageUrl) => Container(
                      color: Colors.grey,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (_, __) => LoadingWidget(),
                        errorWidget: (_, __, ___) => Icon(Icons.error),
                        width: MediaQuery.of(context).size.width * 95,
                        fit: BoxFit.contain,
                      ),
                    ))
                .toList(),
          ),
        ),
        BlocBuilder(
          bloc: viewModel,
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: productDM.images!
                    .map((string) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: viewModel.currentImageIndex ==
                                    productDM.images!.indexOf(string)
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          ),
                        ))
                    .toList(),
              ),
            );
          },
        ),
      ],
    );
  }

  buildProductInfo() => Row(
        children: [
          Text("${productDM.sold}"),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Text("${productDM.ratingsAverage} (${productDM.ratingsQuantity})"),
        ],
      );
}
