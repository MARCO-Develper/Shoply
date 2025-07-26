import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/feature/cart/controller/cart_cubit.dart';
import 'package:shoply/core/model/response/product_response.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CartCubit.get(context).getCartProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                "My Cart",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1F1F1F),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final cartCubit = CartCubit.get(context);
                    if (state is CartLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is CartError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.message,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                cartCubit.getCartProducts();
                              },
                              child: const Text('Try Again'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (cartCubit.cartProducts.isEmpty) {
                      return const EmptyCartWidget();
                    }

                    return CartBodyWidget(
                      cartProducts: cartCubit.cartProducts,
                      totalPrice: cartCubit.totalPrice,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget({
    super.key,
    required this.cartProducts,
    required this.totalPrice,
  });

  final List<ProductResponse> cartProducts;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: ListView.separated(
            itemBuilder: (context, index) => CartItemWidget(
              product: cartProducts[index],
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: cartProducts.length,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff212121),
                      ),
                    ),
                    Text(
                      "EGP ${totalPrice.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff212121),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () {},
                  color: const Color(0xff212121),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Checkout",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.product,
  });

  final ProductResponse product;

  @override
  Widget build(BuildContext context) {
    final cartCubit = CartCubit.get(context);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF4F4F4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product.images?.isNotEmpty == true
                  ? product.images!.first
                  : "https://via.placeholder.com/100",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? "Unknown Product",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff212121),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  "EGP ${product.price ?? 0}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff212121),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  cartCubit.removeFromCart(product);
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  size: 30,
                  color: Color(0xff212121),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        cartCubit.decreaseQuantity(product);
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Color(0xff212121),
                      ),
                    ),
                    Text(
                      "${product.quantity}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff212121),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cartCubit.increaseQuantity(product);
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Color(0xff212121),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Add some products to get started",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
