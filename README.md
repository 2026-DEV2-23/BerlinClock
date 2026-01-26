⏱ Berlin Clock (SwiftUI)
📌 Overview

This project implements the Berlin Clock using SwiftUI.
The Berlin Clock is an alternative visual representation of time that uses illuminated lamps instead of traditional digits. Time is displayed across multiple rows, each representing different units of hours, minutes, and seconds.

The app updates in real time and follows modern iOS development best practices, including MVVM architecture and Test-Driven Development (TDD).

🕰 How It Works

The Berlin Clock consists of five distinct sections:

1️⃣ Seconds Lamp (Top Row)

A single circular lamp.

ON for even seconds.

OFF for odd seconds.

2️⃣ First Row – Hours (Multiples of 5)

4 lamps.

Each lamp represents 5 hours.

Maximum value: 20 hours.

3️⃣ Second Row – Hours (Multiples of 1)

4 lamps.

Each lamp represents 1 hour.

Completes the remaining hours after the first row.

4️⃣ Third Row – Minutes (Multiples of 5)

11 lamps.

Each lamp represents 5 minutes.

Every 3rd lamp (15, 30, 45 minutes) is highlighted differently to indicate quarter hours.

5️⃣ Fourth Row – Minutes (Multiples of 1)

4 lamps.

Each lamp represents 1 minute.

Completes the remaining minutes after the third row.

✅ Features

Built using SwiftUI with a fully declarative UI

Real-time clock updates

Accurate Berlin Clock logic

Clear separation of concerns using MVVM

Fully unit-tested business logic

Designed with Test-Driven Development (TDD)

Supports iOS 18 and above

🧪 Testing

Unit tests written using Swift Testing

Business logic fully covered

Time and timer behavior tested using mocked time providers

Focus on deterministic, fast, and reliable tests

🛠 Tech Stack

Language: Swift 6

UI Framework: SwiftUI

Architecture: MVVM + TDD

Testing: Swift Testing, XCTest

State Management: @Observable

IDE: Xcode 16+

Platform: iOS 18+

📋 Requirements

Xcode 16+

Swift 6

iOS 18 or later

🚀 Getting Started

Clone the repository:

git clone https://github.com/2026-DEV2-023/BerlinClock.git



Open the project in Xcode 16.4+

Select an iOS 18 simulator

Run the app ▶️

📄 License

This project is for educational and demonstration purposes.
Feel free to fork, modify, and experiment.
