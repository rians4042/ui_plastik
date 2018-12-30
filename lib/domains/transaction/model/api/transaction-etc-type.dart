class TransactionEtcTypeAPI {
  String id;
  String name;
  String createdAt;

  TransactionEtcTypeAPI({
    this.id,
    this.name,
    this.createdAt,
  });

  static TransactionEtcTypeAPI fromJSON(Map<String, dynamic> json) {
    return TransactionEtcTypeAPI(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
    );
  }

  static List<TransactionEtcTypeAPI> fromListJSON(
      List<Map<String, dynamic>> jsons) {
    List<TransactionEtcTypeAPI> results = [];
    jsons.forEach(
      (json) => results.add(
            TransactionEtcTypeAPI(
              id: json['id'],
              name: json['name'],
              createdAt: json['createdAt'],
            ),
          ),
    );

    return results;
  }
}
