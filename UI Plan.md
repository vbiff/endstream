I need UI screens for a mobile game. No text feedback is required.
## The Game
**EndStream** is a 2 player tactical trading card board about time-traveling outlaws seeking redemption.
Our universe is a stream of time. There are many streams, and the tech which allows streaming (moving within and between streams) has fallen into the wrong hands.
The characters of EndStream are broken and complicated. Each has committed a terrible deed. A Godlike AI has promised them redemption in exchange for a task: to destroy all of its Variants.
At your disposal are six Operators and their AI Controller. Your goal is to either eliminate all rival operators or destroy the Controller. Each player has a stream of 6 random turnpoints, placed a century apart, thus creating a board of 6x2 upon which the operators can move.

### UI Language
The UI is a temporal graph structure that metaphorically resembles a tree.
Imagine the whole UI lives inside of this time tree, the tree is massive and made out of many many gently pulsating branches. Every UI element is a part of that tree, no button/menu/screen hover freely. The tree should look 3D and the UI as a 2d panel. Use 3D visual hierarchy to make sure there is a good visible contrast between the tree and the UI (no glass or blur).

The tree represents fragile timelines that can be extinguished or intensified at any moment. Every interaction causes systemic ripple effects. Nothing is decorative. Everything responds.
Endless number of fragile timelines that can be snuffed out or light up into existence at any moment. Each interaction sends some random ripples up the tree. Some are tiny and barely noticeable, some are big and strong.

The UI language uses only thin lines, small dots and barely visible patterns that have waver moving through them. The colors are dark with some gentle and elegant blue and yellow highlights. No casual games style UI with fat colorful buttons and cartoon colors. Sharp geometry, more squares and angles, thatcher than waves and circles (except for some special cases).

- Branches = straight segmented paths, not organic curves
- Nodes = small squares or sharp points
- Ripples = linear wave distortions, not circular pulses
- Energy = subtle moving gradients, not glow explosions

Circles only when:
- Representing special states 
- Or signaling anomaly / singularity
Everything else: angular.

### Game board
There is a board reference in the attached files. it is a grid of 2x6. The columns represent parallel timelines (streams) and the rows are time, divided by centuries. These are 2 branches of a time tree.
The mobile UI will show each stream to fill up the vertical display, and the user can scroll between the two. The user owned stream is always on the right, and to see the player's hand and menu, you can scroll further right.

## Core Emotional Principles
### Fragile
- Lines feel thin and vulnerable
- Nodes feel barely stable
- Small oscillations are always present
- Stability is never assumed
### Political
- Power propagates upward
- Influence spreads through hierarchy
- Local actions create systemic reactions
- Nothing is isolated
### Tense
- Motion is restrained, not playful
- Feedback is sharp and controlled
- Energy pulses feel deliberate, not chaotic
- Silence between motions increases weight

All UI actions must subtly convey - you changed the time tree, this could have played out 1000 other ways, but you shifted into that reality. Don't hesitate using background motion to so it.

## Color System
No gradients that scream.
No neon cyberpunk glow.
No glass or blur effects.
No casual mobile games style.
Everything restrained and subtle.

Base:
- Near-black background (not pure black)
- Slight cool tint

Highlights:
- Muted electric blue
- Muted pale yellow
- Occasional very soft cyan noise in background

- Blue = informational flow
- Yellow = activation / intervention
- Dim white = dormant timeline

## Motion Language
No bounce.
No spring.
No playful easing.

Use:
* Linear or very subtle cubic easing
* Small amplitude oscillations
* Wave distortion along a line
* Ripple = energy intensity increase traveling upward

When interaction happens:
* A thin wave travels upward
* Nodes flicker slightly
* Lines temporarily intensify
* Then settle

Big interaction:
* Multiple branch paths illuminate
* Slight grid distortion
* Brief high-frequency shimmer

Small interaction:
* One branch trembles
* Minimal brightness shift

## Screens
All screens are vertical - portrait mode
- New game - game board
- Active games list
- Deck builder: deck lists, all available cards
- Friends list: find friends, initiate game with a friend
- Settings 