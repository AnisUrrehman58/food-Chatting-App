class ChatUser{
  ChatUser({
required this.image,
required this.about,
required this.name,
required this.createAt,
required this.isOnline,
required this.id,
required this.lastActive,
required this.email,
required this.pushToken,
});

  late final String image;
  late final String about;
  late final String name;
  late final String createAt;
  late final bool    isOnline;
  late final String id;
  late final String lastActive;
  late final String email;
  late final String pushToken;

  ChatUser.fromJson(Map<String,dynamic>json){
    image = json['image']?? '';
    about = json['about']?? '';
    name   = json['name']?? '';
    createAt= json['create_at']?? '';
    isOnline = json['is_online']?? '';
    id = json   ['id']?? '';
    lastActive = json['last_active']?? '';
    email = json['email']?? '';
    pushToken = json['push_token']?? '';

}
Map<String, dynamic>toJson(){
    final data = <String,dynamic>{};
    data ['image'] = image;
    data ['about'] = about;
    data ['name'] = name;
    data ['create_at'] = createAt;
    data ['is_online'] = isOnline;
    data ['id'] = id;
    data ['email'] = email;
    data ['push_token'] = pushToken;
    return data;
}

}