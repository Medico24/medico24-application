import 'package:flutter/material.dart';
import 'package:medico24/core/theme/app_colors.dart';
import 'package:medico24/core/api/models/appointment_model.dart';

class AppointmentsCalendar extends StatefulWidget {
  const AppointmentsCalendar({required this.appointments, super.key});
  final List<AppointmentModel> appointments;

  @override
  State<AppointmentsCalendar> createState() => _AppointmentsCalendarState();
}

class _AppointmentsCalendarState extends State<AppointmentsCalendar> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;
  Map<DateTime, Color> _appointmentDates = {};

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _selectedDate = DateTime.now();
    _buildAppointmentDates();
  }

  @override
  void didUpdateWidget(AppointmentsCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.appointments != widget.appointments) {
      _buildAppointmentDates();
    }
  }

  void _buildAppointmentDates() {
    final Map<DateTime, Color> dates = {};

    for (final appointment in widget.appointments) {
      final date = DateTime(
        appointment.appointmentAt.year,
        appointment.appointmentAt.month,
        appointment.appointmentAt.day,
      );

      // Assign color based on appointment status
      Color color;
      switch (appointment.status) {
        case AppointmentStatus.scheduled:
          color = AppColors.blue;
          break;
        case AppointmentStatus.confirmed:
          color = const Color(0xFF4CAF50); // Green
          break;
        case AppointmentStatus.rescheduled:
          color = AppColors.yellow;
          break;
        case AppointmentStatus.cancelled:
          color = AppColors.grey;
          break;
        case AppointmentStatus.completed:
          color = AppColors.teal;
          break;
        case AppointmentStatus.noShow:
          color = AppColors.red;
          break;
      }

      dates[date] = color;
    }

    setState(() {
      _appointmentDates = dates;
    });
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  List<DateTime> _getDaysInMonth() {
    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    );

    final days = <DateTime>[];

    // Add empty days for the start of the month
    final firstWeekday = firstDayOfMonth.weekday;
    final startPadding = firstWeekday == 7 ? 0 : firstWeekday;

    for (int i = 0; i < startPadding; i++) {
      days.add(firstDayOfMonth.subtract(Duration(days: startPadding - i)));
    }

    // Add all days in the month
    for (int i = 0; i < lastDayOfMonth.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i + 1));
    }

    return days;
  }

  Color? _getDateColor(DateTime date) {
    for (final entry in _appointmentDates.entries) {
      if (entry.key.year == date.year &&
          entry.key.month == date.month &&
          entry.key.day == date.day) {
        return entry.value;
      }
    }
    return null;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isSelected(DateTime date) {
    return date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day;
  }

  bool _isCurrentMonth(DateTime date) {
    return date.month == _currentMonth.month;
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();

    return Column(
      children: [
        // Month and Year Selector
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          decoration: const BoxDecoration(color: AppColors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _previousMonth,
                icon: const Icon(Icons.chevron_left, color: AppColors.coal),
              ),
              Text(
                '${_getMonthName(_currentMonth.month)}, ${_currentMonth.year}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.coal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: _nextMonth,
                icon: const Icon(Icons.chevron_right, color: AppColors.coal),
              ),
            ],
          ),
        ),

        // Weekday Headers
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      day,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 20,
                      height: 2,
                      decoration: BoxDecoration(
                        color: AppColors.grey.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        // Calendar Grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final date = days[index];
              final isCurrentMonth = _isCurrentMonth(date);
              final isToday = _isToday(date);
              final isSelected = _isSelected(date);
              final appointmentColor = _getDateColor(date);

              return GestureDetector(
                onTap: () => _selectDate(date),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: appointmentColor?.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.red
                          : isToday
                          ? AppColors.blue
                          : Colors.transparent,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          '${date.day}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: !isCurrentMonth
                                    ? AppColors.grey.withValues(alpha: 0.4)
                                    : isSelected
                                    ? AppColors.red
                                    : isToday
                                    ? AppColors.blue
                                    : AppColors.coal,
                                fontWeight: isSelected || isToday
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                        ),
                      ),
                      if (appointmentColor != null)
                        Positioned(
                          bottom: 4,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: appointmentColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        // Selected Date Info
        if (_getDateColor(_selectedDate) != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getDateColor(_selectedDate)!.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _getDateColor(_selectedDate)!.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _getDateColor(_selectedDate),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appointment on ${_selectedDate.day} ${_getMonthName(_selectedDate.month)}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.coal,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'You have an appointment scheduled',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.event_available,
                  color: _getDateColor(_selectedDate),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
