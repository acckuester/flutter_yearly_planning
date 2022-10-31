import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:yearly_planning/yearly_planning.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _yearlyPlanningPlugin = YearlyPlanningPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _yearlyPlanningPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Yearly planning example app'),
        ),
        body: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? startSelection;
  DateTime? endSelection;

  @override
  Widget build(BuildContext context) {
    final int year = DateTime.now().year;
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            DateSelection(
              value: startSelection,
              onChanged: (DateTime? value) => setState(
                () => startSelection = value,
              ),
            ),
            DateSelection(
              key: ValueKey(endSelection),
              value: endSelection,
              onChanged: (DateTime? value) => setState(
                () => endSelection = value,
              ),
            ),
          ],
        ),
        YearlyPlanning(
          year: year,
          selection: YearlyPlanningSelection(
            startDate: startSelection,
            endDate: endSelection,
          ),
          title: Text(
            'Year $year',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 20, letterSpacing: 0),
          ),
          aspectRatio: 1,
          dayStyle: Theme.of(context)
              .textTheme
              .overline!
              .copyWith(fontSize: 12, letterSpacing: 0),
          labelStyle: Theme.of(context)
              .textTheme
              .overline!
              .copyWith(fontSize: 18, letterSpacing: 0),
          monthToString: (BuildContext context, DateTime month) =>
              month.month.toString().padLeft(2, '0'),
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.grey[200],
          textColor: Theme.of(context).primaryColor,
          weekendColor: Colors.indigo.withAlpha(50),
          onWeekendColor: Colors.white,
          dayBorderColor: Colors.black.withAlpha(20),
          selectionColor: Colors.yellow,
          onSelectionColor: Colors.black,
          selectionLabel: 'My Selection',
          weekendLabel: 'Weekend',
          onDatePressed: (DateTime date) {
            if (startSelection != null && endSelection == null) {
              setState(() => endSelection = date);
              return;
            }
            setState(() {
              startSelection = date;
              endSelection = null;
            });
          },
          groups: <YearlyPlanningGroup>[
            YearlyPlanningGroup(
              label: 'Holiday',
              color: Colors.green,
              onColor: Colors.black,
              items: <YearlyPlanningItem>[
                YearlyPlanningItem(DateTime(year, 1, 1)),
                YearlyPlanningItem(DateTime(year, 5, 1)),
                YearlyPlanningItem(DateTime(year, 6, 5), isHalfDay: true),
                YearlyPlanningItem(DateTime(year, 6, 6)),
                YearlyPlanningItem(DateTime(year, 6, 7)),
                YearlyPlanningItem(DateTime(year, 6, 8)),
                YearlyPlanningItem(DateTime(year, 6, 9)),
                YearlyPlanningItem(DateTime(year, 6, 10)),
                YearlyPlanningItem(DateTime(year, 12, 24), isHalfDay: true),
                YearlyPlanningItem(DateTime(year, 12, 25)),
                YearlyPlanningItem(DateTime(year, 12, 26)),
                YearlyPlanningItem(DateTime(year, 12, 31), isHalfDay: true),
              ],
            ),
            YearlyPlanningGroup(
              label: 'Vacation',
              color: Colors.red,
              onColor: Colors.white,
              items: <YearlyPlanningItem>[
                YearlyPlanningItem(DateTime(year, 7, 5), isHalfDay: true),
                YearlyPlanningItem(DateTime(year, 7, 6)),
                YearlyPlanningItem(DateTime(year, 7, 7)),
                YearlyPlanningItem(DateTime(year, 7, 8)),
                YearlyPlanningItem(DateTime(year, 10, 9)),
                YearlyPlanningItem(DateTime(year, 10, 10)),
              ],
            )
          ],
        )
      ],
    );
  }
}

class DateSelection extends StatelessWidget {
  const DateSelection({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final DateTime? value;
  final void Function(DateTime?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            _formatDate(context),
            textAlign: TextAlign.center,
          )),
          IconButton(
            onPressed: () async {
              final DateTime? newValue = await showDatePicker(
                context: context,
                initialDate: value ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2200),
              );

              onChanged(newValue);
            },
            icon: const Icon(Icons.calendar_month),
          )
        ],
      ),
    );
  }

  String _formatDate(BuildContext context) {
    if (value == null) {
      return 'n/a';
    }

    return '${value!.day}.${value!.month}.${value!.year}';
  }
}
