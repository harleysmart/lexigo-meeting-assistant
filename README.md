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

## Contributing
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a Pull Request.

---

## License
This project is licensed under the MIT License - see the LICENSE file for details.

