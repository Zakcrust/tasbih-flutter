class ListDzikir {
  List<Dzikir> dzikir = [];

  ListDzikir({required this.dzikir});

  ListDzikir.fromJson(Map<String, dynamic> json) {
    if (json['dzikir'] != null) {
      dzikir = <Dzikir>[];
      json['dzikir'].forEach((v) {
        dzikir.add(Dzikir.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dzikir'] = dzikir.map((v) => v.toJson()).toList();
    return data;
  }
}

class Dzikir {
  late String name;
  late int count;

  Dzikir({required this.name, required this.count});

  Dzikir.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['count'] = count;
    return data;
  }
}
