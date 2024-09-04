class History {
  History({
    this.idHistory,
    this.idUser,
    this.type,
    this.date,
    this.total,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  String? idHistory;
  String? idUser;
  String? type;
  String? date;
  String? total;
  String? details;
  String? createdAt;
  String? updatedAt;

  factory History.fromjson(Map<String, dynamic> json) => History(
      idHistory: json["id_history"],
      idUser: json["id_user"],
      type: json["type"], 
      date: json["date"],
      total: json["total"],
      details: json["details"],
      createdAt: json["created_At"],
      updatedAt: json["updated_At"]);

  Map<String, dynamic> toJson() => {
        "id_history": idHistory,
        "id_user": idUser,
        "type": type,
        "date": date,
        "total": total,
        "details": details,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  static fromJson(e) {}
}
