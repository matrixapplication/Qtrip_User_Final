
import 'package:equatable/equatable.dart';

class PaginationEntity  extends Equatable{

  final int _currentPage;
  final int _lastPage;
  final int _perPage;
  final int _total;
  final bool _hasMorePages;

  @override
  List<Object> get props => [_currentPage,_lastPage,_perPage,_total, _hasMorePages];

  const PaginationEntity({
    required int currentPage,
    required int lastPage,
    required int perPage,
    required int total,
    required bool hasMorePages,
  })  : _currentPage = currentPage,
        _lastPage = lastPage,
        _perPage = perPage,
        _total = total,
        _hasMorePages = hasMorePages;

  bool get hasMorePages => _hasMorePages;
  int get total => _total;
  int get perPage => _perPage;
  int get lastPage => _lastPage;
  int get currentPage => _currentPage;
}
