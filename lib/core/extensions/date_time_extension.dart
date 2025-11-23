extension DataTimeFormatter on DateTime{
  String formateDateTime() {
    if (this == null) return "";
    final diff = DateTime.now().difference(DateTime.parse(this.toString()));
    if (diff.inMinutes < 60) return "${diff.inMinutes} m ago";
    if (diff.inHours < 24) return "${diff.inHours} h ago";
    return "${diff.inDays} d ago";
  }
}