class Messages {
  Messages({
    required this.fromId,
    required this.msg,
    required this.toId,
    required this.type,
    required this.read,
    required this.sent,
  });
  late final String fromId;
  late final String msg;
  late final String toId;
  late final Type type;
  late final String read;
  late final String sent;

  Messages.fromJson(Map<String, dynamic> json){
    fromId = json['fromId'].toString();
    msg = json['msg'].toString();
    toId = json['toId'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    read = json['read'].toString();
    sent = json['sent'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromId'] = fromId;
    data['msg'] = msg;
    data['toId'] = toId;
    data['type'] = type.name;
    data['read'] = read;
    data['sent'] = sent;
    return data;
  }
}
enum Type{ text, image}