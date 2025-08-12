import 'package:dictionary/data/data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseState{}

class IntialState extends BaseState{}

class SuccessState extends BaseState{
  final String word;
  final String meaning;
  final String example;
  SuccessState(this.word, this.meaning, this.example);
}

class LoadingState extends BaseState{}

class FailureState extends BaseState {
  final String errorMessage;

  FailureState(this.errorMessage);
}

class DictionaryCubit extends Cubit<BaseState>{
  final DataSource dataSource = DataSource();
  DictionaryCubit() : super(IntialState());
  List<SuccessState> favorites= [];

  Future<void> search(String word) async{

    emit(LoadingState());
    try {
      final data = await dataSource.search(word);
      final meaning = data["meanings"][0]["definitions"][0]["definition"] ??
          "No meaning found";
      final example = data["meanings"][0]["definitions"][0]["example"] ??
          "No example available.";
      emit(SuccessState(word, meaning, example));
    } catch (e) {
      emit(FailureState("Word not found or error occurred."));
    }
  }
  void addToFavorites(SuccessState wordData) {
    if (!favorites.contains(wordData)) {
      favorites.add(wordData);
    }
  }

  void removeFromFavorites(SuccessState wordData) {
    favorites.remove(wordData);
    emit(IntialState());
  }
}
