part of 'connection_cubit.dart';

class BlocConnectionState {
  final bool connected;

  BlocConnectionState({required this.connected});

  factory BlocConnectionState.initial() => BlocConnectionState(connected: false);

  BlocConnectionState copyWith({bool? connected}) {
    return BlocConnectionState(connected: connected ?? this.connected);
  }
}
