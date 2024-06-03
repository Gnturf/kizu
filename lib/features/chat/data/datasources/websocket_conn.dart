// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class WebsocketConn {
//   final String ipAddress;
//   final String port;

//   const WebsocketConn({
//     required this.ipAddress,
//     required this.port,
//   });

//   void initConnect() {
//     final socket = IO.io("http://$ipAddress:$port", <String, dynamic>{
//       "transports": ["websocket"],
//       "autoConnect": false,
//     });

//     socket.connect();
//   }
// }
