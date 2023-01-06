import 'package:geneva_barbers/localization/language_constraints.dart';
import 'package:geneva_barbers/pages/confirmation_page.dart';
import 'package:geneva_barbers/providers/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/barber_provider.dart';
import '../size_config.dart';

class BookAppointmentPage extends StatefulWidget {
  String barberId;
  String serviceId;
  String restorationId;

  BookAppointmentPage(this.serviceId, this.barberId, this.restorationId,
      {Key? key})
      : super(key: key);

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage>
    with RestorationMixin {
  Map<String, dynamic> _workingTime = {};

  static String _barberId = "-1";

  String _selectedTime = "";

  int _selectedTimeIndex = -1;

  final _isBookBtnLoading = false;

  bool _isWorkingDay = true;

  bool _isDayAdded = false;

  bool _isFirstTime = true;

  List<String> activeAppointments = [];
  var activeApp;

  @override
  Widget build(BuildContext context) {
    _barberId = widget.barberId;

    final freeweekdays = Provider.of<BarberProvider>(context).freeWeekdays;

    if (_isFirstTime) {
      // if (_selectedDate.value.weekday == 3) {
      //   _isDayAdded = true;
      //   _selectedDate.value = _selectedDate.value.add(const Duration(days: 1));
      // } else

      if (freeweekdays.contains(_selectedDate.value.weekday)) {
        _isDayAdded = true;
        _selectedDate.value = _selectedDate.value.add(const Duration(days: 1));
      }

      // if (_selectedDate.value.weekday == 7) {
      //   _isDayAdded = true;
      //   _selectedDate.value = _selectedDate.value.add(const Duration(days: 1));
      // }

      final barberProvider = Provider.of<BarberProvider>(context);
      final times = barberProvider.findWorkingTime(
          widget.barberId, _selectedDate.value.weekday.toString());

      for (var element in barberProvider.freeWeekdays) {
        if (_selectedDate.value.weekday == element) {
          _isWorkingDay = false;
        }
      }
      final activeAppointmentsOriginal =
          Provider.of<AppointmentProvider>(context).allActiveAppointments;
      activeApp = activeAppointmentsOriginal;
      for (var appointment in activeAppointmentsOriginal) {
        if (appointment.bookingStart.month == _selectedDate.value.month &&
            appointment.bookingStart.day == _selectedDate.value.day &&
            widget.barberId == appointment.barberId) {
          activeAppointments
              .add(appointment.bookingStart.toString().substring(11, 16));
          if (appointment.bookingStart.toString().substring(14, 16) == "00" &&
              appointment.bookingEnd.toString().substring(14, 16) == "00") {
            activeAppointments.add(appointment.bookingStart
                .toString()
                .replaceRange(14, 16, "30")
                .substring(11, 16));
          }
          if (appointment.bookingStart.toString().substring(14, 16) == "30" &&
              appointment.bookingEnd.toString().substring(14, 16) == "30") {
            activeAppointments.add(appointment.bookingEnd
                .toString()
                .replaceRange(14, 16, "00")
                .substring(11, 16));
          }
        }
      }

      for (var element in barberProvider.barbers
          .firstWhere((element) => element.id == _barberId)
          .daysoff) {
        if (_selectedDate.value == element) {
          _isWorkingDay = false;
        }
      }
      if (_isDayAdded || _selectedDate.value.day != DateTime.now().day) {
        for (var element in times) {
          String startTimeString =
              element["startTime"].toString().substring(0, 5);
          String endTimeString = element["endTime"].toString().substring(0, 5);
          while (startTimeString != endTimeString) {
            if (_selectedTime == startTimeString ||
                activeAppointments.contains(startTimeString)) {
              _workingTime.addAll({startTimeString: true});
            } else {
              _workingTime.addAll({startTimeString: !_isWorkingDay});
            }

            if (startTimeString[3] == "0") {
              startTimeString = startTimeString.replaceRange(3, 4, "3");
            } else {
              int f = int.parse(startTimeString.substring(0, 2));
              f = f + 1;
              startTimeString = startTimeString.replaceRange(3, 4, "0");
              if (f < 10) {
                startTimeString = startTimeString.replaceRange(0, 2, "0$f");
              } else {
                startTimeString = startTimeString.replaceRange(0, 2, "$f");
              }
            }
            // }
          }
        }
      } else {
        for (var element in times) {
          String startTimeString =
              element["startTime"].toString().substring(0, 5);
          String endTimeString = element["endTime"].toString().substring(0, 5);
          while (startTimeString != endTimeString) {
            if (_selectedTime == startTimeString ||
                activeAppointments.contains(startTimeString)) {
              _workingTime.addAll({startTimeString: true});
            } else {
              DateTime startTime = DateTime.now();
              if (startTime.hour > int.parse(startTimeString.substring(0, 2))) {
                _workingTime.addAll({startTimeString: true});
              } else {
                _workingTime.addAll({startTimeString: !_isWorkingDay});
              }
            }
            if (startTimeString[3] == "0") {
              startTimeString = startTimeString.replaceRange(3, 4, "3");
            } else {
              int f = int.parse(startTimeString.substring(0, 2));
              f = f + 1;
              startTimeString = startTimeString.replaceRange(3, 4, "0");
              if (f < 10) {
                startTimeString = startTimeString.replaceRange(0, 2, "0$f");
              } else {
                startTimeString = startTimeString.replaceRange(0, 2, "$f");
              }
            }
            //  }
          }
        }
      }
    }

    _isFirstTime = true;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          translation(context).bookingP,
          //"Booking Page",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            _barberProfilePic(context),
            _buildCalendar(context),
            const SizedBox(height: 50.0),
            _buildTimeFrame(context),
            const SizedBox(height: 100.0),
          ],
        ),
      ),
      bottomSheet: _buildBookBtn(context),
    );
  }

  Widget _barberProfilePic(BuildContext context) {
    final barberProvider = Provider.of<BarberProvider>(context, listen: false);
    final barbers = barberProvider.barbers;
    final barber = barbers.firstWhere(
      (element) => element.id == widget.barberId,
    );
    return Container(
      // padding: EdgeInsets.only(top: 30.0),
      width: MediaQuery.of(context).size.width,
      height: 155.0,
      child: Column(children: <Widget>[
        Container(
          width: 120.0,
          height: 115.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.25), BlendMode.multiply),
                  image: NetworkImage(barber.pictureUrl.isEmpty
                      ? "https://media.istockphoto.com/photos/male-barber-cutting-sideburns-of-client-in-barber-shop-picture-id1301256896?b=1&k=20&m=1301256896&s=170667a&w=0&h=LHqIUomhTGZjpUY12vWg9Ki0lUGz2F0FfXSicsmSpR8="
                      : barber.pictureUrl),
                  fit: BoxFit.fill),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 3.0),
                    blurRadius: 10.0)
              ]),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Flexible(
          child: Container(
            // padding: EdgeInsets.only( top: 20.0 ),
            width: 140.0,
            height: 50.0,
            child: Column(
              children: <Widget>[
                Text(
                  barber.firstName,
                  style: const TextStyle(
                      fontSize: 21.0, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('EEE, MMM d, yyyy').format(_selectedDate.value),
                style: const TextStyle(
                  fontSize: 20,
                )),
            const SizedBox(
              width: 5.0,
            ),
            IconButton(
              iconSize: 30,
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                _restorableDatePickerRouteFuture.present();
              },
              icon: const Icon(Icons.calendar_month),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildBookBtn(BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(translation(context).alreadyBooked
          // 'ALREADY BOOKED'
          ),
      action: SnackBarAction(
        label: translation(context).okay,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    bool isalready = false;
    final workingTime = _workingTime.keys.toList();
    return _isBookBtnLoading
        ? const CircularProgressIndicator()
        : Container(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () async {
                if (_selectedTimeIndex >= 0 && _isWorkingDay) {
                  final bookingStart = DateTime(
                    _selectedDate.value.year,
                    _selectedDate.value.month,
                    _selectedDate.value.day,
                    int.parse(_selectedTime.substring(0, 2)),
                    int.parse(_selectedTime.substring(3)),
                  );

                  DateTime bookingEnd =
                      bookingStart.add(const Duration(minutes: 30));
                  if (widget.serviceId == 4.toString()) {
                    bookingEnd = bookingStart.add(const Duration(minutes: 60));
                  }
                  for (var appointment in activeApp) {
                    if (appointment.barberId == widget.barberId &&
                        appointment.bookingStart == bookingStart) {
                      isalready = true;
                    }
                    if (appointment.barberId == widget.barberId &&
                        bookingStart.add(const Duration(minutes: 30)) ==
                            appointment.bookingStart &&
                        bookingEnd ==
                            appointment.bookingStart
                                .add(const Duration(minutes: 30))) {
                      isalready = true;
                    }

                    if (appointment.barberId == widget.barberId &&
                        appointment.bookingStart
                                .add(const Duration(minutes: 60)) ==
                            appointment.bookingEnd) {
                      if (bookingStart ==
                          appointment.bookingStart
                              .add(const Duration(minutes: 30))) {
                        isalready = true;
                      }
                    }
                  }

                  if (bookingStart.isBefore(DateTime.now())) {
                    isalready = true;
                  }

                  if (isalready == true) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    setState(() {
                      _workingTime[workingTime[_selectedTimeIndex]] = false;
                      _selectedTime = "";
                      _selectedTimeIndex = -1;
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationPage(
                              barberId: widget.barberId,
                              serviceId: widget.serviceId,
                              bookingStart: bookingStart,
                              bookingEnd: bookingEnd),
                        ));
                  }
                }
              },
              child: Text(
                translation(context).cont,
                // "Continue",
                style: TextStyle(
                    color: _isWorkingDay
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                    fontSize: 20),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) =>
                    _isWorkingDay
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.6)),
              ),
            ),
          );
  }

  Widget _buildTimeFrame(BuildContext context) {
    final workingTime = _workingTime.keys.toList();
    return Container(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(170)),
      height: getProportionateScreenHeight(400),
      child: GridView.builder(
        itemCount: workingTime.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () {
            if (_selectedTimeIndex != i) {
              setState(() {
                if (_selectedTimeIndex >= 0) {
                  _workingTime[workingTime[_selectedTimeIndex]] = false;
                }
                _workingTime[workingTime[i]] = true;
                _selectedTimeIndex = i;
                _selectedTime = workingTime[i];
              });
            }
          },
          child: Container(
            margin: const EdgeInsets.all(5.0),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:
                  _workingTime[workingTime[i]] ? Colors.grey : Colors.black87,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Center(
              child: Text(
                workingTime[i],
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 22,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    DateTime initialDate = DateTime.now();
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.secondary,
              onPrimary: Colors.black,
              onSurface: Colors.blueAccent,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Theme.of(context)
                    .colorScheme
                    .secondary, // button text color
              ),
            ),
          ),
          child: DatePickerDialog(
              restorationId: 'date_picker_dialog',
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              initialDate:
                  DateTime.fromMillisecondsSinceEpoch(arguments! as int),
              firstDate: initialDate,
              lastDate: initialDate.add(const Duration(days: 90)),
              selectableDayPredicate: (DateTime val) {
                final barberProvider =
                    Provider.of<BarberProvider>(context, listen: false);
                final barber = barberProvider.barbers
                    .firstWhere((element) => element.id == _barberId);
                final freeWeekDays = barberProvider.freeWeekdays;

                if (freeWeekDays.contains(val.weekday) ||
                    barber.daysoff.contains(val)) {
                  return false;
                }
                return true;
              }),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'Selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    _isFirstTime = true;
    final workingTime = _workingTime.keys.toList();
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        activeAppointments = [];
        if (_selectedTimeIndex > 0) {
          for (var key in _workingTime.keys) {
            _workingTime[key] = false;
          }
          _workingTime[workingTime[_selectedTimeIndex]] = false;
          _selectedTime = "";
          _selectedTimeIndex = -1;
        }
      });
    }
  }

  void _showDialog(String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isSuccess
            ? translation(context).successful
            : translation(context).error),
        content: Row(children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: isSuccess ? Colors.green : Colors.red,
            size: 35.0,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.black87),
          ),
        ]),
        actions: <Widget>[
          TextButton(
            child: Text(
              translation(context).okay,
              // 'Okay',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
