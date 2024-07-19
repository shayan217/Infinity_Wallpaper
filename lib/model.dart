class Wallpaper {
  final String id;
  final String photographer;
  final String src;

  Wallpaper({required this.id, required this.photographer, required this.src});

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id'].toString(),
      photographer: json['photographer'],
      src: json['src']['medium'],
    );
  }
}
