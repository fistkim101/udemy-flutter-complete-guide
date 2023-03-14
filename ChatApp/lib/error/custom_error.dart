class CustomError {
  final int httpStatusCode;
  final String message;

  const CustomError({
    required this.httpStatusCode,
    required this.message,
  });

  @override
  String toString() {
    return 'CustomError{code: ${httpStatusCode.toString()}, message: $message}';
  }
}
