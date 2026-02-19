import 'package:flutter/material.dart';
import 'bag_list_tile.dart';

class BagList extends StatelessWidget {
  const BagList({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (i) {
        return BagListTile(
          title: items[i],
          selected: selectedIndex == i,
          onTap: () => onSelect(i),
        );
      }),
    );
  }
}