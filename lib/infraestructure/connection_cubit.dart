import 'package:covid19_data_explorer/services/lg_connection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connection_state.dart';

class ConnectionCubit extends Cubit<BlocConnectionState> {
  ConnectionCubit(super.initialState);

  Future<void> checkConnection() async {
    final isConnected = await LGConnection().checkConnection();

    final newState = state.copyWith(connected: isConnected);

    emit(newState);
  }
}