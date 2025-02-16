class Report{
  final String title;
  final List<String> description;
  final List<String> contact;
  final List<String> criteriaList;
  final String? center;
  final String? chat;

  Report({
    required this.title,
    required this.description,
    required this.contact,
    required this.criteriaList,
    this.center,
    this.chat,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      title: json['title'],
      description: List<String>.from(json['description']),
      contact: List<String>.from(json['contact']),
      criteriaList: List<String>.from(json['criteriaList']),
      center: json.containsKey('center') ? json['center'] : null,
      chat: json.containsKey('chat') ? json['chat'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'contact': contact,
      'criteriaList': criteriaList,
    };
    if (center != null) {
      data['center'] = center;
    }
    if (chat != null) {
      data['chat'] = chat;
    }

    return data;
  }
}