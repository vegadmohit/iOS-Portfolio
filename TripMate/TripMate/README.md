# TripMate iOS App


TripMate is a professional iOS application that helps users discover popular attractions and trending places in their city. Built with **Swift** and following **MVVM + Coordinator architecture**, TripMate demonstrates clean code, modern iOS best practices, and unit-tested components suitable for production-ready apps.

---

## Overview
The app allows users to:

- Browse **Attraction Places** and **Trending Places** with smooth horizontal collection views inside table view cells.
- Fetch real-time data from the **Google Places API**.
- Tap on a place to navigate to its **detail view** using Coordinator pattern.

---

## Features

- **Attraction & Trending Places:** Horizontally scrollable collection views for each category.  
- **Async Data Fetching:** Fetches places using async/await from Google Places API.  
- **Error Handling:** Displays errors and handles empty states gracefully.  
- **Pull to Refresh:** Refresh table data with UI feedback.  
- **Navigation:** MVVM + Coordinator architecture ensures clean separation of navigation and UI logic.  
- **Unit Tested:** View models and use cases tested with XCTest using mock repositories.  
- **Responsive UI:** Handles dynamic layouts, keyboard management, and refresh controls.  

---

## Technical Highlights

- **Language & Platform:** Swift, iOS 15+, UIKit, Foundation, Combine  
- **Architecture:** MVVM + Coordinator, Repository Pattern, SOLID principles  
- **Networking:** REST API integration with Google Places API using async/await  
- **UI Patterns:** UITableView with horizontal UICollectionView cells  
- **Testing:** XCTest unit tests with mock repositories for isolation  
- **Version Control:** Git with Git Flow workflow  
- **Design Practices:** Human Interface Guidelines, responsive UI, modular components  
- **Deployment:** App Store ready, tested on simulator and physical devices  

---

## Architecture & Design Patterns

- **MVVM + Coordinator:** Separates UI, business logic, and navigation, allowing clean scalability.  
- **Repository Pattern:** Decouples network layer from use cases for testable and maintainable code.  
- **Async/Await Networking:** Swift concurrency ensures smooth, responsive UI updates.  
- **SOLID Principles:** Ensures modular, reusable, and maintainable code.  
- **Unit Testing:** HomeViewModelTests cover success, failure, and refresh scenarios.  

---

## Unit Testing

- `HomeViewModelTests` verifies:
  - Data fetching updates sections correctly.
  - Error handling works when the repository fails.
  - Refresh triggers fetch logic.
- Uses **XCTest** and **mock repositories** for isolated testing.  


