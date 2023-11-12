import 'package:e_commerce_friday_c9/data/model/response/cart_product.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';

class ProductDetailsArgs {
  ProductDM productDM;
  CartProduct? cartProduct;

  ProductDetailsArgs({required this.productDM, required this.cartProduct});
}
