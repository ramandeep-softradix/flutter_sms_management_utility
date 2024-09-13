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
2. Navigate to the project directory:
   ```bash
   cd sms-notification-listener
3. Install dependencies:
   ```bash
   flutter pub get
4. Build and install the app on an Android device:
   ```bash
   flutter run
5. Grant necessary permissions: Upon installation, the app will request permissions to read SMS and access notifications. Make sure to grant these permissions for the app to function properly.

## Permissions

The app requires the following permissions:

- **Read SMS**: To listen to incoming SMS messages and store them locally.
- **Notification Access**: To capture incoming notifications.
- **Storage Permission**: For storing data locally on the device.

## Technologies Used

- **Flutter**: Cross-platform framework for building the Android app.
- **Dart**: Programming language used in Flutter development.
- **Shared Preferences**: For local data storage.
- **Android SDK**: Required for interacting with Android-specific features like SMS and notifications.

## Customization

The app offers various customization options:

- **UI Customization**: The app’s UI can be tailored to meet specific design requirements.
- **Notification Categories**: Users can add or edit categories for better organization of messages and notifications.
- **Filter Options**: The filter criteria and search functionality can be extended based on user needs.

## Contribution

We welcome contributions to enhance the app’s functionality. If you want to contribute, please follow these steps:

1. **Fork the Repository**: Create your own copy of the repository.
2. **Make Improvements**: Implement your changes and improvements.
3. **Submit a Pull Request**: Share your enhancements by submitting a pull request to the main repository.

Thank you for contributing!

## Contact

For any questions or support, please reach out to [info@softradix.com].

## License

This project is licensed under the MIT License. See the LICENSE file for details.
```bash
This version of the README file now includes all the requested sections, formatted appropriately for GitHub.


