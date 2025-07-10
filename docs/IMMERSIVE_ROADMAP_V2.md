# 🌌 Future Immersive Visualisation Road‑Map

> **Status:** ⏳ *Tagged for R\&D – not in MVP scope*  
> **Default Theme:** 🏴‍☠️ Pirate (because cursive → cursing!)

---

## 1  Vision

Create a *fully‑immersive* "Cursive‑Code Deck" where users can **launch fleets / hordes / guilds of persona agents** in their own windows or panes, each with animated banners, spatial audio cues, and interactive 3‑D document clouds.

* **Full‑screen cinematic mode** – terminal or browser canvas takes over display, fades surrounding UI.
* **3‑D surround‑sound layer** – positional cues for alerts, spell completions, errors.
* **Document nebula / cloud** – live Markdown & code files float as cards; grab, rotate, or zoom in.
* **Fleet console** – dock of crew icons (pirate ship, vampire bat, cogwheel) to spawn/sink agents.
* **Natural‑language dial** – single prompt like *"dial visuals to 30%"* lowers effects in real time.

---

## 2  Feature Backlog (🥈 Silver = nice‑to‑have | 🥇 Gold = wow‑factor | 🥉 Bronze = stretch)

|   ID | Feature                                     | Tier | Notes                                                                   | Labels                          |
| ---: | ------------------------------------------- | :--: | ----------------------------------------------------------------------- | ------------------------------- |
| V‑01 | Full‑screen toggle (⌘⇧F)                    |  🥈  | HTML Canvas + Tailwind fullscreen API                                   | `good-first-issue`              |
| V‑02 | 3‑D document cloud                          |  🥇  | three.js scene; Git repo nodes as spheres                               | `stretch-goal`                  |
| V‑03 | Spatial audio engine                        |  🥇  | Web Audio API; pirate cannons vs. vampire whispers                      | `audio`                         |
| V‑04 | Fleet launcher / dock                       |  🥇  | React draggable icons; open new Electron windows                        | `ui`                            |
| V‑05 | Natural‑language effect dial                |  🥇  | Parse "dial visuals 0‑100%" → Redux state                               | `nlp`                           |
| V‑06 | Theme‑adaptive shaders                      |  🥈  | GLSL tint matches chosen flag theme                                      | `graphics`                      |
| V‑07 | VR / AR headset support                     |  🥉  | WebXR later                                                             | `xr` `stretch-goal`             |
| V‑08 | Onboarding text‑adventure intro + tone‑dial |  🥇  | Greets user, offers pirate/vampire/plain tone slider                    | `good-first-issue` `onboarding` |
| V‑09 | Adaptive Unit Renderer (SVG → GLB)          |  🥇  | Unified sprite → SVG → GLB pipeline; auto‑exports favicon, PNG, 3D mesh | `graphics` `good-first-issue`   |

---

## 3  Minimal POC Slice

1. **Toggle**: `fullscreen on/off` nat‑lang command (updates `appState.fullscreen`).
   * ✅ **Test**: Returns to previous window size within 100ms
2. **Fleet Dock**: React sidebar with 3 icons → opens dummy windows printing persona banner.
   * ✅ **Test**: Each spawn creates unique window ID
3. **Effect Dial**: `dial visuals 50%` updates CSS `filter: blur()` & audio gain.
   * ✅ **Test**: Visual effects scale linearly 0-100%
4. **Adaptive Units**: Spawn "fleet" icon that swaps between 16×16 emoji → 128px PNG → simple GLB
   * ✅ **Test**: LOD switches based on viewport size

---

## 4  Technical Notes

* **Stack**: Electron shell • React/Three • Zustand/Redux store • WebAudio • Tailwind.
* **Performance guard‑rails**: limit 60 fps; degrade gracefully below 30 fps.
* **Accessibility**: "visuals 0%" turns off motion, audio, colour strobe.
* **Scene Graph**: P‑3 (3D Document Cloud) & P‑5 (XR Mode) share the *same* Three.js scene graph to avoid duplication.

---

## 5  Open Questions

* Best cross‑platform full‑screen API for Linux ttys?
* How to map multiple git repos → 3‑D clusters without overload?
* Shared audio bus between Electron windows?
* Head-pose tracking API for foveated rendering?

