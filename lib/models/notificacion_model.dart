class Notificacion {
  int? id;
  String? title;
  String? content;
  String? level;
  int status;

  Notificacion({
    this.id,
    this.title,
    this.status = 0,
    this.content,
    this.level,
  });
}
