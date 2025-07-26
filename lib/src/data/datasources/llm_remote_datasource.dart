import '../dtos/llm_remote_dto.dart';

abstract class LlmRemoteDatasource {
  Future<LlmRemoteDto> fetchLlmResponse({
    required String title,
    required String prompt,
  });
}
