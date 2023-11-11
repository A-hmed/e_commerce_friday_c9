import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/ui/screens/main/tabs/home/home_view_model.dart';
import 'package:e_commerce_friday_c9/ui/utils/base_request_states.dart';
import 'package:e_commerce_friday_c9/ui/utils/exentions.dart';
import 'package:e_commerce_friday_c9/ui/widgets/category_item.dart';
import 'package:e_commerce_friday_c9/ui/widgets/error_view.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.loadCategories();
    viewModel.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          SizedBox(
            height: 30.h(context),
            child: BlocBuilder(
                bloc: viewModel.getAllCategoriesUseCase,
                builder: (context, state) {
                  if (state is BaseRequestSuccessState<List<CategoryDM>>) {
                    return buildCategoriesGridView(state.data!);
                  } else if (state is BaseRequestErrorState) {
                    return ErrorView(message: state.message);
                  } else {
                    return const LoadingWidget();
                  }
                }),
          ),
          SizedBox(
            height: 30.h(context),
            child: BlocBuilder(
                bloc: viewModel.getAllProductsUseCase,
                builder: (context, state) {
                  if (state is BaseRequestSuccessState<List<ProductDM>>) {
                    return buildProductsListView(state.data!);
                  } else if (state is BaseRequestErrorState) {
                    return ErrorView(message: state.message);
                  } else {
                    return const LoadingWidget();
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget buildProductsListView(List<ProductDM> data) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Product(data[index]);
        });
  }

  Widget buildCategoriesGridView(List<CategoryDM> data) {
    return GridView.builder(
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return CategoryItem(data[index]);
        });
  }
}
