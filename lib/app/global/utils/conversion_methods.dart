class ConversionMethods {
  static String formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      final day = parsedDate.day.toString().padLeft(2, '0');
      final month = parsedDate.month.toString().padLeft(2, '0');
      final year = parsedDate.year;
      return '$day/$month/$year';
    } catch (_) {
      return '';
    }
  }
}
