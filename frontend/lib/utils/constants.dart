class ApiConstants {
  // Change this to your deployed backend URL
  static const String baseUrl = 'https://your-app.onrender.com';
  static const String wsUrl = 'wss://your-app.onrender.com';
  
  // Auth endpoints
  static const String register = '$baseUrl/api/v1/auth/register';
  static const String login = '$baseUrl/api/v1/auth/login';
  static const String refreshToken = '$baseUrl/api/v1/auth/refresh';
  
  // User endpoints
  static const String me = '$baseUrl/api/v1/users/me';
  static const String updateProfile = '$baseUrl/api/v1/users/me';
  static const String searchUsers = '$baseUrl/api/v1/users/search';
  
  // Chat endpoints
  static const String chats = '$baseUrl/api/v1/chats';
  static String chatMessages(int chatId) => '$baseUrl/api/v1/chats/$chatId/messages';
  static String sendMessage(int chatId) => '$baseUrl/api/v1/chats/$chatId/messages';
  static String updateMessageStatus(int messageId) => '$baseUrl/api/v1/chats/messages/$messageId/status';
  static String deleteMessage(int messageId) => '$baseUrl/api/v1/chats/messages/$messageId';
  
  // Group endpoints
  static const String groups = '$baseUrl/api/v1/groups';
  static String group(int groupId) => '$baseUrl/api/v1/groups/$groupId';
  static String addMember(int groupId) => '$baseUrl/api/v1/groups/$groupId/members';
  static String removeMember(int groupId, int userId) => '$baseUrl/api/v1/groups/$groupId/members/$userId';
  static String updateRole(int groupId, int userId) => '$baseUrl/api/v1/groups/$groupId/members/$userId/role';
  
  // AI endpoints
  static const String aiResearch = '$baseUrl/api/v1/ai/research';
  static const String extractEvent = '$baseUrl/api/v1/ai/extract-event';
  
  // Media endpoints
  static const String uploadMedia = '$baseUrl/api/v1/media/upload';
  
  // Event endpoints
  static const String events = '$baseUrl/api/v1/events';
  static String event(int eventId) => '$baseUrl/api/v1/events/$eventId';
  
  // WebSocket
  static String websocket(String token) => '$wsUrl/ws?token=$token';
}

class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userData = 'user_data';
  static const String isLoggedIn = 'is_logged_in';
}
