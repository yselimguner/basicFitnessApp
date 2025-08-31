# 🏃‍♂️ Basic Fitness Tracker App for iOS Using HealthKit  
*A lightweight fitness app that tracks your daily steps and heart rate using HealthKit, built with Swift and UIKit.*

## 📱 Overview

This app is a simple yet functional fitness tracker that integrates with **Apple HealthKit** to display:

- ✅ Your **daily step count**
- ✅ Your **step goal progress** (default: 15,000 steps)
- ❤️ Your **latest heart rate measurement**
- 🧠 Visual cues and dynamic UI updates based on available HealthKit data

It's perfect for beginners exploring HealthKit or developers building health-related features.

---

## 🔧 Features

- 📊 **Step Count Display:** Tracks today’s steps and updates UI accordingly.
- 🎯 **Progress Visualization:** Progress bar and percentage towards daily goal.
- ❤️ **Heart Rate Monitoring:** Displays latest heart rate, with estimated resting and active BPM ranges.
- 🧩 **Dynamic Views:** Hides or shows UI components depending on data availability.
- 🧪 **Tested with real HealthKit data** (on-device only).

---

## 🛠️ Technologies Used

- **Swift 5**
- **UIKit**
- **HealthKit**
- **Auto Layout** for responsive UI
- **HKStatisticsQuery**, **HKSampleQuery** for HealthKit data retrieval

---

## 📸 Screenshots

![Ekran Resmi 2025-08-31 - 18 25 51](https://github.com/user-attachments/assets/5d5a0a22-c92c-47c0-99a8-ea7399f551fe)

---

## 🔐 Permissions

The app requests **read-only access** to the following HealthKit data:

- Step Count (`HKQuantityTypeIdentifier.stepCount`)
- Heart Rate (`HKQuantityTypeIdentifier.heartRate`)

> ⚠️ Health data access only works on real devices with HealthKit enabled.

---

## 🚀 Getting Started

### Requirements

- Xcode 15+
- iOS 15.0+
- A real iOS device (HealthKit does not work on the simulator)

### Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/yselimguner/basicFitnessApp.git