---

## 6  Next Action "Tag"

`TODO(visual‑immersion): explore Three.js POC – assign after core v1 launch`

---

### Immersive Personas & Persona Fleets (Singularity 2025)

* **Player‑selectable persona packs** – pick your *crew*, *horde*, or *legion*; each pack ships with its own vocabulary, UI skin, icon set and ambient soundscape.
* **Attachment hooks** – avatar sprites, 3‑D panoramas (ship's deck, vampire crypt, mech command‑deck), looping audio beds; loaded through a lightweight plug‑in manifest (`persona.json`).
* **Dynamic scaling** – NAT‑LANG commands such as "*summon my vampire horde*" spawn N auxiliary agent windows in blood‑red theme; "*dismiss the crew*" collapses them back.
* **Personal‑singularity toggle** – `/enter‑immersion` turns the entire tool‑chain (terminal, editor, docs) into the persona theme until `/exit‑immersion` restores defaults.
* **Tech spike** – prototype WebGL overlay with Three.js for parallax star‑field + positional audio via WebAudio API; target CPU < 5 % on M‑series Mac.

---

## 7  Natural‑Language Intro & Persona Tone Dial

> **🏴‍☠️ Default Pirate Experience**
>
> ```
> Ahoy, wanderer!
> I'll always be straight with ye, Captain, and do as ye wish, if it be possible.
> What shall I call ye?
>
> (And I've been told I sometimes sound **too pirate** – as if there be such a thing!  
> Tell me "dial pirate 0%" to sober me tongue, or "dial pirate 100%" for full swagger.)
> ```
>
> Users can answer naturally – e.g. *"Call me Ada"* – and immediately issue tone commands:
>
> * **"dial pirate 25%"** → light nautical slang, keeps formal code explanations.
> * **"speak plainly"** → switch to neutral technical English.
> * **"unleash full vampire prose"** → swap persona lexicon & colour scheme.
>
> The setting persists per session (`appState.personaTone`).
>
> **Implementation hint** – ANSI `ESC[23m` resets italics so demo can show real "regular" lines next to cursive.

---

## 8  Persona Packs & Flag Selection  ⛵🦇⚙️

A flexible system allowing users to pick a **banner‑theme** that permeates visuals *and* language style.

| Flag                     | Visual Skin                                               | Lexicon Accent                   | Ambient Audio                           | Unit Models                          |
| ------------------------ | --------------------------------------------------------- | -------------------------------- | --------------------------------------- | ------------------------------------ |
| 🏴‍☠️  **Pirate Crew**   | Weather‑beaten parchment, skull‑and‑crossbones dock icons | Nautical slang (dial 0–100 %)    | Gull cries, ship creak, distant cannons | Galleon, frigate, crew               |
| 🧛  **Vampire Horde**    | Black velvet, blood‑red accent, bat wing cursors          | Gothic antiquity (dial 0–100 %)  | Wind howl, heart‑beat bass, whispers    | Castle, vampire lord, bats           |
| ⚙️  **Clockwork Legion** | Brass cog UI, sepia diagrams                              | Formal Victoriana (dial 0–100 %) | Tick‑tock, steam hiss                   | Factory, automaton, engineer         |
| 🧙‍♂️  **Arcane Guild**  | Nebula backdrop, rune buttons                             | Archaic wizardry (dial 0–100 %)  | Soft choir, chime strikes               | Tower, wizard, familiar              |

### 8.1  Natural‑Language Controls

```
/summon pirate crew            # switch visuals + lexicon to pirate @100 %
/dial vampire 40%             # 40 % gothic flavour, keep visuals plain
/hoist neutral flag           # revert to default technical tone & colours
```

*Implementation hint*: persona + tone stored in `appState.personaFlag` & `appState.personaTone` (0‑100). Changing either triggers React/Zustand observers that swap CSS variables, audio bus, and lexicon dictionary.

### 8.2  On‑the‑Fly Persona Spawning

* `spawn fleet n=3 flag=pirate` → opens 3 helper agent windows with pirate banner and brown‑gold theme.
* `dismiss fleet` → closes them gracefully.

---

## 9  High‑Level Implementation Phases

| Phase   | Milestone                   | Key Tickets                                                                          | Notes                                      |
| ------- | --------------------------- | ------------------------------------------------------------------------------------ | ------------------------------------------ |
| **P‑0** | 🚩 **Flag & Tone Core**     | P‑00 flag/tone state model • P‑01 pirate/vampire lexicon JSON • P‑02 CSS var swapper | Start with pirate as default               |
| **P‑1** | 🎛️  **Visual Effect Dial** | P‑10 global percent dial reducer • P‑11 link to WebAudio master gain                 | Foundation for immersion control           |
| **P‑2** | 🖼️  **Fleet Dock UI**      | V‑04 from backlog • React draggable icons • Window spawner                           | Make it feel like a game launcher          |
| **P‑3** | 🌌 **3‑D Document Cloud**   | V‑02 three.js POC • link git graph                                                   | *Shares scene graph with P‑5 for XR ready* |
| **P‑4** | 🔊 **Spatial Audio Engine** | V‑03 WebAudio routing • optimise CPU                                                 | Positional audio for fleets                |
| **P‑5** | 🕶️ **Immersive Mode & XR** | V‑01 fullscreen • V‑07 WebXR                                                         | *Reuses P‑3 scene graph*                   |

> **Next Tag** `TODO(persona-core): implement P‑0 Flag & Tone module before v1 launch`

---

## 10 "Feather‑Light" Cursive Palettes ✨

Extra‑bright themes designed for daylight coding sessions and historical‑manuscript vibes. All meet **WCAG‑AA ≥ 4.5** contrast.

> *Note: Palette metadata will also drive unit‑skin materials (metallic/roughness) for 3‑D renders.*

| ID                         | Theme Name                                                     | Vibe & Notes    | Unit Material      |
| -------------------------- | -------------------------------------------------------------- | --------------- | ------------------ |
| **papyrus-scroll**         | Soft ochre parchment, faint reed‑ink lines                     |                 | Aged paper         |
| **ancient-parchment**      | Ivory base, warm sepia text (a true "bone" classic)            |                 | Vellum             |
| **linen-sheet**            | Cool‑white linen weave, charcoal ink, sage accent              |                 | Fabric             |
| **illuminated-manuscript** | Cream background, gold‑leaf cursor, jewel‑tone accents         |                 | Gold leaf          |
| **calligraphy-flourish**   | Pearl paper, jet‑black strokes, subtle lilac & teal highlights |                 | Glossy ink         |
| **invisible-ink**          | Pale lemon backdrop; text reveals on bold/selection            | Easter‑egg      | Translucent glass  |

---

## 11 Next Concrete Steps

| 🍪 Bite‑size task                                               | Outcome                                         | Issue Template                 |
| --------------------------------------------------------------- | ----------------------------------------------- | ------------------------------ |
| **Generate single demo GLB** for pirate galleon                | Wire LOD swapping & billboard fallback          | `implement-pirate-galleon-glb` |
| **Implement fullscreen toggle**                                 | ⌘⇧F enters/exits cinematic mode                 | `implement-fullscreen-toggle`  |
| **Create pirate lexicon JSON**                                  | Complete vocabulary for 0-100% pirate tone      | `pirate-lexicon-json`          |
| **Export adaptive unit sprites**                                | 16px → SVG → 128px → GLB pipeline               | `adaptive-unit-sprite-export`  |
| **Record 90-sec demo GIF**                                      | Fullscreen + fleet spawn for README             | `create-demo-gif`              |
| **Enable GitHub Pages**                                         | Settings → Pages → main branch → /docs          | `setup-github-pages`           |

---

## 12 Contributor Guidelines

### Labels for Issues
- `good-first-issue` - Great for newcomers
- `stretch-goal` - Ambitious features
- `audio` - Sound-related work
- `graphics` - Visual/3D work
- `ui` - Interface components
- `nlp` - Natural language processing
- `xr` - VR/AR features
- `onboarding` - First-time user experience

### Testing Requirements
All features must include:
1. Unit tests for core logic
2. Visual regression tests for UI
3. Performance benchmarks (must maintain 60fps)
4. Accessibility audit (WCAG-AA minimum)

---

*"Arr! Ready to sail the cursive seas, me hearties!"* 🏴‍☠️✨