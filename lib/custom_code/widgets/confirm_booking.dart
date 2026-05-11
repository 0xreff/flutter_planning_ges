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
// ConfirmBooking.dart — Planning Module Screen 3
// FlutterFlow Widget Settings — parameters:
//   width (double), height (double)
//   doctorId (String), doctorName (String)
//   doctorSpecialty (String), doctorPhoto (String) default ''
//   slotId (String), appointmentDate (String) e.g. "2025-01-28"
//   startTime (String), endTime (String)
//   consultationType (String) default 'in_person'
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
  static const accent = Color(0xFF38BDF8);
  static const online = Color(0xFF34D399);
  static const error = Color(0xFFE24B4A);
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

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({
    super.key,
    required this.width,
    required this.height,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    this.doctorPhoto = '',
    required this.slotId,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    this.consultationType = 'in_person',
    this.consultationFee = '0',
  });
  final double? width, height;
  final String doctorId, doctorName, doctorSpecialty, doctorPhoto;
  final String slotId, appointmentDate, startTime, endTime;
  final String consultationType, consultationFee;
  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _reasonCtrl = TextEditingController();
  bool _isDark = true, _themeInit = false, _loading = false, _success = false;

  String get _uid => _auth.currentUser?.uid ?? '';
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
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  DateTime get _date {
    try {
      return DateFormat('yyyy-MM-dd').parse(widget.appointmentDate);
    } catch (_) {
      return DateTime.now();
    }
  }

  int get _duration {
    try {
      final s = widget.startTime.split(':');
      final e = widget.endTime.split(':');
      return (int.parse(e[0]) * 60 + int.parse(e[1])) -
          (int.parse(s[0]) * 60 + int.parse(s[1]));
    } catch (_) {
      return 30;
    }
  }

  (IconData, String) get _typeCfg {
    switch (widget.consultationType) {
      case 'video':
        return (Icons.videocam_rounded, 'Video call');
      case 'call':
        return (Icons.phone_rounded, 'Phone call');
      default:
        return (Icons.location_on_rounded, 'In-person');
    }
  }

  Future<void> _confirm() async {
    if (_loading) return;
    HapticFeedback.mediumImpact();
    setState(() => _loading = true);
    try {
      final batch = _db.batch();
      final apptRef = _db.collection('appointments').doc();
      batch.set(apptRef, {
        'patientId': _uid,
        'doctorId': widget.doctorId,
        'slotId': widget.slotId,
        'status': 'pending',
        'type': widget.consultationType,
        'date': Timestamp.fromDate(_date),
        'startTime': widget.startTime,
        'endTime': widget.endTime,
        'reason': _reasonCtrl.text.trim(),
        'notes': '',
        'cancelledBy': null,
        'cancelReason': null,
        'videoCallUrl': null,
        'reminderSent': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      batch.update(_db.collection('slots').doc(widget.slotId),
          {'isBooked': true, 'appointmentId': apptRef.id});
      final notifRef = _db.collection('notifications').doc();
      batch.set(notifRef, {
        'userId': widget.doctorId,
        'appointmentId': apptRef.id,
        'type': 'confirmation',
        'title': 'New appointment request',
        'body':
            'Appointment on ${DateFormat('EEE d MMM').format(_date)} at ${widget.startTime}',
        'isRead': false,
        'sentAt': FieldValue.serverTimestamp(),
      });
      await batch.commit();
      if (mounted)
        setState(() {
          _loading = false;
          _success = true;
        });
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Booking failed. Please try again.',
                style: GoogleFonts.dmSans(color: Colors.white)),
            backgroundColor: _C.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_success) return _successScreen();
    final (tIco, tLbl) = _typeCfg;
    return Scaffold(
      backgroundColor: _surface,
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
        child: Column(children: [
          _stepBar(),
          const SizedBox(height: 16),
          _doctorCard(),
          const SizedBox(height: 14),
          _summaryCard(tIco, tLbl),
          const SizedBox(height: 14),
          _reasonCard(),
          const SizedBox(height: 14),
          _feeCard(),
        ]),
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: _surface,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: _text, size: 20),
            onPressed: () => Navigator.pop(context)),
        title: Text('Confirm appointment',
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

  Widget _stepBar() => Row(
          children: List.generate(4, (i) {
        final done = i + 1 <= 4;
        return Expanded(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: done ? _C.grad : null,
                    color: done ? null : _border),
                child: done
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            gradient: _C.grad))
                    : null));
      }));

  Widget _doctorCard() {
    final initials = widget.doctorName
        .split(' ')
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0].toUpperCase())
        .join();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _C.primary.withOpacity(.25))),
      child: Row(children: [
        Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: widget.doctorPhoto.isEmpty ? _C.grad : null,
                image: widget.doctorPhoto.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(widget.doctorPhoto),
                        fit: BoxFit.cover)
                    : null),
            child: widget.doctorPhoto.isEmpty
                ? Center(
                    child: Text(initials,
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)))
                : null),
        const SizedBox(width: 14),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.doctorName,
              style: GoogleFonts.plusJakartaSans(
                  color: _text, fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text(widget.doctorSpecialty,
              style: GoogleFonts.dmSans(color: _sub, fontSize: 13)),
        ])),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                color: _C.online.withOpacity(.12),
                borderRadius: BorderRadius.circular(20)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  width: 6,
                  height: 6,
                  decoration:
                      BoxDecoration(color: _C.online, shape: BoxShape.circle)),
              const SizedBox(width: 5),
              Text('Verified',
                  style: GoogleFonts.dmSans(
                      color: _C.online,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
            ])),
      ]),
    );
  }

  Widget _summaryCard(IconData tIco, String tLbl) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _border)),
        child: Column(children: [
          _sRow('Date', DateFormat('EEEE, d MMMM yyyy').format(_date),
              Icons.calendar_today_rounded, _C.primary),
          const SizedBox(height: 12),
          _sRow(
              'Time',
              '${widget.startTime} – ${widget.endTime} ($_duration min)',
              Icons.schedule_rounded,
              _C.accent),
          const SizedBox(height: 12),
          _sRow('Type', tLbl, tIco, _C.secondary),
        ]),
      );

  Widget _sRow(String label, String value, IconData icon, Color color) =>
      Row(children: [
        Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: color.withOpacity(.12),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 17)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: GoogleFonts.dmSans(color: _sub, fontSize: 11)),
          const SizedBox(height: 2),
          Text(value,
              style: GoogleFonts.plusJakartaSans(
                  color: _text, fontSize: 13, fontWeight: FontWeight.w600)),
        ]),
      ]);

  Widget _reasonCard() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _border)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.notes_rounded, color: _C.primary, size: 16),
            const SizedBox(width: 8),
            Text('Reason for visit',
                style: GoogleFonts.plusJakartaSans(
                    color: _text, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(width: 6),
            Text('(optional)',
                style: GoogleFonts.dmSans(color: _sub, fontSize: 12)),
          ]),
          const SizedBox(height: 12),
          TextField(
            controller: _reasonCtrl,
            maxLines: 4,
            maxLength: 300,
            style: GoogleFonts.dmSans(color: _text, fontSize: 14),
            decoration: InputDecoration(
                hintText: 'Describe your symptoms or reason...',
                hintStyle: GoogleFonts.dmSans(
                    color: _sub.withOpacity(.6), fontSize: 13),
                filled: true,
                fillColor: _card2,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: _border)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: _border, width: .5)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: _C.primary, width: 1.5)),
                counterStyle: GoogleFonts.dmSans(color: _sub, fontSize: 11)),
          ),
        ]),
      );

  Widget _feeCard() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _border)),
        child: Column(children: [
          _feeRow('Consultation fee', '${_fee.toStringAsFixed(0)} TND', false),
          const SizedBox(height: 8),
          Divider(color: _border, height: 1),
          const SizedBox(height: 8),
          _feeRow('Total', '${_fee.toStringAsFixed(0)} TND', true),
        ]),
      );

  Widget _feeRow(String label, String value, bool isTotal) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label,
            style: GoogleFonts.dmSans(
                color: isTotal ? _text : _sub,
                fontSize: isTotal ? 14 : 13,
                fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400)),
        Text(value,
            style: GoogleFonts.plusJakartaSans(
                color: isTotal ? _C.online : _text,
                fontSize: isTotal ? 16 : 13,
                fontWeight: FontWeight.w700)),
      ]);

  Widget _bottomBar() => Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        decoration: BoxDecoration(
            color: _card,
            border: Border(top: BorderSide(color: _border, width: .5))),
        child: Row(children: [
          Expanded(
              child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                    color: _card2,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _border)),
                child: Text('Back',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                        color: _sub,
                        fontSize: 15,
                        fontWeight: FontWeight.w600))),
          )),
          const SizedBox(width: 12),
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: _loading ? null : _confirm,
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                        gradient: _loading ? null : _C.grad,
                        color: _loading ? _border : null,
                        borderRadius: BorderRadius.circular(16)),
                    child: _loading
                        ? const Center(
                            child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white)))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                const Icon(Icons.check_circle_outline_rounded,
                                    color: Colors.white, size: 18),
                                const SizedBox(width: 8),
                                Text('Confirm booking',
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                              ])),
              )),
        ]),
      );

  Widget _successScreen() => Scaffold(
        backgroundColor: _surface,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
                width: 90,
                height: 90,
                decoration:
                    BoxDecoration(gradient: _C.grad, shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 44)),
            const SizedBox(height: 28),
            Text('Appointment requested!',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                    color: _text, fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Text(
                'Your request has been sent to ${widget.doctorName}.\nYou will be notified once confirmed.',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.dmSans(color: _sub, fontSize: 14, height: 1.6)),
            const SizedBox(height: 24),
            Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: _card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _border)),
                child: Column(children: [
                  _sRow('Date', DateFormat('EEE, d MMM yyyy').format(_date),
                      Icons.calendar_today_rounded, _C.primary),
                  const SizedBox(height: 10),
                  _sRow('Time', '${widget.startTime} – ${widget.endTime}',
                      Icons.schedule_rounded, _C.accent),
                ])),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () => context.goNamed('MyPlannings'),
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                      gradient: _C.grad,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text('View my appointments',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600))),
            ),
          ]),
        )),
      );
}
