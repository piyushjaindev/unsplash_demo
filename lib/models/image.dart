class UnsplashImage {
  String id;
  String description;
  String url;

  UnsplashImage({this.id, this.description, this.url});

  factory UnsplashImage.fromJSON(json) {
    return UnsplashImage(
        id: json['id'],
        description: json['description'] ?? 'A image',
        url: json['urls']['small']);
  }
}
