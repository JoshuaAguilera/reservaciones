class PaginatedList {
  int pageIndex;
  int pageSize;

  PaginatedList({
    required this.pageIndex,
    required this.pageSize,
  });

  int totalPages(int totalItems) => (totalItems / pageSize).ceil();
  bool hasNextPage(int totalItems) => pageIndex < totalPages(totalItems) - 1;
  bool get hasPreviousPage => pageIndex > 0;
}

class Layout {
  static const String _checkList = "C";
  static String get checkList => _checkList;
  static const String _mosaico = "M";
  static String get mosaico => _mosaico;
  static const String _table = "T";
  static String get table => _table;
}

class OrderBy {
  static const String _alfabetico = "A";
  static String get alfabetico => _alfabetico;
  static const String _recientes = "MR";
  static String get recientes => _recientes;
  static const String _antiguo = "MA";
  static String get antiguo => _antiguo;
}

class Filter {
  String? layout;
  String? orderBy;
  String status;
  String? fate;

  Filter({
    this.layout,
    this.orderBy,
    this.status = '',
    this.fate,
  });

  Filter copyWith({
    String? layout,
    String? orderBy,
    String status = "",
    String? fate,
  }) {
    return Filter(
      layout: layout ?? this.layout,
      orderBy: orderBy ?? this.orderBy,
      status: status,
      fate: fate ?? this.fate,
    );
  }
}

class FilterUserManager {
  String? layout;
  String? orderByUser;
  String? orderByRole;
  String? orderByPermission;

  FilterUserManager({
    this.layout,
    this.orderByUser,
    this.orderByRole,
    this.orderByPermission,
  });

  FilterUserManager copyWith({
    String? layout,
    String? orderByUser,
    String? orderByRole,
    String? orderByPermission,
  }) {
    return FilterUserManager(
      layout: layout ?? this.layout,
      orderByPermission: orderByPermission ?? this.orderByPermission,
      orderByRole: orderByRole ?? this.orderByRole,
      orderByUser: orderByUser ?? this.orderByUser,
    );
  }
}
