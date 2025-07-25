import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/llm_remote_repository.dart';
import '../../../domain/llm_remote.dart';
import '../../providers.dart';
import 'description_controller.dart';

part 'llm_remote_description_controller.g.dart';

@riverpod
class LlmRemoteDescriptionController extends _$LlmRemoteDescriptionController {
  @override
  Future<String?> build() async {
    return null;
  }

  Future<void> fetchLlmRemoteDescription({required String prompt}) async {
    state = const AsyncValue.loading();

    try {
      final LlmRemoteRepository llmRemoteRepository = ref.read(
        llmRemoteRepositoryProvider,
      );

      final LlmRemote result = await llmRemoteRepository
          .fetchLlmRemoteDescription(prompt: prompt);

      ref
          .read(descriptionControllerProvider.notifier)
          .updateDescription(description: result.content);

      state = AsyncValue.data(result.content);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
