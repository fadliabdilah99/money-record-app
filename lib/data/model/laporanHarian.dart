class LaporanHarian {
    LaporanHarian({
    this.tanggal,
    this.total_pemasuka,
    this.total_pengeluaran,
  });

  String? tanggal;
  String? total_pemasuka;
  String? total_pengeluaran;

  factory LaporanHarian.fromjson(Map<String, dynamic> json) => LaporanHarian(
        tanggal: json["tanggal"],
        total_pemasuka: json["total_pemasuka"],
        total_pengeluaran: json["total_pengeluaran"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "total_pemasuka": total_pemasuka,
        "total_pengeluaran": total_pengeluaran,
      };

  static fromJson(e) {}
}
