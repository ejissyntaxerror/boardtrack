class Failure {
  final String message;

  Failure(this.message);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Failure &&
            runtimeType == other.runtimeType &&
            message == other.message;
  }

  @override
  int get hashCode => message.hashCode;
}
