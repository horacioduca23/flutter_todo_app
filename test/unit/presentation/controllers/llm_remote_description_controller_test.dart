import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/src/data/repositories/llm_remote_repository.dart';
import 'package:flutter_todo_app/src/domain/choice.dart';
import 'package:flutter_todo_app/src/domain/llm_remote.dart';
import 'package:flutter_todo_app/src/domain/message.dart';
import 'package:flutter_todo_app/src/presentation/controllers/task_controllers/description_controller.dart';
import 'package:flutter_todo_app/src/presentation/controllers/task_controllers/llm_remote_description_controller.dart';
import 'package:flutter_todo_app/src/presentation/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockLlmRemoteRepository extends Mock implements LlmRemoteRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue('');
  });
  group('LlmRemoteDescriptionController', () {
    late ProviderContainer container;
    late MockLlmRemoteRepository mockRepository;

    setUp(() {
      mockRepository = MockLlmRemoteRepository();
      container = ProviderContainer(
        overrides: [
          llmRemoteRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('fetchLlmRemoteDescription', () {
      test(
        'debe completar exitosamente y actualizar descriptionController',
        () async {
          const title = 'Test title';
          const prompt = 'Test prompt';
          const expectedContent = 'Descripción generada por LLM';
          final mockLlmRemote = LlmRemote(
            choices: [Choice(message: Message(content: expectedContent))],
          );

          when(
            () => mockRepository.fetchLlmRemoteDescription(
              title: title,
              prompt: prompt,
            ),
          ).thenAnswer((_) async => mockLlmRemote);

          final controller = container.read(
            llmRemoteDescriptionControllerProvider.notifier,
          );

          await controller.fetchLlmRemoteDescription(
            title: title,
            prompt: prompt,
          );

          final state = container.read(llmRemoteDescriptionControllerProvider);
          expect(state.hasValue, isTrue);
          expect(state.value, equals(expectedContent));

          final descriptionState = container.read(
            descriptionControllerProvider,
          );
          expect(descriptionState, equals(expectedContent));

          verify(
            () => mockRepository.fetchLlmRemoteDescription(
              title: title,
              prompt: prompt,
            ),
          ).called(1);
        },
      );

      test('debe manejar errores del repositorio correctamente', () async {
        const title = 'Test title';
        const prompt = 'Test prompt';
        final exception = Exception('Error de API');

        when(
          () => mockRepository.fetchLlmRemoteDescription(
            title: title,
            prompt: prompt,
          ),
        ).thenAnswer((_) async => throw exception);

        final controller = container.read(
          llmRemoteDescriptionControllerProvider.notifier,
        );

        await controller.fetchLlmRemoteDescription(
          title: title,
          prompt: prompt,
        );

        final state = container.read(llmRemoteDescriptionControllerProvider);
        expect(state, isA<AsyncError<String?>>());
        expect(state.error.toString(), contains('Error de API'));

        final descriptionState = container.read(descriptionControllerProvider);
        expect(descriptionState, isNull);

        verify(
          () => mockRepository.fetchLlmRemoteDescription(
            title: title,
            prompt: prompt,
          ),
        ).called(1);
      });

      test(
        'debe establecer estado loading durante la llamada a la API',
        () async {
          const title = 'Test title';
          const prompt = 'Test prompt';
          const expectedContent = 'Descripción generada';
          final mockLlmRemote = LlmRemote(
            choices: [Choice(message: Message(content: expectedContent))],
          );

          when(
            () => mockRepository.fetchLlmRemoteDescription(
              title: title,
              prompt: prompt,
            ),
          ).thenAnswer((_) async {
            await Future.delayed(const Duration(milliseconds: 100));
            return mockLlmRemote;
          });

          final controller = container.read(
            llmRemoteDescriptionControllerProvider.notifier,
          );

          bool wasLoading = false;
          final sub = container.listen(llmRemoteDescriptionControllerProvider, (
            prev,
            next,
          ) {
            if (next is AsyncLoading<String?>) {
              wasLoading = true;
            }
          }, fireImmediately: true);

          await controller.fetchLlmRemoteDescription(
            title: title,
            prompt: prompt,
          );

          expect(wasLoading, isTrue, reason: 'El estado nunca fue loading');

          final finalState = container.read(
            llmRemoteDescriptionControllerProvider,
          );
          expect(finalState.hasValue, isTrue);
          expect(finalState.value, equals(expectedContent));

          sub.close();
        },
      );
    });

    group('build', () {
      test('debe retornar null como estado inicial', () async {
        final initialState = container.read(
          llmRemoteDescriptionControllerProvider,
        );
        expect(
          initialState is AsyncLoading<String?> ||
              (initialState is AsyncData<String?> &&
                  initialState.value == null),
          isTrue,
          reason: 'El estado inicial debe ser loading o data(null)',
        );
      });
    });
  });
}
