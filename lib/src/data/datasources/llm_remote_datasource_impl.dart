import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../constants/string_constants.dart';
import '../../core/network/network_utility.dart';
import '../dtos/llm_remote_dto.dart';
import 'llm_remote_datasource.dart';

class LlmRemoteDatasourceImpl implements LlmRemoteDatasource {
  final String apiKey = dotenv.env['HUGGING_FACE_API_KEY']!;
  final String baseUrl = dotenv.env['HUGGING_FACE_BASE_URL']!;
  final NetworkUtility _networkUtility;

  LlmRemoteDatasourceImpl([NetworkUtility? networkUtility])
    : _networkUtility = networkUtility ?? NetworkUtility();

  Map<String, dynamic> _getPayload({
    required String title,
    required String prompt,
  }) => {
    "messages": [
      {"role": "user", "content": "$title\n$prompt"},
      {"role": "system", "content": StringConstants.llmRemoteDescriptionPrompt},
    ],
    "model": "moonshotai/Kimi-K2-Instruct:novita",
    "stream": false,
    "max_tokens": 250,
  };

  @override
  Future<LlmRemoteDto> fetchLlmResponse({
    required String title,
    required String prompt,
  }) async {
    final Uri uri = Uri.parse('$baseUrl/chat/completions');

    final Map<String, dynamic> payload = _getPayload(
      title: title,
      prompt: prompt,
    );

    final response = await _networkUtility.postJson(
      uri,
      headers: {'Authorization': 'Bearer $apiKey'},
      body: payload,
    );

    if (response.statusCode != 200) {
      throw Exception(
        '${StringConstants.errorFetchingData} ${response.statusCode}',
      );
    }

    return LlmRemoteDto.fromJson(json.decode(response.body));
  }

  void dispose() => _networkUtility.dispose();
}
