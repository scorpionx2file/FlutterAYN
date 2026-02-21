import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/theme/fonts/app_text_styles.dart';
import '../widgets/selectable_gate_card.dart';
import '../widgets/sign_in_progress_bar.dart';

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
    GateItem(id: "adventure", title: "Adventure Gate", asset: "assets/images/gate.png"),
    GateItem(id: "mountains", title: "Mountain Trails", asset: "assets/images/gate.png"),
    GateItem(id: "desert", title: "Desert Escape", asset: "assets/images/gate.png"),
    GateItem(id: "city", title: "City Breaks", asset: "assets/images/gate.png"),
    GateItem(id: "culture", title: "Culture & Museums", asset: "assets/images/gate.png"),
    GateItem(id: "food", title: "Food Trips", asset: "assets/images/gate.png"),
    GateItem(id: "islands", title: "Island Hopping", asset: "assets/images/gate.png"),
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
      if (_selected.length < 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.chooseGatesMin3Snack)),
        );
        return;
      }
      context.push(AppRoutes.register);
    } else {
      final gate = _gates.firstWhere((g) => _selected.first == g.id);
      Navigator.of(context).pop(gate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _selected.isEmpty ? 0.0 : (1 / 3);

    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: AppColors.white,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 12.h),
          child: SizedBox(
            width: double.infinity,
            child: AppButton(
              text: context.l10n.next,
              onPressed: () => _next(),
              height: 36.h,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if (widget.allowMultiple) ...[
                SignInProgressBar(
                  currentStep: 1,
                  totalSteps: 3,
                  progressValue: progress,
                  onBack: () => Navigator.of(context).pop(),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 14.h),
                      Text(
                        context.l10n.chooseGatesTitle,
                        style: AppTextStyles.title.copyWith(color: AppColors.black),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        context.l10n.chooseGatesSubtitle,
                        style: AppTextStyles.description
                            .copyWith(color: AppColors.spanishGrey),
                      ),
                      SizedBox(height: 18.h),
                    ],
                  ),
                ),
              ],

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                      key: ValueKey(g.id),
                      title: g.title,
                      image: AssetImage(g.asset),
                      selected: _selected.contains(g.id),
                      onTap: () => _toggle(g.id),
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}