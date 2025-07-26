import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/string_constants.dart';
import '../controllers/task_controllers/llm_remote_description_controller.dart';
import '../controllers/task_controllers/prompt_description_controller.dart';
import '../controllers/task_controllers/title_controller.dart';
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
        return SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: promptDescription.isEmpty
                ? null
                : () async => ref
                      .read(llmRemoteDescriptionControllerProvider.notifier)
                      .fetchLlmRemoteDescription(
                        title: title,
                        prompt: promptDescription,
                      ),
            icon: const Icon(Icons.auto_awesome),
            label: Text(StringConstants.generateWithIaButton),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.purple,
              side: const BorderSide(color: Colors.purple),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
      error: (error, stack) {
        return Text(
          StringConstants.errorPrefix + error.toString(),
          style: const TextStyle(color: Colors.red),
        );
      },
      loading: () => const Center(child: AdaptiveProgressIndicator()),
    );
  }
}
