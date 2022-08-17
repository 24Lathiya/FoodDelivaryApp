class ResponseModel {
  bool? _isSuccess;
  String? _message;

  ResponseModel(
    this._isSuccess,
    this._message,
  );

  get isSuccess => _isSuccess;
  get message => _message;

  /*ResponseModel.fromJson(Map<String, dynamic> json) {
    _isSuccess = json["success"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();
    json['success'] = _isSuccess;
    json['message'] = _message;
    return json;
  }*/
}
