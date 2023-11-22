import 'dart:convert';

class UserModel {
  final String uid;
  final String displayName;
  final String token;

  UserModel({
    this.uid = '',
    this.displayName = '',
    this.token = '', 
  });
  

  UserModel copyWith({
    String? uid,
    String? displayName,
    String? token,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      displayName: map['displayName'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(uid: $uid, displayName: $displayName, token: $token)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.displayName == displayName &&
      other.token == token;
  }

  @override
  int get hashCode => uid.hashCode ^ displayName.hashCode ^ token.hashCode;
}
