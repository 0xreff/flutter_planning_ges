import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDHKkV7mm-l5HUEKTCDt3I-eWABTXOq0Sk",
            authDomain: "medicare-app-c2656.firebaseapp.com",
            projectId: "medicare-app-c2656",
            storageBucket: "medicare-app-c2656.firebasestorage.app",
            messagingSenderId: "23223061286",
            appId: "1:23223061286:web:ed748f5f4ebf55f8478fe7",
            measurementId: "G-P0WTP0J4BN"));
  } else {
    await Firebase.initializeApp();
  }
}
