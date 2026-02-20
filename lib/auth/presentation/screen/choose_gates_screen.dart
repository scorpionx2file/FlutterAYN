import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import '../widgets/selectable_gate_card.dart';

class GateItem {
  const GateItem({required this.id, required this.title, required this.asset});

  final String id;
  final String title;
  final String asset;
}

class ChooseGatesScreen extends StatefulWidget {
  final bool allowMultiple;
  final PreferredSizeWidget? appBar;

  const ChooseGatesScreen({
    super.key,
    this.allowMultiple = true,
    this.appBar,
  });

  @override
  State<ChooseGatesScreen> createState() => _ChooseGatesScreenState();
}

class _ChooseGatesScreenState extends State<ChooseGatesScreen> {
  final Set<String> _selected = {};

  final List<GateItem> _gates = const [
    GateItem(id: "camping", title: "Camping Adventures", asset: "assets/images/gate.png"),
    GateItem(id: "seas", title: "Seas & Oceans", asset: "assets/images/gate.png"),
    GateItem(id: "paris", title: "Paris Trip", asset: "assets/images/gate.png"),
  ];

  void _toggle(String id) {
    setState(() {
      if (widget.allowMultiple) {
        if (_selected.contains(id)) {
          _selected.remove(id);
        } else {
          _selected.add(id);
        }
      } else {
        _selected.clear();
        _selected.add(id);
      }
    });
  }

  void _next() {
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please choose a gate")),
      );
      return;
    }

    if (widget.allowMultiple) {
      final selectedGates = _gates.where((g) => _selected.contains(g.id)).toList();
      Navigator.of(context).pop(selectedGates);
    } else {
      final gate = _gates.firstWhere((g) => _selected.first == g.id);
      Navigator.of(context).pop(gate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(18.w),
          child: SizedBox(
            width: double.infinity,
            child: AppButton(
              text: "Select",
              onPressed: _next,
              height: 36.h,
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(18.w),
        itemCount: _gates.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14.h,
          crossAxisSpacing: 14.w,
          childAspectRatio: 1.15,
        ),
        itemBuilder: (context, i) {
          final g = _gates[i];
          return SelectableGateCard(
            title: g.title,
            image: AssetImage(g.asset),
            selected: _selected.contains(g.id),
            onTap: () => _toggle(g.id),
          );
        },
      ),
    );
  }
}