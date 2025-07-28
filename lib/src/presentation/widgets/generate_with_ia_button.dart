import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/string_constants.dart';
import '../../core/platform/platform_utils.dart';
import '../controllers/task_controllers/llm_remote_description_controller.dart';
import '../controllers/task_controllers/prompt_description_controller.dart';
import '../controllers/task_controllers/title_controller.dart';
import 'adaptive/adaptive_outlined_button.dart';
import 'adaptive/adaptive_progress_indicator.dart';

class GenerateWithIaButton extends ConsumerWidget {
  const GenerateWithIaButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<String?> llmRemoteDescriptionData = ref.watch(
      llmRemoteDescriptionControllerProvider,
    );

    final String promptDescription = ref.watch(
      promptDescriptionControllerProvider.select((value) => value),
    );

    final String title = ref.watch(
      titleControllerProvider.select((value) => value),
    );

    return llmRemoteDescriptionData.when(
      data: (description) {
        return AdaptiveOutlinedButton(
          onPressed: promptDescription.isEmpty
              ? null
              : () async => ref
                    .read(llmRemoteDescriptionControllerProvider.notifier)
                    .fetchLlmRemoteDescription(
                      title: title,
                      prompt: promptDescription,
                    ),
          icon: Icon(isIOS ? CupertinoIcons.sparkles : Icons.auto_awesome),
          foregroundColor: Colors.purple,
          borderColor: Colors.purple,
          child: Text(StringConstants.generateWithIaButton),
        );
      },
      error: (error, stack) {
        return Text(
          StringConstants.errorPrefix + error.toString(),
          style: TextStyle(
            color: isIOS ? CupertinoColors.systemRed : Colors.red,
          ),
        );
      },
      loading: () => const Center(child: AdaptiveProgressIndicator()),
    );
  }
}
