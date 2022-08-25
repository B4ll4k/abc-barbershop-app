import 'package:abc_barbershop/pages/confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/appointment_provider.dart';
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

  bool _isBookBtnLoading = false;

  bool _isWorkingDay = true;

  @override
  Widget build(BuildContext context) {
    _barberId = widget.barberId;
    _workingTime = {};
    _isWorkingDay = true;

    final barberProvider = Provider.of<BarberProvider>(context);
    final times = barberProvider.findWorkingTime(
        widget.barberId, _selectedDate.value.weekday.toString());

    for (var element in barberProvider.freeWeekdays) {
      if (_selectedDate.value.weekday == element) {
        _isWorkingDay = false;
      }
    }

    for (var element in barberProvider.barbers
        .firstWhere((element) => element.id == _barberId)
        .daysoff) {
      if (_selectedDate.value == element) {
        _isWorkingDay = false;
      }
    }
    for (var element in times) {
      String startTime = element["startTime"].toString().substring(0, 5);
      String endTime = element["endTime"].toString().substring(0, 5);
      String breakStartTime =
          element["breakStartTime"].toString().substring(0, 5);
      String breakEndTime = element["breakEndTime"].toString().substring(0, 5);
      while (startTime != breakStartTime) {
        if (_selectedTime == startTime) {
          _workingTime.addAll({startTime: true});
        } else {
          if (DateTime.now().hour > int.parse(startTime.substring(0, 2))) {
            _workingTime.addAll({startTime: true});
          } else {
            _workingTime.addAll({startTime: !_isWorkingDay});
          }
        }

        if (startTime[3] == "0") {
          startTime = startTime.replaceRange(3, 4, "3");
        } else {
          int f = int.parse(startTime.substring(0, 2));
          f = f + 1;
          startTime = startTime.replaceRange(3, 4, "0");
          if (f < 10) {
            startTime = startTime.replaceRange(0, 2, "0$f");
          } else {
            startTime = startTime.replaceRange(0, 2, "$f");
          }
        }
      }
      while (breakEndTime != endTime) {
        if (_selectedTime == breakEndTime) {
          _workingTime.addAll({breakEndTime: true});
        } else {
          if (DateTime.now().hour > int.parse(breakEndTime.substring(0, 2))) {
            _workingTime.addAll({breakEndTime: true});
          } else {
            _workingTime.addAll({breakEndTime: !_isWorkingDay});
          }
        }
        if (breakEndTime[3] == "0") {
          breakEndTime = breakEndTime.replaceRange(3, 4, "3");
        } else {
          int f = int.parse(breakEndTime.substring(0, 2));
          f = f + 1;
          breakEndTime = breakEndTime.replaceRange(3, 4, "0");
          if (f < 10) {
            breakEndTime = breakEndTime.replaceRange(0, 2, "0$f");
          } else {
            breakEndTime = breakEndTime.replaceRange(0, 2, "$f");
          }
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          "Booking Page",
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
                  fit: BoxFit.cover),
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
                  final bookingEnd =
                      bookingStart.add(const Duration(minutes: 30));
                  if (DateTime.now().hour >
                      int.parse(_selectedTime.substring(0, 2))) {
                    setState(() {
                      _workingTime[workingTime[_selectedTimeIndex]] = false;
                      _selectedTime = "";
                      _selectedTimeIndex = -1;
                    });
                    _showDialog("Please, select another time!", false);
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
                "Continue",
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
      height: getProportionateScreenHeight(420),
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
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 90)),
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
    final workingTime = _workingTime.keys.toList();
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        if (_selectedTimeIndex > 0) {
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
        title: Text(isSuccess ? 'Successful' : 'An Error Occurred!'),
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
              'Okay',
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
