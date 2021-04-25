class RequestTokenModel {
  final bool success;
  final String requestToken;
  final String expiresAt;

  RequestTokenModel({
    this.success,
    this.requestToken,
    this.expiresAt,
  });
//passing json model to the model
  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
      success: json['success'],
      requestToken: json['request_token'],
      expiresAt: json['expires_at'],
    );
  }
//sending request in second and third method
  Map<String, dynamic> toJson() => {
        'request_token': requestToken,
      };
}
