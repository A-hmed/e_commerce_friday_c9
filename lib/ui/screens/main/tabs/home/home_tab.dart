import 'package:e_commerce_friday_c9/data/model/api/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/api/response/product_dm.dart';
import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/tabs/home/home_view_model.dart';
import 'package:e_commerce_friday_c9/ui/shared_view_models/cart_view_model.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_request_states.dart';
import 'package:e_commerce_friday_c9/ui/widgets/category_item.dart';
import 'package:e_commerce_friday_c9/ui/widgets/loading_widget.dart';
import 'package:e_commerce_friday_c9/ui/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeViewModel viewModel = getIt();
  late CartViewModel cartViewModel;

  @override
  void initState() {
    super.initState();
    cartViewModel = BlocProvider.of(context);
    viewModel.loadCategories();
    viewModel.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Row(
            children: [Text("Categories"), Spacer(), Text("viewAll")],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: BlocBuilder(
                bloc: viewModel.getAllCategoriesUseCase,
                builder: (context, state) {
                  print("Categories state: $state");
                  if (state is BaseRequestSuccessState<List<CategoryDM>>) {
                    return buildCategoriesGridView(state.data!);
                  } else if (state is BaseRequestErrorState) {
                    return ErrorWidget(state.message);
                  } else {
                    return LoadingWidget();
                  }
                }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: BlocBuilder(
                bloc: viewModel.getAllProductsUseCase,
                builder: (context, state) {
                  print("Products state: $state");
                  if (state is BaseRequestSuccessState<List<ProductDM>>) {
                    return buildProductsList(state.data!);
                  } else if (state is BaseRequestErrorState) {
                    return ErrorWidget(state.message);
                  } else {
                    return LoadingWidget();
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget buildCategoriesGridView(List<CategoryDM> list) {
    return GridView.builder(
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => CategoryItem(list[index]));
  }

  Widget buildProductsList(
    List<ProductDM> list,
  ) {
    return BlocBuilder<CartViewModel, dynamic>(
      builder: (context, state) {
        print("Cart state: ${state}");
        return ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var product = list[index];
              bool isInCart = false;
              if (cartViewModel.cartDM != null) {
                isInCart = cartViewModel.isInCart(
                    product, cartViewModel.cartDM!.products);
              }
              return ProductItem(product, isInCart);
            });
      },
    );
  }
}
