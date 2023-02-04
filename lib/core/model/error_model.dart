class ErrorModel {
  List<Errors>? errors;
  bool? isPrimary;

  ErrorModel({this.errors, this.isPrimary});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['isPrimary'] = isPrimary;
    return data;
  }
}

class Errors {
  String? localizedMessage;
  String? message;
  String? status;
  String? errorDescription;
  String? errorType;
  String? errorMessage;
  String? errorCode;

  Errors(
      {this.localizedMessage,
        this.message,
        this.status,
        this.errorDescription,
        this.errorType,
        this.errorMessage,
        this.errorCode});

  Errors.fromJson(Map<String, dynamic> json) {
    localizedMessage = json['localizedMessage'];
    message = json['message'];
    status = json['status'];
    errorDescription = json['errorDescription'];
    errorType = json['errorType'];
    errorMessage = json['errorMessage'];
    errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['localizedMessage'] = localizedMessage;
    data['message'] = message;
    data['status'] = status;
    data['errorDescription'] = errorDescription;
    data['errorType'] = errorType;
    data['errorMessage'] = errorMessage;
    data['errorCode'] = errorCode;
    return data;
  }
}