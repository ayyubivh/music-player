abstract class HomeEvent {}

class PlayAudioEvent extends HomeEvent {
  final int index;
  final String audioFile;

  PlayAudioEvent(this.index, this.audioFile);
}

class PauseAudioEvent extends HomeEvent {
  final int index;

  PauseAudioEvent(this.index);
}
