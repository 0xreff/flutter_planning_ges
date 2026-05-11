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
// MyPlannings.dart — Planning Module Screen 1
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
}

enum _Status { pending, confirmed, completed, cancelled, rescheduled, noShow }

enum _Type { inPerson, video, call }

enum _Tab { upcoming, past, cancelled }

class _Appt {
  final String id, doctorId, doctorName, doctorSpecialty, startTime;
  final String? doctorPhoto, reason, videoCallUrl, slotId;
  final _Status status;
  final _Type type;
  final DateTime date, createdAt;

  const _Appt({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.startTime,
    this.doctorPhoto,
    this.reason,
    this.videoCallUrl,
    this.slotId,
    required this.status,
    required this.type,
    required this.date,
    required this.createdAt,
  });
}

class MyPlannings extends StatefulWidget {
  const MyPlannings({super.key, required this.width, required this.height});
  final double? width, height;
  @override
  State<MyPlannings> createState() => _MyPlanningsState();
}

class _MyPlanningsState extends State<MyPlannings>
    with SingleTickerProviderStateMixin {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late final TabController _tabCtrl;
  bool _isDark = true, _themeInit = false;

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
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  Stream<List<_Appt>> _stream(_Tab tab) {
    Query q = _db
        .collection('appointments')
        .where('patientId', isEqualTo: _uid)
        .orderBy('date', descending: tab == _Tab.past);
    if (tab == _Tab.upcoming) {
      q = q.where('status', whereIn: [
        'pending',
        'confirmed',
        'rescheduled'
      ]).where('date',
          isGreaterThanOrEqualTo: Timestamp.fromDate(
              DateTime.now().subtract(const Duration(hours: 1))));
    } else if (tab == _Tab.past) {
      q = q.where('status', whereIn: ['completed', 'no_show']);
    } else {
      q = q.where('status', isEqualTo: 'cancelled');
    }
    return q.snapshots().asyncMap(_enrich);
  }

  Future<List<_Appt>> _enrich(QuerySnapshot snap) async {
    final out = <_Appt>[];
    for (final doc in snap.docs) {
      final d = doc.data() as Map<String, dynamic>;
      final did = d['doctorId'] ?? '';
      String name = 'Unknown Doctor', spec = '';
      String? photo;
      if (did.isNotEmpty) {
        final dr = await _db.collection('doctors').doc(did).get();
        if (dr.exists) {
          name = dr.data()!['display_name'] ?? 'Unknown Doctor';
          spec = dr.data()!['speciality'] ?? '';
          photo = dr.data()!['photo_url'];
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
      out.add(_Appt(
        id: doc.id,
        doctorId: did,
        doctorName: name,
        doctorSpecialty: spec,
        doctorPhoto: photo,
        status: st,
        type: tp,
        date: (d['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
        createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        startTime: d['startTime'] ?? '',
        reason: d['reason'],
        videoCallUrl: d['videoCallUrl'],
        slotId: d['slotId'],
      ));
    }
    return out;
  }

  Future<void> _cancel(String apptId, String? slotId) async {
    final b = _db.batch();
    b.update(_db.collection('appointments').doc(apptId), {
      'status': 'cancelled',
      'cancelledBy': 'patient',
      'updatedAt': FieldValue.serverTimestamp(),
    });
    if (slotId != null && slotId.isNotEmpty) {
      b.update(_db.collection('slots').doc(slotId),
          {'isBooked': false, 'appointmentId': null});
    }
    await b.commit();
  }

  Future<void> _confirmCancel(BuildContext ctx, _Appt a) async {
    final ok = await showDialog<bool>(
      context: ctx,
      builder: (_) => AlertDialog(
        backgroundColor: _card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Cancel appointment?',
            style: GoogleFonts.plusJakartaSans(
                color: _text, fontWeight: FontWeight.w600)),
        content: Text(
            '${a.doctorName} · ${DateFormat('EEE d MMM').format(a.date)} at ${a.startTime}',
            style: GoogleFonts.dmSans(color: _sub, fontSize: 13)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text('Keep it',
                  style: GoogleFonts.dmSans(color: _C.primary))),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child:
                  Text('Cancel', style: GoogleFonts.dmSans(color: _C.error))),
        ],
      ),
    );
    if (ok == true) await _cancel(a.id, a.slotId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surface,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [_appBar(), _tabBarSliver()],
        body: TabBarView(
            controller: _tabCtrl,
            children: _Tab.values.map((t) => _body(t)).toList()),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => context.pushNamed('SlotPickerCalender'),
        child: Container(
            width: 52,
            height: 52,
            decoration:
                BoxDecoration(gradient: _C.grad, shape: BoxShape.circle),
            child:
                const Icon(Icons.add_rounded, color: Colors.white, size: 24)),
      ),
    );
  }

  SliverAppBar _appBar() => SliverAppBar(
        pinned: true,
        expandedHeight: 90,
        backgroundColor: _surface,
        elevation: 0,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(left: 20, bottom: 14),
          title: Text('My Appointments',
              style: GoogleFonts.plusJakartaSans(
                  color: _text, fontSize: 20, fontWeight: FontWeight.w700)),
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
          const SizedBox(width: 8),
        ],
      );

  SliverPersistentHeader _tabBarSliver() => SliverPersistentHeader(
        pinned: true,
        delegate: _TabDelegate(
            TabBar(
              controller: _tabCtrl,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  gradient: _C.grad, borderRadius: BorderRadius.circular(20)),
              labelStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 12, fontWeight: FontWeight.w600),
              unselectedLabelStyle: GoogleFonts.dmSans(fontSize: 12),
              labelColor: Colors.white,
              unselectedLabelColor: _sub,
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Past'),
                Tab(text: 'Cancelled')
              ],
            ),
            _card,
            _border),
      );

  Widget _body(_Tab tab) => StreamBuilder<List<_Appt>>(
        stream: _stream(tab),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(color: _C.primary));
          final items = snap.data ?? [];
          if (items.isEmpty) return _empty(tab, ctx);
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            itemCount: items.length,
            itemBuilder: (_, i) => _Card(
                appt: items[i],
                isDark: _isDark,
                card: _card,
                card2: _card2,
                border: _border,
                textC: _text,
                sub: _sub,
                onCancel: () => _confirmCancel(ctx, items[i]),
                onReschedule: () => context.pushNamed('SlotPickerCalender'),
                onJoinCall: () {
                  if (items[i].videoCallUrl != null &&
                      items[i].videoCallUrl!.isNotEmpty) {
                    launchURL(items[i].videoCallUrl!);
                  }
                }),
          );
        },
      );

  Widget _empty(_Tab tab, BuildContext ctx) => Center(
          child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  gradient: _C.grad, borderRadius: BorderRadius.circular(24)),
              child: const Icon(Icons.calendar_month_rounded,
                  color: Colors.white, size: 36)),
          const SizedBox(height: 20),
          Text(
              tab == _Tab.upcoming
                  ? 'No upcoming appointments'
                  : tab == _Tab.past
                      ? 'No past appointments'
                      : 'No cancelled appointments',
              style: GoogleFonts.plusJakartaSans(
                  color: _text, fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(
              tab == _Tab.upcoming
                  ? 'Book an appointment\nwith a doctor to get started.'
                  : 'Your appointments will appear here.',
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.dmSans(color: _sub, fontSize: 14, height: 1.5)),
          if (tab == _Tab.upcoming) ...[
            const SizedBox(height: 28),
            GestureDetector(
              onTap: () => context.pushNamed('SlotPickerCalender'),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
                decoration: BoxDecoration(
                    gradient: _C.grad, borderRadius: BorderRadius.circular(16)),
                child: Text('Book appointment',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ]),
      ));
}

