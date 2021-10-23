class Permis {
  final int id;
  int? reqUserID;
  int? trtUserID;
  String? status;
  String reqDate;
  String? trtmDate;
  String? attachements;
  String? motifStatus;
  String buildAdress;
  String buildType;
  int? communeId;
  String? deliveryDate;

  Permis(
      {  
      required this.id,
      this.reqUserID,
      this.trtUserID,
      this.status,
      required this.reqDate,
      required this.trtmDate,
      this.attachements,
      required this.motifStatus,
      required this.buildAdress,
      required this.buildType,
      required this.communeId,
      required this.deliveryDate,
      }
  );

  Permis.fromJson(Map<String, dynamic> json): 
      id = json['id'],
      reqDate = json['req_date'],
      status = json['status'],
      reqUserID = json['req_user_id'],
      trtmDate = json['trtm_date'] ,
      trtUserID = json['trtm_user_id'],
      attachements = json['attachements'],
      motifStatus = json['motif_status'],
      buildAdress = json['build_adress'],
      buildType = json['build_type'],
      deliveryDate = json['delivery_date'],
      communeId = json['commune_id'];

}
