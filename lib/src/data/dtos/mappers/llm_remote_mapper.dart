import '../../../domain/llm_remote.dart';
import '../llm_remote_dto.dart';
import 'choice_mapper.dart';

extension LlmRemoteMapper on LlmRemoteDto {
  LlmRemote toModel() =>
      LlmRemote(choices: choices.map((dto) => dto.toModel()).toList());
}
