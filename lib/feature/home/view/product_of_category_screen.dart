import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoply/core/common/widget/product_item_widget.dart';
import 'package:shoply/core/data/remote_data/home_api.dart';
import 'package:shoply/core/model/response/category_response.dart';

class ProductOfCategoryScreen extends StatelessWidget {
  static const String routeName = 'ProductOfCategoryScreen';
  const ProductOfCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var category =
        ModalRoute.of(context)?.settings.arguments as CategoryResponse?;
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xffEBEBEB),
        title: Text(
          category?.name ?? 'Products',
          style: GoogleFonts.roboto(
            color: Color(0xff212121),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: HomeApi.getProductsOfCategory(category!.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products found'));
            } else {
              var productsList = snapshot.data!;
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7, // Better aspect ratio for products
                ),
                itemCount: productsList.length,
                itemBuilder: (context, index) => ProductItemWidget(
                  product: productsList[index],
                ),
              );
            }
          }),
    );
  }
}
