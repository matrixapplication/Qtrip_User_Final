

class ContactUsRequestsBody {
final String _name;
final String _phone;
final String _email;
final String _message;


  Map<String, dynamic> toJson() {
    return {
      "name": _name,
      "mobile": _phone,
      "email": _email,
      "message": _message ,
    };
  }

const ContactUsRequestsBody({
    required String name,
    required String phone,
    required String email,
    required String message,
  })  : _name = name,
      _phone = phone,
        _email = email,
        _message = message;
}
