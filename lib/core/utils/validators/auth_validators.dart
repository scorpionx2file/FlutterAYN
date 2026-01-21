import 'package:flutter/material.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class AuthValidators {
  static String? name(
      BuildContext context,
      String? v, {
        int minLen = 3,
      }) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return context.l10n.nameRequired;
    if (value.length < minLen) return context.l10n.nameMin(minLen);
    return null;
  }

  static String? email(BuildContext context, String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return context.l10n.emailRequired;

    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(value)) return context.l10n.emailInvalid;

    return null;
  }

  static String? password(
      BuildContext context,
      String? v, {
        int minLen = 6,
      }) {
    final value = (v ?? '');
    if (value.isEmpty) return context.l10n.passwordRequired;
    if (value.length < minLen) return context.l10n.passwordMin(minLen);
    return null;
  }
}
