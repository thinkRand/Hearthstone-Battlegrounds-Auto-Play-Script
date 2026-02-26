# Hearthstone Battlegrounds Auto-Play Script

An AutoHotkey script that automates Hearthstone Battlegrounds matches by continuously starting new games, selecting random heroes, and restarting after death.

## 📋 Description

This script was developed for a Fiverr client in 2022 to automate the process of:
- Starting Hearthstone Battlegrounds matches
- Randomly selecting heroes from available options
- Letting the game play out until death
- Automatically restarting the process
- Handling various game states and error conditions

The script is designed for **1920x1080 resolution** and uses pixel detection to navigate through the game interface.

## 🎮 Features

- **Fully Automated Loop**: Continuously starts new games and restarts after death
- **Smart Detection**: Uses pixel color matching to identify UI elements
- **Error Handling**: Detects and handles game errors, disconnections, and pop-ups
- **Random Selection**: Randomly chooses between 2-4 available heroes
- **Visual Debug Mode**: Optional square overlays to verify detection regions
- **Logging**: Comprehensive logging of all actions and errors
- **Game Counter**: Tracks number of games played and total runtime

## 🔧 Requirements

- **Resolution**: 1920x1080 (hardcoded for this resolution)
- **Game**: Hearthstone (Battlegrounds mode)
- **Software**: AutoHotkey (v1.1 or later)
- **Operating System**: Windows

## 📥 Installation

1. Install [AutoHotkey](https://www.autohotkey.com/) if not already installed
2. Download all script files:
   - `HearthStone - queve and die n5` (main script)
   - `logFile.ahk` (logging functions - included via #Include)
   - `resources/deathScreenPurple.jpg` (image for death screen detection)
3. Create an `img` folder in the script directory for error screenshots
4. Configure Hearthstone to run in windowed mode at 1920x1080

## 🚀 Usage

### Hotkeys

| Hotkey | Function |
|--------|----------|
| `Ctrl+1` | Toggle automation on/off |
| `Ctrl+F12` | Toggle debug squares (shows detection regions) |
| `2` | Test death detection function |

### Starting the Script

1. Launch Hearthstone and navigate to the Battlegrounds lobby
2. Run the AutoHotkey script
3. Press `Ctrl+1` to start the automation
4. The script will begin cycling through games automatically

### Stopping the Script

- Press `Ctrl+1` again to stop after the current game completes
- Press `Ctrl+F12` to hide debug squares if visible

## ⚙️ How It Works

The script follows this workflow:

1. **Initial Detection**: Verifies Battlegrounds button is visible
2. **Start Game**: Clicks Play button and waits for hero selection
3. **Hero Selection**: Randomly selects a hero (from available slots 2-4)
4. **Gameplay**: Waits for game to finish (up to 25 minutes timeout)
5. **Death Detection**: Detects when hero dies using image/color detection
6. **Reset**: Returns to lobby and starts new game
7. **Error Handling**: Detects and resolves common errors (disconnects, pop-ups)

## 🎯 Detection Regions

The script defines multiple screen regions for detecting game states:
- Battlegrounds button
- Play button
- Hero selection interface
- Hero choice buttons (1-4)
- Confirm button
- Death screen indicators
- Error notification areas
