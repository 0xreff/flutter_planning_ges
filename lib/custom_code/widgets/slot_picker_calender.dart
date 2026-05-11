// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// ============================================================
// SlotPickerCalender.dart — Planning Module Screen 2
// FlutterFlow Widget Settings — parameters:
//   width (double), height (double)
//   doctorId (String), doctorName (String)
//   doctorSpecialty (String), doctorPhoto (String) default ''
//   consultationFee (String) default '0'
// ============================================================
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class _C {
  static const primary = Color(0xFFA78BFA);
  static const secondary = Color(0xFFEC4899);
  static const online = Color(0xFF34D399);
  static const surfaceD = Color(0xFF0D0D1A);
  static const cardD = Color(0xFF13132B);
  static const card2D = Color(0xFF1A1A35);
  static const borderD = Color(0xFF2A2A50);
  static const surfaceL = Color(0xFFF5F3FF);
  static const cardL = Color(0xFFFFFFFF);
  static const card2L = Color(0xFFF0EEFF);
  static const borderL = Color(0xFFDDD6FE);
  static const grad = LinearGradient(
      colors: [Color(0xFFA78BFA), Color(0xFFEC4899)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}

enum _SlotType { inPerson, video, call }

class _Slot {
  final String id, startTime, endTime;
  final DateTime date;
  final int durationMinutes;
  final _SlotType type;
  final bool isBooked;
  const _Slot(
      {required this.id,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.durationMinutes,
      required this.type,
      required this.isBooked});

  factory _Slot.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    _SlotType t;
    switch (d['type']) {
      case 'video':
        t = _SlotType.video;
        break;
      case 'call':
        t = _SlotType.call;
        break;
      default:
        t = _SlotType.inPerson;
    }
    return _Slot(
      id: doc.id,
      date: (d['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      startTime: d['startTime'] ?? '',
      endTime: d['endTime'] ?? '',
      durationMinutes: (d['durationMinutes'] ?? 30) as int,
      type: t,
      isBooked: d['isBooked'] ?? false,
    );
  }

  bool get isAvailable => !isBooked;
  String get typeLabel {
    switch (type) {
      case _SlotType.video:
        return 'Video';
      case _SlotType.call:
        return 'Call';
      case _SlotType.inPerson:
        return 'In-person';
    }
  }

  IconData get typeIcon {
    switch (type) {
      case _SlotType.video:
        return Icons.videocam_rounded;
      case _SlotType.call:
        return Icons.phone_rounded;
      case _SlotType.inPerson:
        return Icons.location_on_rounded;
    }
  }
}

class SlotPickerCalender extends StatefulWidget {
  const SlotPickerCalender({
    super.key,
    required this.width,
    required this.height,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    this.doctorPhoto = '',
    this.consultationFee = '0',
  });
  final double? width, height;
  final String doctorId, doctorName, doctorSpecialty;
  final String doctorPhoto, consultationFee;
  @override
  State<SlotPickerCalender> createState() => _SlotPickerCalenderState();
}

class _SlotPickerCalenderState extends State<SlotPickerCalender> {
  final _db = FirebaseFirestore.instance;
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDay;
  _Slot? _selectedSlot;
  _SlotType? _filterType;
  Map<DateTime, List<_Slot>> _slotsByDay = {};
  bool _loading = true;
  bool _isDark = true;
  bool _themeInit = false;

  double get _fee => double.tryParse(widget.consultationFee) ?? 0.0;

  Color get _surface => _isDark ? _C.surfaceD : _C.surfaceL;
  Color get _card => _isDark ? _C.cardD : _C.cardL;
  Color get _card2 => _isDark ? _C.card2D : _C.card2L;
  Color get _border => _isDark ? _C.borderD : _C.borderL;
  Color get _text => _isDark ? Colors.white : const Color(0xFF0D0D1A);
  Color get _sub => _isDark ? const Color(0xFF8888BB) : const Color(0xFF6B6B9A);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_themeInit) {
      _isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
      _themeInit = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSlots();
  }

  Future<void> _loadSlots() async {
    setState(() => _loading = true);
    final start = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final end =
        DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0, 23, 59);
    final snap = await _db
        .collection('slots')
        .where('doctorId', isEqualTo: widget.doctorId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('date')
        .orderBy('startTime')
        .get();
    final map = <DateTime, List<_Slot>>{};
    for (final doc in snap.docs) {
      final sl = _Slot.fromDoc(doc);
      final key = DateTime(sl.date.year, sl.date.month, sl.date.day);
      map.putIfAbsent(key, () => []).add(sl);
    }
    if (mounted)
      setState(() {
        _slotsByDay = map;
        _loading = false;
      });
  }

  void _prevMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
      _selectedDay = null;
      _selectedSlot = null;
    });
    _loadSlots();
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
      _selectedDay = null;
      _selectedSlot = null;
    });
    _loadSlots();
  }

  List<_Slot> _slotsFor(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return _slotsByDay[key] ?? [];
  }

  bool _hasAvailable(DateTime day) => _slotsFor(day).any((s) => s.isAvailable);
  bool _isPast(DateTime day) =>
      day.isBefore(DateTime.now().subtract(const Duration(days: 1)));
  bool _isToday(DateTime day) {
    final n = DateTime.now();
    return day.year == n.year && day.month == n.month && day.day == n.day;
  }

  bool _isSelected(DateTime day) =>
      _selectedDay != null &&
      day.year == _selectedDay!.year &&
      day.month == _selectedDay!.month &&
      day.day == _selectedDay!.day;

  void _continue() {
    if (_selectedSlot == null) return;
    HapticFeedback.mediumImpact();
    final typeStr = _selectedSlot!.type == _SlotType.video
        ? 'video'
        : _selectedSlot!.type == _SlotType.call
            ? 'call'
            : 'in_person';
    context.pushNamed(
      'ConfirmBooking',
      queryParameters: {
        'doctorId': widget.doctorId,
        'doctorName': widget.doctorName,
        'doctorSpecialty': widget.doctorSpecialty,
        'doctorPhoto': widget.doctorPhoto,
        'slotId': _selectedSlot!.id,
        'appointmentDate': DateFormat('yyyy-MM-dd').format(_selectedDay!),
        'startTime': _selectedSlot!.startTime,
        'endTime': _selectedSlot!.endTime,
        'consultationType': typeStr,
        'consultationFee': widget.consultationFee,
      }.withoutNulls,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surface,
      appBar: _appBar(),
      body: Column(children: [
        _doctorStrip(),
        _stepBar(),
        Expanded(
            child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          child: Column(children: [
            _calCard(),
            if (_selectedDay != null) ...[
              const SizedBox(height: 14),
              _slotsSection()
            ],
          ]),
        )),
      ]),
      bottomNavigationBar: _bottomBar(),
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: _surface,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: _text, size: 20),
            onPressed: () => Navigator.pop(context)),
        title: Text('Choose a date & time',
            style: GoogleFonts.plusJakartaSans(
                color: _text, fontSize: 17, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
              icon: Icon(
                  _isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: _C.primary,
                  size: 20),
              onPressed: () => setState(() => _isDark = !_isDark)),
          IconButton(
              icon: Icon(Icons.home_rounded, color: _C.primary, size: 22),
              onPressed: () => context.goNamed('homePage')),
        ],
      );

  Widget _doctorStrip() => Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _C.primary.withOpacity(.25))),
        child: Row(children: [
          Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: widget.doctorPhoto.isEmpty ? _C.grad : null,
                  image: widget.doctorPhoto.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(widget.doctorPhoto),
                          fit: BoxFit.cover)
                      : null),
              child: widget.doctorPhoto.isEmpty
                  ? Center(
                      child: Text(
                          widget.doctorName
                              .split(' ')
                              .where((w) => w.isNotEmpty)
                              .take(2)
                              .map((w) => w[0])
                              .join(),
                          style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)))
                  : null),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(widget.doctorName,
                    style: GoogleFonts.plusJakartaSans(
                        color: _text,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(widget.doctorSpecialty,
                    style: GoogleFonts.dmSans(color: _sub, fontSize: 12)),
              ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('${_fee.toStringAsFixed(0)} TND',
                style: GoogleFonts.plusJakartaSans(
                    color: _C.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),
            Text('per session',
                style: GoogleFonts.dmSans(color: _sub, fontSize: 11)),
          ]),
        ]),
      );

  Widget _stepBar() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Row(
            children: List.generate(4, (i) {
          final done = i + 1 < 2, active = i + 1 == 2;
          return Expanded(
              child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: done || active ? _C.grad : null,
                color: done || active ? null : _border),
            child: done || active
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: _C.grad))
                : null,
          ));
        })),
      );

  Widget _calCard() => Container(
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _border)),
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            IconButton(
                onPressed: _prevMonth,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                icon: Icon(Icons.chevron_left_rounded, color: _text)),
            Expanded(
                child: Text(DateFormat('MMMM yyyy').format(_focusedMonth),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                        color: _text,
                        fontSize: 16,
                        fontWeight: FontWeight.w600))),
            IconButton(
                onPressed: _nextMonth,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                icon: Icon(Icons.chevron_right_rounded, color: _text)),
          ]),
          const SizedBox(height: 10),
          Row(
              children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                  .map((d) => Expanded(
                      child: Text(d,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                              color: _sub,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))))
                  .toList()),
          const SizedBox(height: 8),
          _loading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: CircularProgressIndicator(
                      color: _C.primary, strokeWidth: 2))
              : _grid(),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _legend(_C.secondary, 'Has slots'),
            const SizedBox(width: 16),
            _legend(_C.primary.withOpacity(.3), 'Selected'),
            const SizedBox(width: 16),
            _legend(_sub.withOpacity(.3), 'Unavailable'),
          ]),
        ]),
      );

  Widget _legend(Color c, String l) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(l, style: GoogleFonts.dmSans(color: _sub, fontSize: 11)),
      ]);

  Widget _grid() {
    final first = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final offset = first.weekday - 1;
    final daysInMon =
        DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;
    final cells = <Widget>[];
    for (int i = 0; i < offset; i++) cells.add(const SizedBox());
    for (int d = 1; d <= daysInMon; d++) {
      final day = DateTime(_focusedMonth.year, _focusedMonth.month, d);
      final past = _isPast(day), today = _isToday(day);
      final sel = _isSelected(day), has = _hasAvailable(day);
      cells.add(GestureDetector(
          onTap: past || !has
              ? null
              : () {
                  HapticFeedback.selectionClick();
                  setState(() {
                    _selectedDay = day;
                    _selectedSlot = null;
                  });
                },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                gradient: sel ? _C.grad : null,
                color: sel
                    ? null
                    : today
                        ? _C.primary.withOpacity(.15)
                        : null,
                borderRadius: BorderRadius.circular(10)),
            child: Stack(alignment: Alignment.center, children: [
              Text('$d',
                  style: GoogleFonts.dmSans(
                      color: sel
                          ? Colors.white
                          : past
                              ? _sub.withOpacity(.3)
                              : today
                                  ? _C.primary
                                  : _text,
                      fontSize: 13,
                      fontWeight:
                          sel || today ? FontWeight.w600 : FontWeight.w400)),
              if (has && !sel)
                Positioned(
                    bottom: 3,
                    child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                            color: _C.secondary, shape: BoxShape.circle))),
            ]),
          )));
    }
    return GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.0,
        children: cells);
  }

  Widget _slotsSection() {
    final all = _slotsFor(_selectedDay!);
    final avail = all.where((s) => s.isAvailable).toList();
    if (all.isEmpty)
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _border)),
        child: Column(children: [
          Icon(Icons.event_busy_rounded, color: _sub, size: 36),
          const SizedBox(height: 12),
          Text('No slots on this day',
              style: GoogleFonts.plusJakartaSans(
                  color: _text, fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Select another date',
              style: GoogleFonts.dmSans(color: _sub, fontSize: 13)),
        ]),
      );

    final filtered = _filterType == null
        ? all
        : all.where((s) => s.type == _filterType).toList();

    return Container(
      decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _border)),
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.schedule_rounded, color: _C.primary, size: 16),
          const SizedBox(width: 6),
          Text(DateFormat('EEEE, d MMMM').format(_selectedDay!),
              style: GoogleFonts.plusJakartaSans(
                  color: _text, fontSize: 14, fontWeight: FontWeight.w600)),
          const Spacer(),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: _C.online.withOpacity(.12),
                  borderRadius: BorderRadius.circular(20)),
              child: Text('${avail.length} available',
                  style: GoogleFonts.dmSans(
                      color: _C.online,
                      fontSize: 11,
                      fontWeight: FontWeight.w600))),
        ]),
        const SizedBox(height: 12),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              _chip('All', null),
              _chip('In-person', _SlotType.inPerson),
              _chip('Video', _SlotType.video),
              _chip('Call', _SlotType.call),
            ])),
        const SizedBox(height: 14),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemCount: filtered.length,
            itemBuilder: (_, i) => _slotCell(filtered[i])),
      ]),
    );
  }

  Widget _chip(String label, _SlotType? type) {
    final active = _filterType == type;
    return GestureDetector(
      onTap: () => setState(() => _filterType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            gradient: active ? _C.grad : null,
            color: active ? null : _card2,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: active ? Colors.transparent : _border)),
        child: Text(label,
            style: GoogleFonts.dmSans(
                color: active ? Colors.white : _sub,
                fontSize: 12,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400)),
      ),
    );
  }

  Widget _slotCell(_Slot slot) {
    final sel = _selectedSlot?.id == slot.id;
    final avail = slot.isAvailable;
    return GestureDetector(
      onTap: avail
          ? () {
              HapticFeedback.selectionClick();
              setState(() => _selectedSlot = sel ? null : slot);
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
            gradient: sel ? _C.grad : null,
            color: sel
                ? null
                : avail
                    ? _card2
                    : _card2.withOpacity(.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: sel
                    ? Colors.transparent
                    : avail
                        ? _border
                        : _border.withOpacity(.3))),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(slot.startTime,
              style: GoogleFonts.plusJakartaSans(
                  color: sel
                      ? Colors.white
                      : avail
                          ? _text
                          : _sub.withOpacity(.4),
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(slot.typeIcon,
                size: 10,
                color: sel
                    ? Colors.white70
                    : avail
                        ? _sub
                        : _sub.withOpacity(.3)),
            const SizedBox(width: 3),
            Text(avail ? slot.typeLabel : 'Booked',
                style: GoogleFonts.dmSans(
                    color: sel
                        ? Colors.white70
                        : avail
                            ? _sub
                            : _sub.withOpacity(.3),
                    fontSize: 10)),
          ]),
        ]),
      ),
    );
  }

  Widget _bottomBar() {
    final ok = _selectedSlot != null;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      decoration: BoxDecoration(
          color: _card,
          border: Border(top: BorderSide(color: _border, width: .5))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (ok) ...[
          Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: _C.primary.withOpacity(.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _C.primary.withOpacity(.2))),
              child: Row(children: [
                Icon(Icons.check_circle_rounded, color: _C.primary, size: 18),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                          '${DateFormat('EEE, d MMM').format(_selectedDay!)} · ${_selectedSlot!.startTime}',
                          style: GoogleFonts.plusJakartaSans(
                              color: _text,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                      Text(
                          '${_selectedSlot!.typeLabel} · ${_selectedSlot!.durationMinutes} min',
                          style: GoogleFonts.dmSans(color: _sub, fontSize: 12)),
                    ])),
                Text('${_fee.toStringAsFixed(0)} TND',
                    style: GoogleFonts.plusJakartaSans(
                        color: _C.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
              ])),
        ],
        GestureDetector(
          onTap: ok ? _continue : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
                gradient: ok ? _C.grad : null,
                color: ok ? null : _border,
                borderRadius: BorderRadius.circular(16)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(ok ? 'Continue' : 'Select a time slot',
                  style: GoogleFonts.plusJakartaSans(
                      color: ok ? Colors.white : _sub,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              if (ok) ...[
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded,
                    color: Colors.white, size: 18)
              ],
            ]),
          ),
        ),
      ]),
    );
  }
}
