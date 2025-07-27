import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/datasources/hive_task_datasource.dart';
import '../data/datasources/hive_task_datasource.impl.dart';
import '../data/datasources/llm_remote_datasource.dart';
import '../data/datasources/llm_remote_datasource_impl.dart';
import '../data/repositories/hive_task_repository.dart';
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

@riverpod
HiveTaskDatasource hiveTaskDatasource(Ref ref) => HiveTaskDatasourceImpl();

@riverpod
HiveTaskRepository hiveTaskRepository(Ref ref) {
  final HiveTaskDatasource hiveTaskDatasource = ref.watch(
    hiveTaskDatasourceProvider,
  );

  return HiveTaskRepository(hiveTaskDatasource: hiveTaskDatasource);
}
