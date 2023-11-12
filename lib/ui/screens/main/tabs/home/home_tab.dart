import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_friday_c9/data/model/product_details_args.dart';
import 'package:e_commerce_friday_c9/data/model/response/cart_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/cart_product.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/ui/cubits/cart_cubit.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/tabs/home/home_view_model.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_assets.dart';
import 'package:e_commerce_friday_c9/ui/utils/app_color.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_states.dart';
import 'package:e_commerce_friday_c9/ui/widgets/category_item.dart';
import 'package:e_commerce_friday_c9/ui/widgets/error_view.dart';
import 'package:e_commerce_friday_c9/ui/widgets/loading_widget.dart';
import 'package:e_commerce_friday_c9/ui/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product_details/product_details.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeViewModel viewModel = getIt();
  List<String> ads = ["1", "2", "3"];
  int adsIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getCategories();
    viewModel.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(
            height: 16,
          ),
          buildSlider(),
          SizedBox(
            height: 12,
          ),
          const Row(
            children: [Text("Categories"), Spacer(), Text("viewAll")],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: BlocBuilder(
                bloc: viewModel.categoriesUseCase,
                builder: (context, state) {
                  if (state is BaseErrorState) {
                    return ErrorView(message: state.errorMessage);
                  } else if (state is BaseSuccessState<List<CategoryDM>>) {
                    return buildCategoriesList(state.data!);
                  } else {
                    return LoadingWidget();
                  }
                }),
          ),
          const Text("Home Appliance"),
          SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: BlocBuilder<CartCubit, dynamic>(
              builder: (context, cartState) {
                if (cartState is BaseSuccessState<CartDM>) {
                  return BlocBuilder(
                      bloc: viewModel.getAllProductsUseCase,
                      builder: (context, state) {
                        if (state is BaseErrorState) {
                          return ErrorView(message: state.errorMessage);
                        } else if (state is BaseSuccessState<List<ProductDM>>) {
                          return buildProductsList(
                              state.data!, cartState.data!);
                        } else {
                          return LoadingWidget();
                        }
                      });
                } else if (cartState is BaseErrorState) {
                  return ErrorView(message: cartState.errorMessage);
                } else {
                  return LoadingWidget();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Stack buildSlider() {
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
                viewModel.setAdsIndex(index);
              }),
          items: ads
              .map((e) => Image.asset(
                    AppAssets.ads,
                    fit: BoxFit.fill,
                  ))
              .toList(),
        )),
        BlocBuilder(
          bloc: viewModel,
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ads
                    .map((string) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor:
                                viewModel.adsIndex == ads.indexOf(string)
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

  Widget buildProductsList(List<ProductDM> products, CartDM cartDM) {
    return ListView.builder(
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          CartProduct? cartProduct;
          ProductDM productDM = products[index];
          bool isInCart = false;
          for (int i = 0; i < cartDM.products!.length; i++) {
            if (productDM.id == cartDM.products![i].product?.id) {
              cartProduct = cartDM.products![i];
              isInCart = true;
            }
          }
          return InkWell(
              onTap: () {
                Navigator.pushNamed(context, ProductDetails.routeName,
                    arguments: ProductDetailsArgs(
                        productDM: productDM, cartProduct: cartProduct));
              },
              child: Product(productDM: productDM, isInCart: isInCart));
        });
  }

  Widget buildCategoriesList(List<CategoryDM> categories) {
    return GridView.builder(
        itemCount: categories.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryItem(categoryDM: categories[index]);
        });
  }
}
