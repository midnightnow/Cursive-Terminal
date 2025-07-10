---
name: Create Pirate Lexicon JSON
about: Build the complete pirate vocabulary system
title: '[CONTENT] Create pirate lexicon JSON with tone levels'
labels: good-first-issue, content, nlp
assignees: ''
---

## 🏴‍☠️ Avast ye wordsmiths!

We need a proper pirate vocabulary that scales from 0% (plain English) to 100% (full pirate swagger).

### 📋 Requirements

Create `data/lexicons/pirate.json` with vocabulary that adapts to tone levels:

```json
{
  "greetings": {
    "0": ["Hello", "Hi", "Welcome"],
    "25": ["Ahoy there", "Greetings", "Welcome aboard"],
    "50": ["Ahoy!", "Avast!", "Welcome to me ship!"],
    "75": ["Ahoy, matey!", "Avast ye!", "Welcome aboard, ye scallywag!"],
    "100": ["Ahoy, ye scurvy dog!", "Avast, ye landlubber!", "Welcome to me ship, ye bilge rat!"]
  },
  "affirmatives": {
    "0": ["Yes", "Correct", "Confirmed"],
    "25": ["Aye", "Indeed", "That's right"],
    "50": ["Aye aye", "Right ye are", "That be true"],
    "75": ["Aye aye, captain!", "Right ye are, matey!", "That be the truth!"],
    "100": ["Aye aye, cap'n!", "By Davy Jones' locker, aye!", "Arr, that be gospel truth!"]
  },
  // ... more categories
}
```

### 📝 Categories Needed

- [ ] `greetings` - How to say hello
- [ ] `affirmatives` - Ways to say yes
- [ ] `negatives` - Ways to say no
- [ ] `commands` - Action phrases
- [ ] `errors` - Problem notifications
- [ ] `success` - Victory messages
- [ ] `navigation` - Moving around
- [ ] `tools` - Describing tools/features
- [ ] `time` - Time-related phrases
- [ ] `quantities` - Numbers and amounts

### 🎯 Tone Guidelines

- **0%**: Professional English
- **25%**: Slight nautical flavor
- **50%**: Clear pirate influence
- **75%**: Heavy pirate speak
- **100%**: Full pirate immersion

### ✅ Acceptance Criteria

1. At least 5 variations per tone level per category
2. Natural progression between levels
3. Maintains clarity (even at 100%)
4. Includes programming-specific terms
5. Family-friendly language only

### 🏴‍☠️ Example Progressions

**"File saved successfully":**
- 0%: "File saved successfully"
- 25%: "File stowed safely"
- 50%: "Yer file be stowed in the hold"
- 75%: "Arr, yer treasure be locked in the chest!"
- 100%: "Shiver me timbers! Yer booty be buried safe in Davy Jones' locker!"

**"Error: File not found":**
- 0%: "Error: File not found"
- 25%: "Warning: Can't locate that file"
- 50%: "Blast! That file be lost at sea"
- 75%: "Blimey! That treasure map be missing!"
- 100%: "Barnacles and bilge water! That scroll's been eaten by the kraken!"

### 📚 Pirate Glossary

- **Ahoy** - Hello
- **Avast** - Stop/attention
- **Aye** - Yes
- **Matey** - Friend
- **Scallywag** - Rascal (playful)
- **Landlubber** - Non-sailor
- **Booty** - Treasure/files
- **Hold** - Storage/directory
- **Crow's nest** - Overview/dashboard

### 🎨 Bonus Tasks

- Add special phrases for specific commands
- Include weather-based mood variations
- Add time-of-day greetings
- Create error severity scales

### 📁 Deliverable

Submit PR with:
1. `data/lexicons/pirate.json`
2. Update to `README.md` explaining the tone system
3. Simple test script showing different tone levels

*"May the wind be at yer back!"* ⛵