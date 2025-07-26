import '../../domain/llm_remote.dart';
import '../datasources/llm_remote_datasource.dart';
import '../dtos/llm_remote_dto.dart';
import '../dtos/mappers/llm_remote_mapper.dart';

class LlmRemoteRepository {
  LlmRemoteRepository({required LlmRemoteDatasource llmRemoteDatasource})
    : _llmRemoteDatasource = llmRemoteDatasource;

  final LlmRemoteDatasource _llmRemoteDatasource;

  Future<LlmRemote> fetchLlmRemoteDescription({
    required String title,
    required String prompt,
  }) async {
    LlmRemote llmRemote;

    final LlmRemoteDto llmRemoteDto = await _llmRemoteDatasource
        .fetchLlmResponse(title: title, prompt: prompt);

    llmRemote = llmRemoteDto.toModel();

    return llmRemote;
  }
}
