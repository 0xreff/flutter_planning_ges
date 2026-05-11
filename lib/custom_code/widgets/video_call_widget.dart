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

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoCallWidget extends StatefulWidget {
  const VideoCallWidget({
    super.key,
    this.width,
    this.height,
    required this.channelName,
    required this.openAiKey,
  });

  final double? width;
  final double? height;
  final String channelName;
  final String openAiKey;

  @override
  State<VideoCallWidget> createState() => _VideoCallWidgetState();
}

class _VideoCallWidgetState extends State<VideoCallWidget> {
  bool _isMuted = false;
  bool _cameraOff = false;
  bool _isSummarizing = false;
  bool _isListening = false;
  String _transcript = '';
  String _summary = '';

  Future<void> _summarize() async {
    if (_transcript.isEmpty) {
      Navigator.pop(context);
      return;
    }
    setState(() => _isSummarizing = true);

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.openAiKey}',
        },
        body: jsonEncode({
          'model': 'gpt-4o-mini',
          'messages': [
            {
              'role': 'system',
              'content':
                  'Tu es un assistant médical. Résume cette consultation en points clés: symptômes, diagnostic, traitement, prochaine étape.',
            },
            {
              'role': 'user',
              'content': _transcript,
            }
          ],
          'max_tokens': 500,
        }),
      );

      final data = jsonDecode(response.body);
      setState(() {
        _summary = data['choices'][0]['message']['content'];
        _isSummarizing = false;
      });

      // Save to Firestore
      await FirebaseFirestore.instance
          .collection('consultations')
          .doc(widget.channelName)
          .set({
        'summary': _summary,
        'transcript': _transcript,
        'channelName': widget.channelName,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      setState(() => _isSummarizing = false);
      Navigator.pop(context);
    }
  }

  void _endCall() async {
    setState(() => _isListening = false);
    await _summarize();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: Stack(
        children: [
          Container(
            color: Colors.black,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.videocam, color: Colors.white54, size: 64),
                  SizedBox(height: 16),
                  Text(
                    'Téléconsultation en cours...',
                    style: TextStyle(color: Colors.white54, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          if (_isListening || _transcript.isNotEmpty)
            Positioned(
              bottom: 120,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_isListening)
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Enregistrement...',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    const SizedBox(height: 4),
                    Text(
                      _transcript.isEmpty ? 'Parlez...' : _transcript,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          if (_isSummarizing)
            Positioned.fill(
              child: Container(
                color: Colors.black87,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Color(0xFF1D9E75)),
                      SizedBox(height: 16),
                      Text(
                        'Génération du résumé IA...',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (_summary.isNotEmpty)
            Positioned.fill(
              child: Container(
                color: Colors.black87,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.description,
                        color: Color(0xFF1D9E75), size: 40),
                    const SizedBox(height: 12),
                    const Text(
                      'Résumé de la consultation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            _summary,
                            style: const TextStyle(fontSize: 13, height: 1.5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1D9E75),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Fermer et sauvegarder ✓',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _button(
                  icon: _isListening ? Icons.hearing : Icons.hearing_disabled,
                  color: _isListening ? Colors.green : Colors.white,
                  bg: _isListening
                      ? Colors.green.withOpacity(0.3)
                      : Colors.black54,
                  onTap: () => setState(() => _isListening = !_isListening),
                ),
                const SizedBox(width: 14),
                _button(
                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                  color: _isMuted ? Colors.red : Colors.white,
                  onTap: () => setState(() => _isMuted = !_isMuted),
                ),
                const SizedBox(width: 14),
                _button(
                  icon: Icons.call_end,
                  color: Colors.white,
                  bg: Colors.red,
                  onTap: _endCall,
                ),
                const SizedBox(width: 14),
                _button(
                  icon: _cameraOff ? Icons.videocam_off : Icons.videocam,
                  color: _cameraOff ? Colors.red : Colors.white,
                  onTap: () => setState(() => _cameraOff = !_cameraOff),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({
    required IconData icon,
    required Color color,
    Color bg = Colors.black54,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}
