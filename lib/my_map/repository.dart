import 'package:rutgers_flutter_mapbox_app/keys.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Repository {
  Repository() {
    IO.io(BUS_SERVER_URL)
      ..connect()
      ..on('connect', (dynamic data) {
        print(data);
      })
      ..on('connect', (dynamic data) {
        print(data);
      })
      ..on('connect_error', (dynamic data) {
        print(data);
      })
      ..on('connect_timeout', (dynamic data) {
        print(data);
      })
      ..on('connecting', (dynamic data) {
        print(data);
      })
      ..on('disconnect', (dynamic data) {
        print(data);
      })
      ..on('error', (dynamic data) {
        print(data);
      })
      ..on('reconnect', (dynamic data) {
        print(data);
      })
      ..on('reconnect_attempt', (dynamic data) {
        print(data);
      })
      ..on('reconnect_failed', (dynamic data) {
        print(data);
      })
      ..on('reconnect_error', (dynamic data) {
        print(data);
      })
      ..on('reconnecting', (dynamic data) {
        print(data);
      })
      ..on('ping', (dynamic data) {
        print(data);
      })
      ..on('pong', (dynamic data) {
        print(data);
      });
  }
}
