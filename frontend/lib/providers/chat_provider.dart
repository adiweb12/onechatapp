import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import '../utils/constants.dart';

class ChatProvider with ChangeNotifier {
  String? _token;
  List<Chat> _chats = [];
  Map<int, List<Message>> _messages = {};
  bool _isLoading = false;

  List<Chat> get chats => _chats;
  List<Message> getMessages(int chatId) => _messages[chatId] ?? [];
  bool get isLoading => _isLoading;

  void initialize(String? token) {
    _token = token;
    if (token != null) {
      fetchChats();
    }
  }

  Future<void> fetchChats() async {
    if (_token == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(ApiConstants.chats),
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _chats = (data['chats'] as List)
            .map((chat) => Chat.fromJson(chat))
            .toList();
      }
    } catch (e) {
      debugPrint('Error fetching chats: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMessages(int chatId) async {
    if (_token == null) return;

    try {
      final response = await http.get(
        Uri.parse(ApiConstants.chatMessages(chatId)),
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _messages[chatId] = (data['messages'] as List)
            .map((msg) => Message.fromJson(msg))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching messages: $e');
    }
  }

  Future<bool> sendMessage(int chatId, String type, String content, {String? mediaUrl}) async {
    if (_token == null) return false;

    try {
      final response = await http.post(
        Uri.parse(ApiConstants.sendMessage(chatId)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({
          'type': type,
          'content': content,
          'media_url': mediaUrl,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final message = Message.fromJson(data['message']);
        
        if (_messages[chatId] != null) {
          _messages[chatId]!.add(message);
        } else {
          _messages[chatId] = [message];
        }
        
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error sending message: $e');
      return false;
    }
  }

  void addMessage(Message message) {
    if (_messages[message.chatId] != null) {
      _messages[message.chatId]!.add(message);
    } else {
      _messages[message.chatId] = [message];
    }
    notifyListeners();
  }
}
