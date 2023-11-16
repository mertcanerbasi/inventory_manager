String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return "${text.substring(0, maxLength - 3)}..."; // Metni belirli bir uzunluğa kadar kısaltır
  }
}
