class Picture {
  final String title;
  final String date;
  final String explanation;
  final String url;
  final String hdUrl;
  final String? copyright;  

  Picture({
    required this.title,
    required this.date,
    required this.explanation,
    required this.url,
    required this.hdUrl,
    this.copyright,  
  });


  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      title: json['title'],
      date: json['date'],
      explanation: json['explanation'],
      url: json['url'],
      hdUrl: json['hdurl'],
      copyright: json['copyright'],  
    );
  }
}