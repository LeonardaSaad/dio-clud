class CepsBack4appModel {
  List<CepBack4appModel> cep = [];

  CepsBack4appModel(this.cep);

  CepsBack4appModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      cep = <CepBack4appModel>[];
      json['results'].forEach((v) {
        cep.add(CepBack4appModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['results'] = cep.map((v) => v.toJson()).toList();

    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['results'] = cep.map((v) => v.toJson()).toList();

    return data;
  }
}

class CepBack4appModel {
  String objectId = "";
  String cep = "";
  String createdAt = "";
  String updatedAt = "";

  CepBack4appModel(this.objectId, this.cep, this.createdAt, this.updatedAt);
  CepBack4appModel.criar(this.cep);

  CepBack4appModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    return data;
  }
}
