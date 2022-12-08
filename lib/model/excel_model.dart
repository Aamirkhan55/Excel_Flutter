class ModelItem {
  String id;
  String name;
  String phone;
  String gender;


  ModelItem(
      {required this.id,
      required this.name,
      required this.phone,
      required this.gender,
      });

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phone": phone,
        "gender": gender,
      };
}
