import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'teleconsultation_model.dart';
export 'teleconsultation_model.dart';

class TeleconsultationWidget extends StatefulWidget {
  const TeleconsultationWidget({super.key});

  static String routeName = 'teleconsultation';
  static String routePath = '/teleconsultation';

  @override
  State<TeleconsultationWidget> createState() => _TeleconsultationWidgetState();
}

class _TeleconsultationWidgetState extends State<TeleconsultationWidget> {
  late TeleconsultationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TeleconsultationModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFF1D9E75),
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.safePop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24.0,
            ),
          ),
          title: Text(
            'Teleconsultation',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.plusJakartaSans(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: StreamBuilder<List<AppointementsRecord>>(
            stream: queryAppointementsRecord(
              singleRecord: true,
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                );
              }
              List<AppointementsRecord> videoCallWidgetAppointementsRecordList =
                  snapshot.data!;
              // Return an empty Container when the item does not exist.
              if (snapshot.data!.isEmpty) {
                return Container();
              }
              final videoCallWidgetAppointementsRecord =
                  videoCallWidgetAppointementsRecordList.isNotEmpty
                      ? videoCallWidgetAppointementsRecordList.first
                      : null;

              return Container(
                width: double.infinity,
                height: double.infinity,
                child: custom_widgets.VideoCallWidget(
                  width: double.infinity,
                  height: double.infinity,
                  channelName: videoCallWidgetAppointementsRecord!.reference.id,
                  openAiKey:
                      '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',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
