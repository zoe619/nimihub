import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:nimihub_online/models/failure_model.dart';
import 'package:nimihub_online/models/subTopics.dart';
import 'package:nimihub_online/service/notes/base_note_repository.dart';


final dioProvider = Provider<Dio>((ref) => Dio());

final notesRepositoryProvider =
Provider<NotesRepository>((ref) => NotesRepository(ref.read));

class NotesRepository extends BaseNotesRepository
{
  final Reader _read;

  NotesRepository(this._read);

  String url = "https://fetch.nimihub.com/dele/api/services/sub-topics.php";

  @override
  Future<List<SubTopic>> getNotes({
    @required int topicId
  })
  async {
    try {
      final queryParameters = {
        '_id': topicId,
        '_row':'topic',
        'table':'subtopic'

      };


      final response = await _read(dioProvider).get(
          url,
          queryParameters: queryParameters
      );

      if (response.statusCode == 200)
      {

        final results = json.decode(response.data);

        if(results.isNotEmpty)
        {
          return results.map<SubTopic>((e) => SubTopic.fromJson(e)).toList();
        }
      }
      return [];
    } on DioError catch (err)
    {
      throw Failure(
        message: err.response?.statusMessage ?? 'Something went wrong!',
      );

    } on SocketException catch (err) {
      print(err);
      throw const Failure(message: 'Please check your connection.');
    }
  }
}
