import 'package:flutter/material.dart';

abstract class PageError extends StatelessWidget {
  final String message;
  final Function() onTryAgain;
  const PageError({
    Key? key,
    required this.message,
    required this.onTryAgain,
  }) : super(key: key);
}
