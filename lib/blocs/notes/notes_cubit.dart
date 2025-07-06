import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/note_model.dart';
import '../../repositories/notes_repository.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository _notesRepository;
  final String userId;
  StreamSubscription<List<Note>>? _notesSubscription;

  NotesCubit(this._notesRepository, this.userId) : super(NotesInitial()) {
    fetchNotes();
  }

  void fetchNotes() {
    emit(NotesLoading());
    
    // Cancel any existing subscription
    _notesSubscription?.cancel();
    
    _notesSubscription = _notesRepository.getNotes(userId).listen(
      (notes) {
        if (!isClosed) {
          emit(NotesLoaded(notes));
        }
      },
      onError: (error) {
        if (!isClosed) {
          emit(NotesError("Failed to load notes: $error"));
        }
      },
    );
  }

  Future<void> addNote(Note note) async {
    try {
      await _notesRepository.addNote(note);
      // No need to emit state here - the stream will automatically update
    } catch (e) {
      if (!isClosed) {
        emit(NotesError("Failed to add note: ${e.toString()}"));
      }
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await _notesRepository.updateNote(note);
      // No need to emit state here - the stream will automatically update
    } catch (e) {
      if (!isClosed) {
        emit(NotesError("Failed to update note: ${e.toString()}"));
      }
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _notesRepository.deleteNote(noteId);
      // No need to emit state here - the stream will automatically update
    } catch (e) {
      if (!isClosed) {
        emit(NotesError("Failed to delete note: ${e.toString()}"));
      }
    }
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}