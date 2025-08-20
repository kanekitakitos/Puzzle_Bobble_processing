# Puzzle Bubble

![Processing](https://img.shields.io/badge/language-Processing-blue.svg)
![Status](https://img.shields.io/badge/status-complete-green)
![License](https://img.shields.io/badge/license-educational-orange)

Puzzle Bubble is a modern implementation of the classic Puzzle Bobble/Bust-a-Move game, developed using the Processing platform. The main goal of this project is to demonstrate Object-Oriented Programming (OOP) concepts through the development of a functional and engaging puzzle game.

## About the Game

Puzzle Bubble is a puzzle game where players control a cannon at the bottom of the screen, shooting colored bubbles upward to match and eliminate groups of three or more bubbles of the same color. The objective is to clear all bubbles from the grid before they reach the bottom, with progressively challenging levels.

## Main Features

- **Classic Gameplay:** Match 3 or more bubbles of the same color to eliminate them
- **Hexagonal Grid System:** Unique layout that creates interesting matching patterns
- **Realistic Physics:** Physics-based movement with collision detection and gravity effects
- **Chain Reaction System:** Bubbles fall when disconnected from the top
- **5 Progressive Levels:** Each level with increasing complexity and time pressure
- **Dynamic Color System:** 6 different colors with randomized level layouts
- **Time-Based Mechanics:** Ceiling gradually descends, adding urgency
- **Scoring System:** Points for matches, chain reactions and strategic plays
- **Audio Integration:** Background music and sound effects to enhance the experience

## Controls

- **Left Arrow:** Rotate cannon counterclockwise
- **Right Arrow:** Rotate cannon clockwise
- **Spacebar:** Shoot bubble
- **Keys 1-5:** Switch between levels
- **Backspace:** Activate explosion effect on all bubbles (debug feature)

## Project Structure

```
projeto2-puzzleBubble/
├── main.pde                 # Main game loop and setup
├── Cannon.pde              # Player cannon controller
├── Bullet.pde              # Bubble projectile system
├── bulletGrid.pde          # Hexagonal grid management
├── Ceiling.pde             # Game boundary and level progression
├── Cell.pde                # Individual grid cell management
├── color.pde               # Color management system
├── data/
│   ├── effects/            # Audio files (WAV format)
│   │   ├── boom.wav        # Match sound effect
│   │   ├── gameOver.wav    # Game over sound
│   │   ├── retroExplosion.wav # Shooting sound
│   │   └── retroMusic.wav  # Background music
│   ├── levels/             # Level configuration files
│   │   ├── level-1.txt     # Level 1 layout
│   │   ├── level-2.txt     # Level 2 layout
│   │   ├── level-3.txt     # Level 3 layout
│   │   ├── level-4.txt     # Level 4 layout
│   │   └── Bonus-5.txt     # Bonus level layout
│   ├── Maps/               # Background images for each level
│   │   ├── Map_lvl_1.jpg   # Level 1 background
│   │   ├── Map_lvl_2.jpg   # Level 2 background
│   │   ├── Map_lvl_3.jpg   # Level 3 background
│   │   ├── Map_lvl_4.jpg   # Level 4 background
│   │   └── Map_lvl_Bonus.jpg # Bonus level background
│   └── RetroGaming-50.vlw  # Custom retro font
├── sketch.properties        # Processing sketch configuration
└── README.md               # This file
```

## Main Components

### Core Game System
- **main.pde:** Central controller managing game state, rendering, input and main loop
- **Game Engine:** 120 FPS game loop with smooth animations and responsive controls

### Player Interaction
- **Cannon:** Player-controlled shooting mechanism with angle-based movement
- **Bubble System:** Physics-based projectile management with collision detection

### Grid Management
- **BulletGrid:** Hexagonal grid system managing bubble placement and elimination
- **Cell:** Individual grid cells with bubble storage and connection tracking
- **Ceiling:** Game boundary system with descending mechanics and level progression

### Game Logic
- **Color Management:** 6-color system with randomized level layouts
- **Scoring System:** Point calculation based on match size
- **Level System:** 5 progressively challenging levels with unique layouts

## Level System

The game features 5 progressively challenging levels:

1. **Level 1:** Introduction to basic mechanics and simple patterns
2. **Level 2:** Increased complexity with more varied color distributions
3. **Level 3:** Advanced patterns requiring strategic thinking
4. **Level 4:** Expert-level challenges with complex arrangements
5. **Bonus Level:** Special challenge level with unique layout

Each level uses a text-based configuration system that defines bubble positions and colors, allowing for easy level creation and modification.

## How to Run

### Prerequisites
- **Processing 3.x or higher** - Download from [processing.org](https://processing.org/download/)
- **Java 8+** - Required for Processing to work

### Steps
1. Clone the repository
2. Open Processing IDE
3. Go to `File > Open...`
4. Navigate to the project folder and select `main.pde`
5. Click the **Run** button (▶️)

## Technologies Used

- **Processing 3.x+** - Creative programming platform based on Java
- **Java** - Underlying programming language
- **Processing Sound Library** - Audio management and playback
- **Custom Assets** - All graphical and sound resources

## License

> **This project is licensed under the "Educational Use Only License".**  
> Use, copying, modification and distribution are permitted for educational and non-commercial purposes only.  
> **Commercial use is prohibited without prior permission from the author.**

---

*Enjoy the game and happy coding! 🎮✨*
