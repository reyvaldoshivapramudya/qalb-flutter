class Doa {
  final int id;
  final String judul;
  final String latin;
  final String arab;
  final String terjemah;

  Doa({
    required this.id,
    required this.judul,
    required this.latin,
    required this.arab,
    required this.terjemah,
  });

  factory Doa.fromJson(Map<String, dynamic> json) {
    return Doa(
      id: json['id'] as int,
      judul: json['judul'] as String,
      latin: json['latin'] as String,
      arab: json['arab'] as String,
      terjemah: json['terjemah'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'latin': latin,
      'arab': arab,
      'terjemah': terjemah,
    };
  }
}