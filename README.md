# Nothing. — iOS Swift & WidgetKit App

Production-ready Xcode project and Swift code for the **Nothing.** iOS app and Home Screen widgets.

## Project Structure

```
App/
├── Nothing.xcodeproj              # Xcode Project (open this in Xcode)
├── Nothing/                       # Main iOS App Target
│   ├── NothingApp.swift           # Application entry point (@main)
│   ├── ContentView.swift          # OLED pure black void, haptics & Zero Metrics sheet
│   └── Assets.xcassets/           # App Icon (1024x1024 pure RGB) & Accent Color
├── NothingWidget/                 # WidgetKit Extension Target
│   └── NothingWidget.swift        # Home Screen & Lock Screen widgets
├── NothingWidget-Info.plist       # Widget extension configuration (NSExtension)
├── AppIcon_1024x1024.png          # App Store compliant pure black master icon
└── README.md
```

## Features

- **The Void Experience**: Minimalist OLED black canvas (`#000000`).
- **Existential Quotes**: Tap anywhere to cycle existential dialogue with Apple Taptic Engine feedback (`UIImpactFeedbackGenerator`).
- **Zero Metrics Sheet**: Tracks irreversible time spent doing nothing, with 0 KB harvested data and 0.0% utility metrics.
- **WidgetKit Extension**:
  - Small **"nothing."** agenda widget.
  - Small negative space widget for clean iOS home screen layouts.
  - Medium empty calendar agenda widget.
  - Lock Screen circular (`0`) and rectangular (`Nothing scheduled`) widgets.

## Running in Xcode

1. Open `Nothing.xcodeproj` (or double-click it in Finder).
2. Select the **Nothing** scheme and choose your target simulator or physical device (iOS 17.0+).
3. Press **Cmd + R** to Build & Run.
4. To test the widgets: long-press the Simulator home screen, tap **+**, and select **Nothing.** from the Widget Gallery.
