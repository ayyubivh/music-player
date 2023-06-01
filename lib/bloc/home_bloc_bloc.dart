import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_tes/bloc/home_bloc_event.dart';
import 'package:music_player_tes/bloc/home_bloc_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<String> audioFiles;
  final List<AudioPlayer> players;

  HomeBloc(this.audioFiles, this.players)
      : super(HomeState(List.filled(audioFiles.length, false)));

  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is PlayAudioEvent) {
      await players[event.index].setAsset(event.audioFile);
      await players[event.index].play();
      List<bool> updatedIsAudioPlaying = List.from(state.isAudioPlaying);
      updatedIsAudioPlaying[event.index] = true;
      yield HomeState(updatedIsAudioPlaying);
    } else if (event is PauseAudioEvent) {
      await players[event.index].pause();
      List<bool> updatedIsAudioPlaying = List.from(state.isAudioPlaying);
      updatedIsAudioPlaying[event.index] = false;
      yield HomeState(updatedIsAudioPlaying);
    }
  }
}
