class SizeObject {
  String? id;
  String? value;

  SizeObject.name(this.id, this.value);


  SizeObject({this.id, this.value});

  factory SizeObject.fromJson(Map<String, dynamic> json) {
    return SizeObject(
        id: json["id"],
        value: json["value"],
    );
  }
}