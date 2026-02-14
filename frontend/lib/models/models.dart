class User {
  final int id;
  final String phone;
  final String username;
  final String? profilePic;
  final String? status;
  final DateTime? lastSeen;
  final bool isOnline;
  final DateTime createdAt;

  User({
    required this.id,
    required this.phone,
    required this.username,
    this.profilePic,
    this.status,
    this.lastSeen,
    required this.isOnline,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phone: json['phone'],
      username: json['username'],
      profilePic: json['profile_pic'],
      status: json['status'],
      lastSeen: json['last_seen'] != null ? DateTime.parse(json['last_seen']) : null,
      isOnline: json['is_online'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'username': username,
      'profile_pic': profilePic,
      'status': status,
      'last_seen': lastSeen?.toIso8601String(),
      'is_online': isOnline,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class Chat {
  final int id;
  final String type;
  final int? user1Id;
  final int? user2Id;
  final int? groupId;
  final Message? lastMessage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Chat({
    required this.id,
    required this.type,
    this.user1Id,
    this.user2Id,
    this.groupId,
    this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      type: json['type'],
      user1Id: json['user1_id'],
      user2Id: json['user2_id'],
      groupId: json['group_id'],
      lastMessage: json['last_message'] != null 
          ? Message.fromJson(json['last_message'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Message {
  final int id;
  final int chatId;
  final int senderId;
  final User? sender;
  final String type;
  final String? content;
  final String? mediaUrl;
  final String status;
  final int? replyToId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    this.sender,
    required this.type,
    this.content,
    this.mediaUrl,
    required this.status,
    this.replyToId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      chatId: json['chat_id'],
      senderId: json['sender_id'],
      sender: json['sender'] != null ? User.fromJson(json['sender']) : null,
      type: json['type'],
      content: json['content'],
      mediaUrl: json['media_url'],
      status: json['status'] ?? 'sent',
      replyToId: json['reply_to_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'sender_id': senderId,
      'type': type,
      'content': content,
      'media_url': mediaUrl,
      'status': status,
      'reply_to_id': replyToId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Group {
  final int id;
  final String name;
  final String? icon;
  final String? description;
  final int createdById;
  final User? createdBy;
  final List<GroupMember>? members;
  final DateTime createdAt;
  final DateTime updatedAt;

  Group({
    required this.id,
    required this.name,
    this.icon,
    this.description,
    required this.createdById,
    this.createdBy,
    this.members,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      description: json['description'],
      createdById: json['created_by_id'],
      createdBy: json['created_by'] != null ? User.fromJson(json['created_by']) : null,
      members: json['members'] != null
          ? (json['members'] as List).map((m) => GroupMember.fromJson(m)).toList()
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class GroupMember {
  final int id;
  final int groupId;
  final int userId;
  final User? user;
  final String role;
  final DateTime joinedAt;

  GroupMember({
    required this.id,
    required this.groupId,
    required this.userId,
    this.user,
    required this.role,
    required this.joinedAt,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
      id: json['id'],
      groupId: json['group_id'],
      userId: json['user_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      role: json['role'],
      joinedAt: DateTime.parse(json['joined_at']),
    );
  }
}

class Event {
  final int id;
  final int userId;
  final String title;
  final String? description;
  final DateTime eventDate;
  final String? location;
  final int? sourceMessageId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.eventDate,
    this.location,
    this.sourceMessageId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      eventDate: DateTime.parse(json['event_date']),
      location: json['location'],
      sourceMessageId: json['source_message_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
