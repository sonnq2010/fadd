import 'package:flutter/material.dart';

abstract class AppShadows {
  const AppShadows._();

  /// Shadow/xs
  static const List<BoxShadow> xs = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
      color: Color(0x0D0D0F17),
    ),
  ];

  /// Shadow/sm
  static const List<BoxShadow> sm = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
      color: Color(0x0F0D0F17),
    ),
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: -1,
      color: Color(0x1A0D0F17),
    ),
  ];

  /// Shadow/md
  static const List<BoxShadow> md = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
      color: Color(0x1A0D0F17),
    ),
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
      color: Color(0x0F0D0F17),
    ),
  ];

  /// Shadow/lg
  static const List<BoxShadow> lg = [
    BoxShadow(
      offset: Offset(0, 12),
      blurRadius: 16,
      spreadRadius: -4,
      color: Color(0x1A0D0F17),
    ),
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
      color: Color(0x0D0D0F17),
    ),
  ];

  /// Shadow/xl
  static const List<BoxShadow> xl = [
    BoxShadow(
      offset: Offset(0, 20),
      blurRadius: 24,
      spreadRadius: -4,
      color: Color(0x1F0D0F17),
    ),
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 8,
      spreadRadius: -4,
      color: Color(0x140D0F17),
    ),
  ];

  /// Shadow/focus-ring
  static const List<BoxShadow> focusRing = [
    BoxShadow(
      offset: Offset.zero,
      blurRadius: 0,
      spreadRadius: 3,
      color: Color(0x733B82F6),
    ),
  ];
}
