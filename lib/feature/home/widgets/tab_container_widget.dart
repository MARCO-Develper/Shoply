import 'package:shoply/core/model/response/category_response.dart';
import 'package:shoply/feature/home/view/product_of_category_screen.dart';
import 'package:shoply/feature/home/widgets/tab_item_widget.dart';
import 'package:flutter/material.dart';

class TabContainerWidget extends StatefulWidget {
  const TabContainerWidget({
    super.key,
    required this.categories,
  });
  final List<CategoryResponse> categories;

  @override
  State<TabContainerWidget> createState() => _TabContainerWidgetState();
}

class _TabContainerWidgetState extends State<TabContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.zero,
            onTap: (int index) {
              Navigator.of(context).pushNamed(
                ProductOfCategoryScreen.routeName,
                arguments: widget.categories[index],
              );
            },
            tabs: widget.categories
                .map(
                  (source) => TabItemWidget(
                    category: source,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
