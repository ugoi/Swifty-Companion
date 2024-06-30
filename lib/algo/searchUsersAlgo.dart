import 'dart:math';

import 'package:swifty_companion/dtos/search_user_dto.dart';

class SearchUsersAlgo {
  Future<List<SearchUserDto>> searchUsers(
      String query, List<SearchUserDto> searchUserDtos) async {
    searchUserDtos = searchUserDtos
        .where((e) =>
            (_containsQuery(query, e.login)) ||
            (_containsQuery(query, e.displayname)))
        .toList();

    searchUserDtos.sort((a, b) {
      int indexA1 = a.login.toLowerCase().indexOf(query);
      int indexA2 = a.displayname.toLowerCase().indexOf(query);
      int indexA = [indexA1, indexA2].where((i) => i >= 0).reduce(min);

      int indexB1 = b.login.toLowerCase().indexOf(query);
      int indexB2 = b.displayname.toLowerCase().indexOf(query);
      int indexB = [indexB1, indexB2].where((i) => i >= 0).reduce(min);

      if (indexA == -1 && indexB == -1) {
        return 0;
      } else if (indexA == -1) {
        return 1;
      } else if (indexB == -1) {
        return -1;
      } else {
        return indexA.compareTo(indexB);
      }
    });

    return searchUserDtos;
  }

  bool _containsQuery(String query, String? other) {
    return other?.toLowerCase().contains(query.toLowerCase()) ?? false;
  }
}