class _Card extends StatelessWidget {
  final _Appt appt;
  final bool isDark;
  final Color card, card2, border, textC, sub;
  final VoidCallback onCancel, onReschedule, onJoinCall;

  const _Card(
      {required this.appt,
      required this.isDark,
      required this.card,
      required this.card2,
      required this.border,
      required this.textC,
      required this.sub,
      required this.onCancel,
      required this.onReschedule,
      required this.onJoinCall});

  bool get _isToday {
    final n = DateTime.now();
    return appt.date.year == n.year &&
        appt.date.month == n.month &&
        appt.date.day == n.day;
  }

  bool get _canJoin =>
      appt.type == _Type.video && appt.status == _Status.confirmed && _isToday;
  bool get _isUpcoming =>
      appt.status == _Status.pending ||
      appt.status == _Status.confirmed ||
      appt.status == _Status.rescheduled;

  (Color, Color, String, IconData) get _statusCfg {
    switch (appt.status) {
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
      case _Status.rescheduled:
        return (
          _C.primary.withOpacity(.15),
          _C.primary,
          'Rescheduled',
          Icons.event_repeat_rounded
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
      case _Status.noShow:
        return (
          Colors.grey.withOpacity(.15),
          Colors.grey,
          'No show',
          Icons.person_off_outlined
        );
    }
  }

  (IconData, String) get _typeCfg {
    switch (appt.type) {
      case _Type.video:
        return (Icons.videocam_rounded, 'Video call');
      case _Type.call:
        return (Icons.phone_rounded, 'Phone call');
      case _Type.inPerson:
        return (Icons.location_on_rounded, 'In-person');
    }
  }

  @override
  Widget build(BuildContext context) {
    final (sBg, sFg, sLbl, sIco) = _statusCfg;
    final (tIco, tLbl) = _typeCfg;
    final initials = appt.doctorName
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
              color: _isToday && appt.status == _Status.confirmed
                  ? _C.primary.withOpacity(.4)
                  : border,
              width: _isToday && appt.status == _Status.confirmed ? 1.5 : .5)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: appt.doctorPhoto == null ? _C.grad : null,
                      image: appt.doctorPhoto != null
                          ? DecorationImage(
                              image: NetworkImage(appt.doctorPhoto!),
                              fit: BoxFit.cover)
                          : null),
                  child: appt.doctorPhoto == null
                      ? Center(
                          child: Text(initials,
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)))
                      : null),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      Expanded(
                          child: Text(appt.doctorName,
                              style: GoogleFonts.plusJakartaSans(
                                  color: textC,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis)),
                      const SizedBox(width: 8),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: sBg,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(sIco, color: sFg, size: 11),
                            const SizedBox(width: 4),
                            Text(sLbl,
                                style: GoogleFonts.dmSans(
                                    color: sFg,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                          ])),
                    ]),
                    const SizedBox(height: 4),
                    Text(appt.doctorSpecialty,
                        style: GoogleFonts.dmSans(color: sub, fontSize: 12)),
                    const SizedBox(height: 6),
                    Row(children: [
                      Icon(Icons.calendar_today_rounded,
                          color: _C.primary, size: 13),
                      const SizedBox(width: 5),
                      Text(DateFormat('EEE, d MMM yyyy').format(appt.date),
                          style: GoogleFonts.dmSans(
                              color: textC,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 10),
                      Icon(Icons.schedule_rounded, color: _C.primary, size: 13),
                      const SizedBox(width: 4),
                      Text(appt.startTime,
                          style: GoogleFonts.dmSans(
                              color: textC,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                    ]),
                    const SizedBox(height: 4),
                    Row(children: [
                      Icon(tIco, color: sub, size: 13),
                      const SizedBox(width: 4),
                      Text(tLbl,
                          style: GoogleFonts.dmSans(color: sub, fontSize: 12)),
                    ]),
                  ])),
            ])),
        if (appt.reason != null && appt.reason!.isNotEmpty)
          Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: card2,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: border)),
                  child: Row(children: [
                    Icon(Icons.notes_rounded, color: sub, size: 14),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Text(appt.reason!,
                            style: GoogleFonts.dmSans(color: sub, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)),
                  ]))),
        if (_isUpcoming)
          Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: border, width: .5))),
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              if (_canJoin) ...[
                Expanded(
                    child: _Btn(
                        label: 'Join call',
                        icon: Icons.videocam_rounded,
                        gradient: const LinearGradient(
                            colors: [Color(0xFF38BDF8), Color(0xFF818CF8)]),
                        textColor: Colors.white,
                        onTap: onJoinCall)),
                const SizedBox(width: 8),
              ],
              if (appt.status != _Status.rescheduled) ...[
                Expanded(
                    child: _Btn(
                        label: 'Reschedule',
                        icon: Icons.event_repeat_rounded,
                        bgColor: _C.primary.withOpacity(.1),
                        textColor: _C.primary,
                        onTap: onReschedule)),
                const SizedBox(width: 8),
              ],
              Expanded(
                  child: _Btn(
                      label: 'Cancel',
                      icon: Icons.close_rounded,
                      bgColor: _C.error.withOpacity(.08),
                      textColor: _C.error,
                      onTap: onCancel)),
            ]),
          ),
      ]),
    );
  }
}

class _Btn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color textColor;
  final Gradient? gradient;
  final Color? bgColor;
  final VoidCallback onTap;
  const _Btn(
      {required this.label,
      required this.icon,
      required this.textColor,
      required this.onTap,
      this.gradient,
      this.bgColor});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
              color: bgColor,
              gradient: gradient,
              borderRadius: BorderRadius.circular(12)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: textColor, size: 14),
            const SizedBox(width: 5),
            Text(label,
                style: GoogleFonts.dmSans(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ]),
        ),
      );
}

class _TabDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color bg, border;
  const _TabDelegate(this.tabBar, this.bg, this.border);
  @override
  double get minExtent => 52;
  @override
  double get maxExtent => 52;
  @override
  Widget build(_, __, ___) => Container(
      color: bg,
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: border, width: .5))),
          child: tabBar));
  @override
  bool shouldRebuild(_TabDelegate o) =>
      o.tabBar != tabBar || o.bg != bg || o.border != border;
}
