class BaseModel<E> {
  bool? status;
  bool? statusCode;

  String code;
  dynamic message;
  E? responseData;
  E? item;
  E? url;
  Map<String, dynamic> response;

  BaseModel({ this.status,required this.statusCode,required this.code,required  this.message,required  this.response,this.item, this.responseData/*, this.response*/,this.url});

 factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
     statusCode: ((json['code']??'200').toString() == '200')||((json['code']??'201').toString() == '201'),
      code: (json['code']??'200').toString(),
      message: json['message']??"Error",
      responseData: json['data'],
     url: json['url'],
      response: json,
   item: json['item']
      // response: json['item']?['data']
 );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    data['url'] = url;
    data['code'] = code;
    data['data'] = responseData??{};
    return data;
  }
}
