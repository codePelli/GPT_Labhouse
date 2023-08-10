//https://platform.openai.com/docs/guides/gpt/function-calling

class Model{
  final String id;
  final int created;
  final String root;

  Model({
    required this.id,
    required this.root,
    required this.created,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    id: json["id"],
    root: json["root"],
    created: json["created"],
  );

  static List<Model> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => Model.fromJson(data)).toList();
  }
}

class ModelChat{
  final String msg;
  final int chatIndex;

  ModelChat({required this.msg, required this.chatIndex});

  factory ModelChat.fromJson(Map<String, dynamic> json) => ModelChat(
    msg: json["msg"],
    chatIndex: json["chatIndex"],
  );
}
