class Perangkat {
  final int id;
  final String nama;
  final String keterangan;
  final String greenhouseId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Perangkat({
    required this.id,
    required this.nama,
    required this.keterangan,
    required this.greenhouseId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Perangkat.fromJson(Map<String, dynamic> json) {
    return Perangkat(
      id: json['id'],
      nama: json['nama'],
      keterangan: json['keterangan'],
      greenhouseId: json['greenhouse_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
