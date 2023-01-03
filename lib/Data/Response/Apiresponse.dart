import 'package:indianavy_with_mvvmrestapi/Data/Response/Status.dart';

class Apiresponse<T> {
  Status? status;
  T? data;
  String? message;

  Apiresponse(this.status, this.data, this.message);

  Apiresponse.loading() : status = Status.LOADING;

  Apiresponse.completed(this.data) : status = Status.COMPLETED;

  Apiresponse.error(this.message) : status = Status.ERROR;
}
