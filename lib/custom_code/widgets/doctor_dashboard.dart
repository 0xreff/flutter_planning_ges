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
// DoctorDashboard.dart — Planning Module Screen 4
// FlutterFlow Custom Widget — no parameters needed
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
  static const amber = Color(0xFFEF9F27);
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
  static const gradBlue = LinearGradient(
      colors: [Color(0xFF38BDF8), Color(0xFF818CF8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}

enum _Status { pending, confirmed, completed, cancelled, rescheduled, noShow }

enum _Type { inPerson, video, call }

class _Appt {
  final String id, patientId, patientName, startTime;
  final String? patientPhoto, reason, videoCallUrl;
  final _Status status;
  final _Type type;
  final DateTime date;
  const _Appt(
      {required this.id,
      required this.patientId,
      required this.patientName,
      required this.startTime,
      this.patientPhoto,
      this.reason,
      this.videoCallUrl,
      required this.status,
      required this.type,
      required this.date});
}

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key, required this.width, required this.height});
  final double? width, height;
  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool _isDark = true, _themeInit = false;
  DateTime _selectedDay = DateTime.now();
  List<_Appt> _appointments = [];
  bool _loading = true;
  String _doctorName = '';
  String? _doctorPhoto;

  String get _uid => _auth.currentUser?.uid ?? '';
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
    _loadProfile();
    _loadAppointments();
  }

  Future<void> _loadProfile() async {
    final doc = await _db.collection('doctors').doc(_uid).get();
    if (doc.exists && mounted)
      setState(() {
        _doctorName = doc.data()!['display_name'] ?? 'Doctor';
        _doctorPhoto = doc.data()!['photo_url'];
      });
  }

  Future<void> _loadAppointments() async {
    setState(() => _loading = true);
    final start =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final end = DateTime(
        _selectedDay.year, _selectedDay.month, _selectedDay.day, 23, 59, 59);
    final snap = await _db
        .collection('appointments')
        .where('doctorId', isEqualTo: _uid)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('date')
        .orderBy('startTime')
        .get();
    final list = <_Appt>[];
    for (final doc in snap.docs) {
      final d = doc.data();
      final pid = d['patientId'] ?? '';
      String name = 'Patient';
      String? photo;
      if (pid.isNotEmpty) {
        final u = await _db.collection('users').doc(pid).get();
        if (u.exists) {
          name = u.data()!['display_name'] ?? 'Patient';
          photo = u.data()!['photo_url'];
        }
      }
      _Status st;
      switch (d['status']) {
        case 'confirmed':
          st = _Status.confirmed;
          break;
        case 'completed':
          st = _Status.completed;
          break;
        case 'cancelled':
          st = _Status.cancelled;
          break;
        case 'rescheduled':
          st = _Status.rescheduled;
          break;
        case 'no_show':
          st = _Status.noShow;
          break;
        default:
          st = _Status.pending;
      }
      _Type tp;
      switch (d['type']) {
        case 'video':
          tp = _Type.video;
          break;
        case 'call':
          tp = _Type.call;
          break;
        default:
          tp = _Type.inPerson;
      }
      list.add(_Appt(
        id: doc.id,
        patientId: pid,
        patientName: name,
        patientPhoto: photo,
        status: st,
        type: tp,
        date: (d['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
        startTime: d['startTime'] ?? '',
        reason: d['reason'],
        videoCallUrl: d['videoCallUrl'],
      ));
    }
    if (mounted)
      setState(() {
        _appointments = list;
        _loading = false;
      });
  }

  int get _todayCount => _appointments.length;
  int get _confirmedCount =>
      _appointments.where((a) => a.status == _Status.confirmed).length;
  int get _pendingCount =>
      _appointments.where((a) => a.status == _Status.pending).length;
  int get _completedCount =>
      _appointments.where((a) => a.status == _Status.completed).length;

  Future<void> _accept(String id) async {
    HapticFeedback.lightImpact();
    await _db.collection('appointments').doc(id).update(
        {'status': 'confirmed', 'updatedAt': FieldValue.serverTimestamp()});
    _loadAppointments();
  }

  Future<void> _reject(String id) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: _card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Reject appointment?',
            style: GoogleFonts.plusJakartaSans(
                color: _text, fontWeight: FontWeight.w600)),
        content: Text('The patient will be notified.',
            style: GoogleFonts.dmSans(color: _sub, fontSize: 13)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child:
                  Text('Cancel', style: GoogleFonts.dmSans(color: _C.primary))),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child:
                  Text('Reject', style: GoogleFonts.dmSans(color: _C.error))),
        ],
      ),
    );
    if (ok == true) {
      await _db.collection('appointments').doc(id).update({
        'status': 'cancelled',
        'cancelledBy': 'doctor',
        'updatedAt': FieldValue.serverTimestamp()
      });
      _loadAppointments();
    }
  }

  Future<void> _markDone(String id) async {
    await _db.collection('appointments').doc(id).update(
        {'status': 'completed', 'updatedAt': FieldValue.serverTimestamp()});
    _loadAppointments();
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'morning';
    if (h < 17) return 'afternoon';
    return 'evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surface,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [_appBar()],
        body: RefreshIndicator(
          color: _C.primary,
          onRefresh: _loadAppointments,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _statsRow(),
              const SizedBox(height: 20),
              _dayPicker(),
              const SizedBox(height: 16),
              Text('Agenda',
                  style: GoogleFonts.plusJakartaSans(
                      color: _text, fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              if (_loading)
                const Center(
                    child: Padding(
                        padding: EdgeInsets.all(40),
                        child: CircularProgressIndicator(color: _C.primary)))
              else if (_appointments.isEmpty)
                _empty()
              else
                ..._appointments.map((a) => _AgendaCard(
                    a: a,
                    isDark: _isDark,
                    card: _card,
                    card2: _card2,
                    border: _border,
                    textC: _text,
                    sub: _sub,
                    onAccept: () => _accept(a.id),
                    onReject: () => _reject(a.id),
                    onComplete: () => _markDone(a.id),
                    onJoin: () {
                      if (a.videoCallUrl != null &&
                          a.videoCallUrl!.isNotEmpty) {
                        launchURL(a.videoCallUrl!);
                      }
                    })),
            ]),
          ),
        ),
      ),
    );
  }

  SliverAppBar _appBar() => SliverAppBar(
        pinned: true,
        expandedHeight: 100,
        backgroundColor: _surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(left: 20, bottom: 14),
          title: Row(children: [
            Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: _doctorPhoto == null ? _C.grad : null,
                    image: _doctorPhoto != null
                        ? DecorationImage(
                            image: NetworkImage(_doctorPhoto!),
                            fit: BoxFit.cover)
                        : null),
                child: _doctorPhoto == null
                    ? Center(
                        child: Text(
                            _doctorName.isNotEmpty ? _doctorName[0] : 'D',
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700)))
                    : null),
            const SizedBox(width: 10),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Good ${_greeting()}',
                      style: GoogleFonts.dmSans(color: _sub, fontSize: 11)),
                  Text(_doctorName,
                      style: GoogleFonts.plusJakartaSans(
                          color: _text,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                ]),
          ]),
        ),
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
          IconButton(
              icon: Icon(Icons.notifications_outlined, color: _text, size: 22),
              onPressed: () {}),
        ],
      );

  Widget _statsRow() => Row(children: [
        _stat('Today', '$_todayCount', _C.primary),
        const SizedBox(width: 10),
        _stat('Confirmed', '$_confirmedCount', _C.online),
        const SizedBox(width: 10),
        _stat('Pending', '$_pendingCount', _C.amber),
        const SizedBox(width: 10),
        _stat('Done', '$_completedCount', _C.accent),
      ]);

  Widget _stat(String label, String value, Color color) => Expanded(
          child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _border)),
        child: Column(children: [
          Text(value,
              style: GoogleFonts.plusJakartaSans(
                  color: color, fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 3),
          Text(label, style: GoogleFonts.dmSans(color: _sub, fontSize: 10)),
        ]),
      ));

  Widget _dayPicker() {
    final days =
        List.generate(7, (i) => DateTime.now().add(Duration(days: i - 2)));
    return SizedBox(
        height: 72,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: days.length,
          itemBuilder: (_, i) {
            final d = days[i];
            final sel = d.year == _selectedDay.year &&
                d.month == _selectedDay.month &&
                d.day == _selectedDay.day;
            final tod = d.year == DateTime.now().year &&
                d.month == DateTime.now().month &&
                d.day == DateTime.now().day;
            return GestureDetector(
                onTap: () {
                  setState(() => _selectedDay = d);
                  _loadAppointments();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 52,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      gradient: sel ? _C.grad : null,
                      color: sel ? null : _card,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: sel
                              ? Colors.transparent
                              : tod
                                  ? _C.primary.withOpacity(.4)
                                  : _border)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat('EEE').format(d).toUpperCase(),
                            style: GoogleFonts.dmSans(
                                color: sel ? Colors.white70 : _sub,
                                fontSize: 10)),
                        const SizedBox(height: 4),
                        Text('${d.day}',
                            style: GoogleFonts.plusJakartaSans(
                                color: sel ? Colors.white : _text,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ]),
                ));
          },
        ));
  }

  Widget _empty() => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _border)),
        child: Column(children: [
          Icon(Icons.event_available_rounded, color: _sub, size: 40),
          const SizedBox(height: 12),
          Text('No appointments today',
              style: GoogleFonts.plusJakartaSans(
                  color: _text, fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Pull down to refresh',
              style: GoogleFonts.dmSans(color: _sub, fontSize: 13)),
        ]),
      );
}

