# SMS & Notification Listener App

This Flutter-based Android app listens to incoming SMS and notifications, stores them locally on the device, and allows users to view, categorize, filter, and search the data. The app is privacy-focused, with no external storage or server communication; all data remains on the user's device.

## Features

- **SMS Listener**: Automatically listens for incoming SMS messages and stores their details (sender, timestamp, content) locally.
- **Notification Listener**: Captures and stores incoming notifications from other apps.
- **Local Storage**: All data is stored locally on the device, ensuring privacy and security.
- **Categorization**: The app categorizes SMS and notifications, helping users organize their messages and alerts.
- **Filter and Search**: Users can filter messages and notifications by categories or search for specific keywords.
- **User Privacy**: No data is sent to any backend or external server. Everything is stored on the device, so users don’t have to worry about data being shared.

## How It Works

1. **Listening**: The app runs in the background and listens for incoming SMS and push notifications on the device.
2. **Storing**: When an SMS or notification is received, the app stores the details locally using either Shared Preferences or SQLite.
3. **Categorizing**: The app organizes the received messages and notifications into categories for easy navigation.
4. **Filtering & Searching**: Users can apply filters based on categories or search for specific content within the stored messages and notifications.

## Setup & Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/your-repo/sms-notification-listener.git
