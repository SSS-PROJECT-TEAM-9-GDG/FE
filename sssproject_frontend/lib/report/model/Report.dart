class Report{
  final String title;
  final List<String> description;
  final List<String> contact;
  final List<String> criteriaList;
  final String center;

  Report({
    required this.title,
    required this.description,
    required this.contact,
    required this.criteriaList,
    required this.center,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      title: json['title'],
      description: List<String>.from(json['description']),
      contact: List<String>.from(json['contact']),
      criteriaList: List<String>.from(json['criteriaList']),
      center: json['center'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'contact': contact,
      'criteriaList': criteriaList,
      'center' : center
    };
    return data;
  }
}