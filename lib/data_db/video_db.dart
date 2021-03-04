class VideoDB {
  int id;
  int idWord;
  String language;
  String url;

  VideoDB(this.language, this.url);

  VideoDB.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.idWord = json['idWord'],
        language = json['language'],
        url = json['url'];

  Map<String, dynamic> toJson() => {'language': this.language, 'url': this.url};
}
