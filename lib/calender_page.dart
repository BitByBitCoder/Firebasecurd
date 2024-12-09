import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  // Controller for adding new events
  final TextEditingController _eventController = TextEditingController();

  // Store selected date
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Map to store events for specific dates
  Map<DateTime, List<String>> _events = {};

  // Method to add a new event to the selected date
  void _addEvent() {
    // Check if event text is not empty
    if (_eventController.text.isNotEmpty) {
      setState(() {
        // If events for this date don't exist, create a new list
        if (_events[_selectedDay] == null) {
          _events[_selectedDay] = [];
        }

        // Add event to the list for the selected date
        _events[_selectedDay]!.add(_eventController.text);

        // Clear the text controller
        _eventController.clear();
      });
    }
  }

  // Method to delete an event from a specific date
  void _deleteEvent(int index) {
    setState(() {
      // Remove the event at the specified index
      _events[_selectedDay]!.removeAt(index);

      // If no events left for the date, remove the date entry
      if (_events[_selectedDay]!.isEmpty) {
        _events.remove(_selectedDay);
      }
    });
  }

  // Get events for a specific day
  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Events'),
      ),
      body: Column(
        children: [
          // Calendar Widget
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,

            // Event marker for dates with events
            eventLoader: _getEventsForDay,

            // Day selection
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },

            // Customize calendar appearance
            calendarStyle: const CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.red, // Change this to your desired color
                shape: BoxShape.circle,
              ),
              markersMaxCount: 1,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              // Show markers for days with events
            ),
          ),

          // Events List for Selected Day
          Expanded(
            child: ListView.builder(
              // Show events only for the selected day
              itemCount: _getEventsForDay(_selectedDay).length,
              itemBuilder: (context, index) {
                // Get events for the selected day
                List<String> dayEvents = _getEventsForDay(_selectedDay);

                return ListTile(
                  title: Text(dayEvents[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteEvent(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Floating Action Button to Add Events
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title:
                  Text('Add Event to ${_selectedDay.toLocal()}'.split(' ')[0]),
              content: TextField(
                controller: _eventController,
                decoration: InputDecoration(
                  hintText: 'Enter event name',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _addEvent();
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Dispose controller when widget is removed
  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }
}
