class SectionDB {
  int id;
  int idSubject;
  String sectionName;

  SectionDB({this.id, this.idSubject, this.sectionName});

  SectionDB.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.idSubject = json['idSubject'],
        this.sectionName = json['section_name'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'idSubject': this.idSubject,
        'section_name': this.sectionName
      };
}
