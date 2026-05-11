// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:html' as html;
import 'dart:convert';

Future exportPDF(
  String? doctorId,
  String? speciality,
  String? startTime,
  String? status,
) async {
  final content = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    body { font-family: Arial; padding: 40px; max-width: 600px; margin: auto; }
    h2 { text-align: center; border-bottom: 2px solid #000; padding-bottom: 10px; }
    .field { margin: 15px 0; }
    .label { font-weight: bold; font-size: 13px; color: #555; }
    .value { font-size: 16px; margin-top: 4px; }
    .footer { text-align: center; margin-top: 40px; color: #888; font-size: 12px; }
    @media print { button { display: none; } }
  </style>
</head>
<body>
  <h2>RENDEZ-VOUS</h2>
  <div class="field">
    <div class="label">Docteur</div>
    <div class="value">${doctorId ?? 'N/A'}</div>
  </div>
  <div class="field">
    <div class="label">Specialite</div>
    <div class="value">${speciality ?? 'N/A'}</div>
  </div>
  <div class="field">
    <div class="label">Date</div>
    <div class="value">${startTime ?? 'N/A'}</div>
  </div>
  <div class="field">
    <div class="label">Statut</div>
    <div class="value">${status ?? 'N/A'}</div>
  </div>
  <div class="footer">Merci pour votre confiance</div>
  <br>
  <button onclick="window.print()">Imprimer / Sauvegarder PDF</button>
</body>
</html>
''';

  final bytes = utf8.encode(content);
  final blob = html.Blob([bytes], 'text/html');
  final url = html.Url.createObjectUrlFromBlob(blob);

  html.window.open(url, '_blank');

  Future.delayed(const Duration(seconds: 5), () {
    html.Url.revokeObjectUrl(url);
  });
}
