# LexigoMeeting Assistant - AI-Powered Realtime Coaching & Negotiation Support

## Overview
LexigoMeeting Assistant is a **Flutter-based AI meeting companion** that provides **real-time transcription, strategic advice, and coaching**. It listens to conversations, transcribes them using **OpenAI's Realtime API**, and offers **AI-driven negotiation strategies, insights, and information** powered by GPT-4. 

Designed to run **separately on a mobile device or tablet**, LexigoMeeting Assistant listens via the **built-in microphone**, making it perfect for **Zoom calls, business meetings, and in-person discussions.**

## Features
- **Live Transcription & Speech Analysis** (OpenAI Realtime API)
- **AI-Powered Meeting Advice & Negotiation Coaching** (GPT-4)
- **Simple UI** (Start/Stop Recording, Live Feedback Display)
- **Configurable Transcription Timing (5s, 10s, or Manual Hold-to-Listen Mode)**
- **User Context Input Before Calls for Personalized AI Insights**
- **Personalized Knowledge Base for User Profiles**
- **Visual Indicator for Active Listening Status**
- **Runs as a Standalone Mobile/Tablet App** (No need for system audio capture)
- **Subscription Model for Premium Features** (Stripe Integration)
- **Cross-Platform Support** (iOS, Android)

## Tech Stack
- **Flutter (Dart)** for mobile app development
- **OpenAI Realtime API** for low-latency Speech-to-Text
- **OpenAI GPT-4 API** for AI-driven feedback and coaching
- **Firebase** for storing user profiles and knowledge base
- **Stripe** for subscription management

---

## Setup Instructions

### 1. Clone Repository
```sh
git clone https://github.com/yourusername/ai-meeting-assistant.git
cd ai-meeting-assistant
```

### 2. Install Dependencies
```sh
flutter pub get
```

### 3. Configure API Keys
Create a `.env` file and add your keys:
```
OPENAI_API_KEY=your-openai-key
STRIPE_SECRET_KEY=your-stripe-key
FIREBASE_API_KEY=your-firebase-api-key
```

### 4. Run the App
For iOS:
```sh
flutter run --release
```
For Android:
```sh
flutter run
```

---

## Core Flutter Code (lib/main.dart)
```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

void main() => runApp(LexigoMeetingApp());

class LexigoMeetingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MeetingAssistantScreen(),
    );
  }
}

class MeetingAssistantScreen extends StatefulWidget {
  @override
  _MeetingAssistantScreenState createState() => _MeetingAssistantScreenState();
}

class _MeetingAssistantScreenState extends State<MeetingAssistantScreen> {
  String _transcription = "";
  String _aiAdvice = "";
  bool _isListening = false;
  String _userContext = "";
  String _userProfileData = "";

  Future<void> getUserProfile() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc('user123').get();
    if (snapshot.exists) {
      setState(() {
        _userProfileData = snapshot.data()?['profile'] ?? "";
      });
    }
  }
  
  Future<void> getGPTAdvice(String text) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer YOUR_OPENAI_API_KEY',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-4o-realtime-preview-2024-12-17",
        "messages": [
          {"role": "system", "content": "You are an AI meeting assistant designed to listen to conversations and provide real-time insights, advice, encouragement, and negotiation strategies. You analyze discussions to offer timely, relevant, and professional support. Consider the following user profile and context for enhanced personalization:\n\nUser Profile: $_userProfileData\nContext: $_userContext"},
          {"role": "user", "content": text}
        ]
      }),
    );

    setState(() {
      _aiAdvice = jsonDecode(response.body)['choices'][0]['message']['content'];
    });
  }

  Future<void> startListening() async {
    setState(() {
      _isListening = true;
    });
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/realtime/transcribe'),
      headers: {
        'Authorization': 'Bearer YOUR_OPENAI_API_KEY',
        'Content-Type': 'application/json',
      },
    );
    
    final transcriptionResult = jsonDecode(response.body);
    setState(() {
      _transcription = transcriptionResult['transcript'];
    });
    getGPTAdvice(_transcription);
  }

  void stopListening() {
    setState(() {
      _isListening = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LexigoMeeting Assistant")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _userContext = value;
                });
              },
              decoration: InputDecoration(labelText: "Enter Meeting Context"),
            ),
            SizedBox(height: 10),
            if (_isListening) Icon(Icons.mic, color: Colors.red, size: 40),
            ElevatedButton(
              onPressed: _isListening ? stopListening : startListening,
              child: Text(_isListening ? "Stop Listening" : "Start Listening"),
            ),
            SizedBox(height: 20),
            Text("Live Transcription:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_transcription, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("AI Advice:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_aiAdvice, style: TextStyle(fontSize: 16, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
```
