class VisitorModel {

  int id = 0;
  String societyId = '',
  entryDate = '',
  type = '',
  name = '',
  mobile = '',
  address = '',
  latitude = '',
  longitude = '',
  floorNo = '',
  unitNo = '',
  inTime = '',
  image = '',
  societyName = ''
  ;

  VisitorModel(
      this.id,
      this.societyId,
      this.entryDate,
      this.type,
      this.name,
      this.mobile,
      this.address,
      this.latitude,
      this.longitude,
      this.floorNo,
      this.unitNo,
      this.inTime,
      this.image,
      this.societyName,
      );

  VisitorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    societyId = json['society_id'] ?? "";
    entryDate = json['entry_date'] ?? "";
    type = json['type'] ?? "";
    name = json['name'] ?? '';
    mobile = json['mobile'] ?? '';
    address = json['address'] ?? '';
    latitude = json['latitude'] ?? '';
    longitude = json['longitude'] ?? '';
    floorNo = json['floor_no'] ?? '';
    unitNo = json['unit_no'] ?? '';
    inTime = json['in_time'] ?? '';
    image = json['image'] ?? '';
    societyName = json['society_name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['society_id'] = societyId;
    data['entry_date'] = entryDate;
    data['type'] = type;
    data['name'] = name;
    data['mobile'] = mobile;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['floor_no'] = floorNo;
    data['unit_no'] = unitNo;
    data['in_time'] = inTime;
    data['image'] = image;
    data['society_name'] = societyName;
    return data;
  }
}