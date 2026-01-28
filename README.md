# ⏱️ Berlin Clock (Mengenlehreuhr) -- SwiftUI

The **Mengenlehreuhr** (Berlin Clock) implemented in SwiftUI.

## 📖 About

The **Mengenlehreuhr** (German for “Set Theory Clock”), also known as the **Berlin Clock**, is the first public clock in the world that tells the time by means of **illuminated, coloured fields**, for which it entered the **Guinness Book of Records** upon its installation on **17 June 1975**.

Commissioned by the **Senate of Berlin** and designed by **Dieter Binninger**, the original full-sized Mengenlehreuhr was originally located at the **Kurfürstendamm** on the corner with **Uhlandstraße**. After the Senate decommissioned it in 1995, the clock was relocated to a site in **Budapester Straße** in front of **Europa-Center**, where it stands today.

This characteristic clock tells the time using a series of illuminated coloured blocks and it is read from top to bottom.

<img src="https://upload.wikimedia.org/wikipedia/commons/4/4f/Berlin-Uhr-1650-1705.gif" alt="Berlin clock GIF image">

## 🧠 How the Berlin Clock Works
- **Seconds Lamp**: The circular light at the top On (Red color) → Even seconds and Off → Odd seconds
- **Five-Hour Lamp Row**: 4 lamps. On (Red) when active.
- **One-Hour Lamp Row**: 4 lamps. On (Red) when active.
- **Five-Minute Lamp Row**: 11 lamps. On (Yellow), except every 3rd lamp (quarters) which is Red.
- **One-Minute Lamp Row**: 4 lamps. On (Yellow) when active.


## 🏗️ Architecture
```bash
BerlinClock
│
├── Model
│   └── DigitalTime               # Converts hours, minutes and seconds into struct and validates & throws error if out of bounds
│   └── BerlinClockLamp           # Contains data of hours, minutes and seconds lamp states
│
├── Data
│   └── BerlinClockTimeProvider   # Accepts date object and conevrt and return into DigitalTime
│
├── View
│   └── BerlinClockContentView    # Timer(TimeLineView) triggers view model to convert Date to Berlin lamps every second. On error, shows error in view
│
├── Domain
│   ├── BerlinClockEngine         # Converts digital time into berlin clock lamps
│   └── TimeValidationError       # Contains hours, minutes and seconds error out of bounds description
│   └── LampState                 # Lamp state (off, red, yellow)
│
├── ViewModel (MVVM)
│   └── BerlinClockViewModel      # Responsible to get the Berlin lamp and publish error if out of bounds exception
│
└── App
    └── BerlinClockApp.swift      # App entry point
  ```

## 🔑 Key Principle
- **MVVM + Observation**: Leveraging the new @Observable macro.
- **Dependency Injection**: Built for easy mocking and testability.
- **Protocol-Oriented**: Decoupled logic from platform-specific code.

## 🧩 Technologies Used
- **Swift 6**: Utilizing the latest concurrency and safety features.
- **SwiftUI & iOS 18+**: Optimized for the latest Apple platforms.
- **@Observable**: Modern state management without ObservableObject.
- **TimelineView**: High-efficiency updates for clock faces.
- **Swift Testing**: Using the modern import Testing framework.
- **Light & Dark Mode**: Automatically adapts to system appearance using prefers-color-scheme.

## 🧪 Test-Driven Development (TDD)

Quality is not an afterthought in this project. The Berlin Clock was developed using a strict **Red → Green → Refactor** workflow to ensure correctness, clarity, and long-term maintainability.

### 🔴 Red → 🟢 Green → 🔵 Refactor

- **Red**: Write failing tests that describe the desired behavior  
- **Green**: Implement the minimum logic to make tests pass  
- **Refactor**: Improve structure and readability without changing behavior  

## ⚙️ Core Engine Responsibilities

The **BerlinClockEngine** encapsulates all clock conversion logic and is fully covered by unit tests.

### Time Representation

- **Seconds Lamp**
  - Blinks every **two seconds**
- **5-Hour Row**
  - Four **red lamps**
  - Each lamp represents **5 hours**
- **1-Hour Row**
  - Four **red lamps**
  - Each lamp represents **1 hour**
- **5-Minute Row**
  - Eleven lamps  
  - **Red lamps** represent quarter hours (15, 30, 45)  
  - **Yellow lamps** represent all other 5-minute intervals
- **1-Minute Row**
  - Four **yellow lamps**
  - Each lamp represents **1 minute**

## ✅ Test Coverage

The test suite validates both **normal** and **edge-case** behavior:

- Berlin Clock conversion logic for **all hour and minute combinations**
- Boundary conditions:
  - `00:00:00` (Midnight)
  - `23:59:59` (Last second of the day)
- Deterministic logic validation using the **Swift Testing** framework

## 🧩 Mocking & Isolation

To ensure fast, reliable, and isolated tests:

- **Protocol-based mocking**
  - Time providers are abstracted behind protocols
- **Isolated engine testing**
  - `BerlinClockEngine` is tested independently of the UI and system clock
- **Dependency Injection**
  - Allows full control over time inputs during testing


## 🚀 Getting Started
- Clone the repository:
```bash
git clone https://github.com/2026-DEV2-23/BerlinClock.git
  ```
- Open the project in Xcode **16.4+**
- Ensure deployment target is set to iOS **18.0+**
- Run the app on a simulator or device **(⌘ + R)**
- Execute the TDD suite using **⌘ + U**


## 🖼️ Screenshots
| Light mode    | Dark mode     |
| ------------- | ------------- |
| <img width="400" height="870" alt="BerlinClockLightMode" src="https://github.com/user-attachments/assets/c01113d2-40a4-4bee-a3cc-e580b28d85a4" />  | <img width="400" height="870" alt="BerlinClockDarkMode" src="https://github.com/user-attachments/assets/f38b587c-a36e-44d5-9825-f3ceff9cd46f" />  |
| <img width="400" height="870" alt="errorLightMode" src="https://github.com/user-attachments/assets/85bc2380-6932-45ba-9178-8a546174eb8c" />  | <img width="400" height="870" alt="errorDarkMode" src="https://github.com/user-attachments/assets/8ba9d40e-419e-479c-ad04-2142b25cf015" />  |

## 📖 References

- 🔗 [Wikipedia: Mengenlehreuhr (Berlin Clock) – English](https://en.wikipedia.org/wiki/Mengenlehreuhr)  
  Overview, history, and how the Berlin Clock works.

- 🔗 [Wikipedia: Berlin-Uhr – German](https://de.wikipedia.org/wiki/Berlin-Uhr)  
  Original German article with historical and technical context.

- 📚 [Atlas Obscura: Mengenlehreuhr](https://www.atlasobscura.com/places/mengenlehreuhr)  
  History, design, origin, and cultural significance of the clock.

- 🧪 [Berlin Clock Kata – Agile Katas](http://agilekatas.co.uk/katas/BerlinClock-Kata)  
  Popular programming kata for practicing TDD and clean architecture.



## 📄 License
This project is for educational and demonstration purposes.
