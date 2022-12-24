import 'package:challenge1/core/widgets/app_search_bar.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    
    return AppSearchBar(hint: "Text");
  }

}