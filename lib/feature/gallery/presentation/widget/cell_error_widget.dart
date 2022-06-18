import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/page_error_widget.dart';
import 'package:flutter/material.dart';

class CellErrorWidget extends PageError {
  const CellErrorWidget({
    super.key,
    required super.message,
    required super.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            IconButton(
              onPressed: onTryAgain,
              icon: const Icon(Icons.refresh_outlined),
            )
          ],
        ),
      ),
    );
  }
}
