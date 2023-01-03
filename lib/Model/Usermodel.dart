class Usermodel {
  String? viewAccess;
  String? fullAccess;
  String? opUserId;
  String? userName;
  String? email;
  String? contactNo;
  String? address;
  String? mapWith;
  String? mapWithId;
  String? addedOn;
  String? status;
  String? msg;

  Usermodel(
      {this.viewAccess,
      this.fullAccess,
      this.opUserId,
      this.userName,
      this.email,
      this.contactNo,
      this.address,
      this.mapWith,
      this.mapWithId,
      this.addedOn,
      this.status,
      this.msg});

  Usermodel.fromJson(Map<String, dynamic> json) {
    viewAccess = json['view_access'];
    fullAccess = json['full_access'];
    opUserId = json['op_user_id'];
    userName = json['user_name'];
    email = json['email'];
    contactNo = json['contact_no'];
    address = json['address'];
    mapWith = json['map_with'];
    mapWithId = json['map_with_id'];
    addedOn = json['added_on'];
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['view_access'] = this.viewAccess;
    data['full_access'] = this.fullAccess;
    data['op_user_id'] = this.opUserId;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['address'] = this.address;
    data['map_with'] = this.mapWith;
    data['map_with_id'] = this.mapWithId;
    data['added_on'] = this.addedOn;
    data['status'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}
