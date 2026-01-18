# Swift Pay iOS App

This project demonstrates a **professional iOS application** built using **Swift**, **MVVM + Coordinator architecture**, and follows best practices suitable for production-ready apps. 
---

## Overview

The Wallet App allows users to:

- View current wallet balance
- Add money with real-time input validation
- Transfer money with balance checks
- Receive immediate feedback for invalid input

The app demonstrates:
- Clean MVVM architecture with Coordinators
- Reactive UI updates using **Combine**
- Unit testing using **XCTest**
- Centralized validation logic
- Keyboard management and responsive UI

---

## Technical Highlights

- **Language & Frameworks:** Swift, UIKit, Foundation, Combine
- **Architecture:** MVVM + Coordinator pattern, SOLID principles
- **Validation:** Centralized, reusable, robust for real-world scenarios
- **Testing:** Unit tests for parsing, validators, and ViewModels
- **CI/CD:** Can be integrated with Bitrise or other CI/CD tools
- **Version Control:** Git with Git Flow workflow

---

## Features

1. **Add Money:**
   - Real-time validation of input
   - Minimum amount enforcement
   - Buttons enable/disable based on input state

2. **Transfer Money:**
   - Checks against current wallet balance
   - Displays errors for insufficient funds
   - Supports optional notes for transactions

3. **User Experience:**
   - Clear error messages for invalid input
   - Keyboard avoidance for better layout
   - Consistent currency formatting

---

## Architecture & Design Principles

- **MVVM:** Separates UI logic from business logic for maintainability
- **Coordinator Pattern:** Manages navigation, keeps ViewControllers clean
- **SOLID Principles:** Applied in ViewModels, Validators, and Services
- **Combine:** Reactive programming for state management and UI updates

---

## Unit Testing

- `AmountParserTests.swift` demonstrates robust input parsing tests
- Covers:
  - Valid currency amounts
  - Invalid text inputs
  - Zero amounts
  - Whitespace handling
- Additional tests for edge cases like large numbers and negative amounts can be added for production readiness

---

## Skills Demonstrated

- Native iOS application development using Swift
- MVVM + Coordinator architecture
- XCTest unit testing
- Core iOS libraries: UIKit, Foundation, Combine
- REST API understanding
- Version control with Git
- Human Interface Guidelines adherence
- CI/CD and deployment readiness

Optional/Advanced skills touched:
- UI testing structure ready for XCUITest
- Modular design for validators and services
- Readiness for accessibility support

---

## Future Enhancements

- Add automated UI tests using XCUITest
- Support for multiple currencies and localization
- Persistence layer using CoreData or Realm
- CI/CD integration with Bitrise or GitHub Actions
- Feature flagging for Add/Transfer functionality
- Accessibility compliance for UI elements

---

## How to Run

1. Clone the repository
2. Open `SwiftPay.xcodeproj` in Xcode
3. Select a simulator or device
4. Build and run the project
5. Run Unit Tests (`Cmd + U`) to verify functionality

---

## Summary

This Wallet App demonstrates a **production-ready, professional iOS project**. It highlights **clean architecture**, **robust validation**, **unit testing**, and **user-focused design**, aligning with commercial iOS development standards.

