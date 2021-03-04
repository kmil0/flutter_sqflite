class SubjectDB {
  int id;
  String unitName;

  SubjectDB({this.id, this.unitName});

  SubjectDB.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.unitName = json['unit_name'];

  Map<String, dynamic> toJson() => {'id': this.id, 'unit_name': this.unitName};
}