class _AgendaCard extends StatelessWidget {
  final _Appt a;
  final bool isDark;
  final Color card, card2, border, textC, sub;
  final VoidCallback onAccept, onReject, onComplete, onJoin;
  const _AgendaCard(
      {required this.a,
      required this.isDark,
      required this.card,
      required this.card2,
      required this.border,
      required this.textC,
      required this.sub,
      required this.onAccept,
      required this.onReject,
      required this.onComplete,
      required this.onJoin});

  bool get _isNow {
    final now = DateTime.now();
    final parts = a.startTime.split(':');
    if (parts.length < 2) return false;
    final sh = int.tryParse(parts[0]) ?? 0;
    final sm = int.tryParse(parts[1]) ?? 0;
    return now.hour == sh && now.minute >= sm && now.minute < sm + 60;
  }

  (Color, Color, String, IconData) get _stCfg {
    switch (a.status) {
      case _Status.confirmed:
        return (
          _C.online.withOpacity(.15),
          _C.online,
          'Confirmed',
          Icons.check_circle_outline_rounded
        );
      case _Status.pending:
        return (
          _C.amber.withOpacity(.15),
          _C.amber,
          'Pending',
          Icons.schedule_rounded
        );
      case _Status.completed:
        return (
          _C.accent.withOpacity(.15),
          _C.accent,
          'Completed',
          Icons.task_alt_rounded
        );
      case _Status.cancelled:
        return (
          _C.error.withOpacity(.15),
          _C.error,
          'Cancelled',
          Icons.cancel_outlined
        );
      case _Status.rescheduled:
        return (
          _C.primary.withOpacity(.15),
          _C.primary,
          'Rescheduled',
          Icons.event_repeat_rounded
        );
      case _Status.noShow:
        return (
          Colors.grey.withOpacity(.15),
          Colors.grey,
          'No show',
          Icons.person_off_outlined
        );
    }
  }

