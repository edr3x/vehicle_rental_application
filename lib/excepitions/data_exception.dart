class DataException implements Exception {
  String message;
  DataException([this.message = 'Something went wrong']) {
    message = 'Fetching Data Exception: $message';
  }

  @override
  String toString() => message;
}
