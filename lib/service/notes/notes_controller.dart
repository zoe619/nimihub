
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nimihub_online/service/notes/notes_state.dart';
import 'package:nimihub_online/service/quiz/quiz_state.dart';

final notesControllerProvider =
StateNotifierProvider.autoDispose<NotesController>(
      (ref) => NotesController(),
);

class NotesController extends StateNotifier<NotesState>
{
  NotesController() : super(NotesState.initial());



  void reset() {
    state = NotesState.initial();
  }
}
