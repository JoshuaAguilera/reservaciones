class Estadistica {
  String? title;
  int numNow;
  int numInitial;
  int? total;

  Estadistica({
    this.title,
    this.numNow = 0,
    this.numInitial = 0,
    this.total,
  });

  String getStatusModifier() {
    if (numNow > numInitial) {
      return "Incrementó del mes";
    } else if (numNow < numInitial) {
      return "Decrementó del mes";
    } else {
      return "Sin cambios";
    }
  }

  int? difference() {
    if (numInitial == 0) return null;
    return (numNow - numInitial).abs();
  }
}

class Metrica {
  String? title;
  String? description;
  double value;
  double? initValue;
  bool isPorcentage;

  Metrica({
    this.description,
    this.title,
    this.initValue,
    this.isPorcentage = false,
    this.value = 0,
  });
}
