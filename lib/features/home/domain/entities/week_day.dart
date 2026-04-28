class WeekDay {
  final String name;
  final int date;
  final bool isActive;
  final bool isCompleted;

  const WeekDay({
    required this.name,
    required this.date,
    this.isActive = false,
    this.isCompleted = false,
  });
}
