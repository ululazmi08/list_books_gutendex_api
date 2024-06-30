class ListBookModel {
  ListBookModel({
    required this.id,
    required this.title,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });
  late final int id;
  late final String title;
  late final List<Authors> authors;
  late final List<Authors> translators;
  late final List<String> subjects;
  late final List<String> bookshelves;
  late final List<String> languages;
  late final bool copyright;
  late final String mediaType;
  late final Formats formats;
  late final int downloadCount;

  ListBookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authors =
        List.from(json['authors']).map((e) => Authors.fromJson(e)).toList();
    translators =
        List.from(json['translators']).map((e) => Authors.fromJson(e)).toList();
    subjects = List.castFrom<dynamic, String>(json['subjects']);
    bookshelves = List.castFrom<dynamic, String>(json['bookshelves']);
    languages = List.castFrom<dynamic, String>(json['languages']);
    copyright = json['copyright'];
    mediaType = json['media_type'];
    formats = Formats.fromJson(json['formats']);
    downloadCount = json['download_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['authors'] = authors.map((e) => e.toJson()).toList();
    _data['translators'] = translators.map((e) => e.toJson()).toList();
    _data['subjects'] = subjects;
    _data['bookshelves'] = bookshelves;
    _data['languages'] = languages;
    _data['copyright'] = copyright;
    _data['media_type'] = mediaType;
    _data['formats'] = formats.toJson();
    _data['download_count'] = downloadCount;
    return _data;
  }
}

class Authors {
  Authors({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });
  late final String name;
  late final int birthYear;
  late final int deathYear;

  Authors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    birthYear = json['birth_year'] ?? 0;
    deathYear = json['death_year'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['birth_year'] = birthYear;
    _data['death_year'] = deathYear;
    return _data;
  }
}

class Formats {
  Formats({
    this.html,
    this.epub,
    this.mobipocket,
    this.image,
  });
  late final String? html;
  late final String? epub;
  late final String? mobipocket;
  late final String? image;

  Formats.fromJson(Map<String, dynamic> json) {
    html = json.containsKey('text/html') ? json['text/html'] : null;
    epub = json.containsKey('application/epub+zip')
        ? json['application/epub+zip']
        : null;
    mobipocket = json.containsKey('application/x-mobipocket-ebook')
        ? json['application/x-mobipocket-ebook']
        : null;
    image = json.containsKey('image/jpeg') ? json['image/jpeg'] : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    if (html != null) {
      _data['text/html'] = html;
    }
    if (epub != null) {
      _data['application/epub+zip'] = epub;
    }
    if (mobipocket != null) {
      _data['application/x-mobipocket-ebook'] = mobipocket;
    }
    if (image != null) {
      _data['image/jpeg'] = image;
    }
    return _data;
  }
}
