import 'package:rutgers_flutter_mapbox_app/keys.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Repository {
  Repository() {
    IO.io(BUS_SERVER_URL)
      ..connect()
      ..on('connect', (dynamic data) {
        print('connect\n\t\t$data');
      })
      ..on('data', (dynamic data) {
        print('data\n\t\t$data');
      })
      ..on('connect_error', (dynamic data) {
        print('connect_error\n\t\t$data');
      })
      ..on('connect_timeout', (dynamic data) {
        print('connect_timeout\n\t\t$data');
      })
      ..on('connecting', (dynamic data) {
        print('connecting\n\t\t$data');
      })
      ..on('disconnect', (dynamic data) {
        print('disconnect\n\t\t$data');
      })
      ..on('error', (dynamic data) {
        print('error\n\t\t$data');
      })
      ..on('reconnect', (dynamic data) {
        print('reconnect\n\t\t$data');
      })
      ..on('reconnect_attempt', (dynamic data) {
        print('reconnect_attempt\n\t\t$data');
      })
      ..on('reconnect_failed', (dynamic data) {
        print('reconnect_failed\n\t\t$data');
      })
      ..on('reconnect_error', (dynamic data) {
        print('reconnect_error\n\t\t$data');
      })
      ..on('reconnecting', (dynamic data) {
        print('reconnecting\n\t\t$data');
      })
      ..on('ping', (dynamic data) {
        print('ping\n\t\t$data');
      })
      ..on('pong', (dynamic data) {
        print('pong\n\t\t$data');
      });
  }
}
