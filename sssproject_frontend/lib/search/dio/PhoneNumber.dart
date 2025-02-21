class PhoneNumber {
  final String number;
  final String spam;
  final String spamCount;
  final String cyberCrime;

  PhoneNumber({
    required this.number,
    required this.spam,
    required this.spamCount,
    required this.cyberCrime,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      number: json['number'],
      spam: json['spam'],
      spamCount: json['spam_count'],
      cyberCrime: json['cyber_crime']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'number': number,
      'spam': spam,
      'spam_count': spamCount,
      'cyber_crime': cyberCrime
    };
    return data;
  }
}