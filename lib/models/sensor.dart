class Sensor {
  final int id;
  final String sensorSuhu;
  final String sensorKelembaban;
  final String sensorLdr;
  final String sensorTds;
  final String sensorWaterflow;
  final String sensorVolume;
  final String perangkatId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Sensor({
    required this.id,
    required this.sensorSuhu,
    required this.sensorKelembaban,
    required this.sensorLdr,
    required this.sensorTds,
    required this.sensorWaterflow,
    required this.sensorVolume,
    required this.perangkatId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      id: json['id'],
      sensorSuhu: json['sensor_suhu'],
      sensorKelembaban: json['sensor_kelembaban'],
      sensorLdr: json['sensor_ldr'],
      sensorTds: json['sensor_tds'],
      sensorWaterflow: json['sensor_waterflow'],
      sensorVolume: json['sensor_volume'],
      perangkatId: json['perangkat_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
