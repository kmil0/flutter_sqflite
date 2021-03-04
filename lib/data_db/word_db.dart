class WordDB {
  int id;
  int idSection;
  String word;
  // List<VideoDto> videos;

  WordDB(this.id, this.idSection, this.word);

  WordDB.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.idSection = json['idSection'],
        this.word = json['word'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'idSection': this.idSection,
        'word': this.word,
      };
}