  (IconData, String) get _tpCfg {
    switch (a.type) {
      case _Type.video:
        return (Icons.videocam_rounded, 'Video');
      case _Type.call:
        return (Icons.phone_rounded, 'Call');
      case _Type.inPerson:
        return (Icons.location_on_rounded, 'In-person');
    }
  }

  @override
  Widget build(BuildContext context) {
    final (sBg, sFg, sLbl, sIco) = _stCfg;
    final (tIco, tLbl) = _tpCfg;
    final initials = a.patientName
        .split(' ')
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0].toUpperCase())
        .join();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: _isNow ? _C.primary.withOpacity(.5) : border,
              width: _isNow ? 1.5 : .5)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        IntrinsicHeight(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
              width: 56,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF0D0D20)
                      : const Color(0xFFEDE9FE),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(a.startTime,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                            color: _C.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                    if (_isNow) ...[
                      const SizedBox(height: 4),
                      Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              color: _C.online, shape: BoxShape.circle))
                    ],
                  ])),
          Container(
              width: 3,
              decoration: BoxDecoration(
                  gradient: _isNow
                      ? const LinearGradient(
                          colors: [_C.primary, _C.secondary],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)
                      : LinearGradient(colors: [border, border]))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: a.patientPhoto == null
                                      ? const LinearGradient(colors: [
                                          Color(0xFF38BDF8),
                                          Color(0xFF818CF8)
                                        ])
                                      : null,
                                  image: a.patientPhoto != null
                                      ? DecorationImage(
                                          image: NetworkImage(a.patientPhoto!),
                                          fit: BoxFit.cover)
                                      : null),
                              child: a.patientPhoto == null
                                  ? Center(
                                      child: Text(initials,
                                          style: GoogleFonts.plusJakartaSans(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700)))
                                  : null),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Row(children: [
                                  Expanded(
                                      child: Text(a.patientName,
                                          style: GoogleFonts.plusJakartaSans(
                                              color: textC,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis)),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: sBg,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(sIco, color: sFg, size: 10),
                                            const SizedBox(width: 3),
                                            Text(sLbl,
                                                style: GoogleFonts.dmSans(
                                                    color: sFg,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ])),
                                ]),
                                const SizedBox(height: 3),
                                Row(children: [
                                  Icon(tIco, color: sub, size: 12),
                                  const SizedBox(width: 4),
                                  Text(tLbl,
                                      style: GoogleFonts.dmSans(
                                          color: sub, fontSize: 12)),
                                ]),
                              ])),
                        ]),
                        if (a.reason != null && a.reason!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF1A1A35)
                                      : const Color(0xFFF0EEFF),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(children: [
                                Icon(Icons.notes_rounded, color: sub, size: 13),
                                const SizedBox(width: 6),
                                Expanded(
                                    child: Text(a.reason!,
                                        style: GoogleFonts.dmSans(
                                            color: sub, fontSize: 12),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis)),
                              ])),
                        ],
                      ]))),
        ])),
        if (a.status == _Status.pending || a.status == _Status.confirmed)
          Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: border, width: .5))),
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              if (a.status == _Status.pending) ...[
                Expanded(
                    child: _btn('Accept', Icons.check_rounded, _C.online,
                        _C.online.withOpacity(.12), onAccept)),
                const SizedBox(width: 8),
                Expanded(
                    child: _btn('Reject', Icons.close_rounded, _C.error,
                        _C.error.withOpacity(.08), onReject)),
              ] else ...[
                if (a.type == _Type.video) ...[
                  Expanded(
                      child: _gradBtn(
                          'Join call', Icons.videocam_rounded, onJoin)),
                  const SizedBox(width: 8),
                ],
                Expanded(
                    child: _btn('Mark done', Icons.task_alt_rounded, _C.accent,
                        _C.accent.withOpacity(.1), onComplete)),
              ],
            ]),
          ),
      ]),
    );
  }

  Widget _btn(
          String label, IconData icon, Color tc, Color bg, VoidCallback fn) =>
      GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          fn();
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: bg, borderRadius: BorderRadius.circular(12)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon, color: tc, size: 14),
              const SizedBox(width: 5),
              Text(label,
                  style: GoogleFonts.dmSans(
                      color: tc, fontSize: 12, fontWeight: FontWeight.w600)),
            ])),
      );

  Widget _gradBtn(String label, IconData icon, VoidCallback fn) =>
      GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          fn();
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                gradient: _C.gradBlue, borderRadius: BorderRadius.circular(12)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon, color: Colors.white, size: 14),
              const SizedBox(width: 5),
              Text(label,
                  style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ])),
      );
}
