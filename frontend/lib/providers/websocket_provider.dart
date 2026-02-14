import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../utils/constants.dart';

class WebSocketProvider with ChangeNotifier {
  IO.Socket? _socket;
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  void initialize(String? token) {
    if (token == null) return;

    _socket = IO.io(
      ApiConstants.websocket(token),
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket!.connect();

    _socket!.onConnect((_) {
      _isConnected = true;
      notifyListeners();
      debugPrint('WebSocket connected');
    });

    _socket!.onDisconnect((_) {
      _isConnected = false;
      notifyListeners();
      debugPrint('WebSocket disconnected');
    });

    _socket!.on('new_message', (data) {
      // Handle incoming messages
      debugPrint('New message: $data');
    });

    _socket!.on('message_status', (data) {
      // Handle message status updates
      debugPrint('Message status: $data');
    });
  }

  void joinChatRoom(int chatId) {
    _socket?.emit('join_chat', {'chat_id': chatId});
  }

  void leaveChatRoom(int chatId) {
    _socket?.emit('leave_chat', {'chat_id': chatId});
  }

  void sendTyping(int chatId) {
    _socket?.emit('typing', {'chat_id': chatId});
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    _isConnected = false;
    notifyListeners();
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
