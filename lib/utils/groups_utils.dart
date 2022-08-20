class GroupsUtils {
  static List<String> getSuggestions(
      String query, List<String> groups, List<String> teachers) {
    List<String> matches = [];
    matches.addAll(groups);
    matches.addAll(teachers);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
