import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/datasources/llm_remote_datasource.dart';
import '../data/datasources/llm_remote_datasource_impl.dart';
import '../data/repositories/llm_remote_repository.dart';

part 'providers.g.dart';

@riverpod
LlmRemoteDatasource llmRemoteDatasource(Ref ref) => LlmRemoteDatasourceImpl();

@riverpod
LlmRemoteRepository llmRemoteRepository(Ref ref) {
  final LlmRemoteDatasource llmRemoteDatasource = ref.watch(
    llmRemoteDatasourceProvider,
  );

  return LlmRemoteRepository(llmRemoteDatasource: llmRemoteDatasource);
}
