import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/page_error_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/title_constants.dart';

class FullPageError extends PageError {
  const FullPageError({
    super.key,
    required super.message,
    required super.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: onTryAgain,
              child: const Text(
                TitleConstants.tryAgain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
