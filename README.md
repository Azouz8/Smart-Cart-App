# Smart Cart Mobile App
### Indoor Navigation • Real-Time Cart Sync • AI Recommendations • Online Payment

This repository contains the **mobile application** of the **Smart Cart System**, a full intelligent shopping experience integrating:

- IoT Smart Cart Hardware (ESP32 + AtMega32)
- Node.js Backend (APIs + Real-time updates)
- React Admin Dashboard (Inventory + Tracking)

This Flutter app acts as the **main customer interface inside the store**, enabling cart tracking, product search, indoor navigation, and online checkout.

---

## 🚀 Features

### 1. User–Cart Connection
Users connect to their smart cart by scanning the QR code attached to it.  
Once connected, the app stays synced with the cart in real time.

---

### 2. Real-Time Cart Products Tracking
Whenever the user scans a product using the barcode scanner on the smart cart:
- The item instantly appears inside the app  
- Showing:
  - Product name  
  - Quantity  
  - Price

All updates are synchronized via the backend.

---

### 3. Product Search + Indoor Navigation
Users can search for any product in the store and get:
- Exact product location  
- Navigation path from their current position  
- Dynamic map view using indoor positioning (Wi-Fi RSSI)

Perfect for large or complex store layouts.

---

### 4. AI-Based Product Recommendations
The app shows personalized suggestions based on:
- User purchase history  
- Previous transactions  
- Product relationships  
- User behavior patterns  

Recommendations improve as users shop more.

---

### 5. Online Payment Integration
Users can:
- Checkout directly inside the app  
- Pay using their credit card  or QR Code
- Avoid standing in long cashier queues  

Secure online payment eliminates manual checkout delays.

---

### 6. Order Ratings
- After purchasing, users can rate the products they bought.  
- These ratings help refine future AI recommendations and enhance personalization.

---

## Integration With Other Project Components

Although this repository contains **only the mobile app**, it fully integrates with:

### Backend (Node.js + Express + MongoDB)
- REST APIs for products, carts, users, payments
- WebSocket (Socket.io) for:
  - Real-time cart tracking  
- AI recommendation engine endpoints
- Authentication & user management

### IoT Smart Cart (ESP32 + AtMega32)
- Scans barcodes using GM65 QR module  
- Sends product codes and weight sensor readings 
- GPS Sensor for location cart

### Admin Dashboard (React + Vite + Tailwind)
- Product & inventory management  
- Cart tracking
- Admin analytics & reports