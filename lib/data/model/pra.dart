class Data<T>{
  final T _myData;

  const Data({
    required T myData,
  }) : _myData = myData;

  T get myData => _myData;
}