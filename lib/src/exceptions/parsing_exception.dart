class UnSupportedType implements Exception {
  UnSupportedType({
    this.errorMessage = 'Unsupported written value encountered.',
    this.userMessage = 'An error occurred. Please contact support.',
    this.hint =
        'Ensure the data type is a primitive type such as int, double, bool, String, BigInt, DateTime, Uint8List, or a collection (List, Set, Map) of these types. Primitive types are basic data types that are not composed of other data types and represent a single value.',
    StackTrace? stackTrace,
  }) : stackTrace = stackTrace ?? StackTrace.current;

  final String errorMessage;
  final String userMessage;
  final String hint;
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'UnSupportedType: $errorMessage\n'
        'Hint: $hint\n'
        'User Message: $userMessage\n'
        'StackTrace: $stackTrace';
  }
}
