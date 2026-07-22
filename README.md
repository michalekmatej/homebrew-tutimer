# homebrew-tutimer

Homebrew tap for **TUtimer** — a terminal speedcubing timer in the spirit of [cstimer](https://cstimer.net), shipped as a fast, single-binary TUI.

WCA-style inspection and penalties, true random-state scrambles for 2x2/3x3, running averages, multiple sessions, a scramble net preview, and a session graph — all in the terminal.

## Install

```sh
brew tap michalekmatej/tutimer
brew install tutimer
tutimer
```

`brew tap` only needs to be run once; afterwards `tutimer` upgrades like any other formula.

### Requirements

- **macOS on Apple Silicon (arm64) only.** The formula installs a prebuilt binary; Intel macOS and Linux are not currently supported and the formula will refuse to install there.

## Upgrade / uninstall

```sh
brew update && brew upgrade tutimer   # update to the latest release
brew uninstall tutimer                # remove
brew untap michalekmatej/tutimer      # drop the tap entirely
```

## Features

- **Precise timing** — measured from keypress `Instant` deltas, independent of render cadence (millisecond-accurate).
- **Hold-to-start** — hold space to arm, release to start, press to stop. Falls back to press-to-start / press-to-stop automatically on terminals without key-release reporting (e.g. macOS Terminal.app).
- **WCA inspection** — optional 15s inspection with +2 (15–17s) and DNF (>17s) penalties and 8s/12s cues.
- **Scrambles**
  - 2x2 and 3x3: true **random-state** (WCA-quality).
  - 4x4–7x7: WCA **random-move** scrambles.
  - Generated on a background thread so the UI never blocks.
- **Statistics** — best, worst, session mean, standard deviation, mo3, and rolling ao5 / ao12 / ao50 / ao100 / ao1000 with cstimer/WCA trim + DNF rules, plus best rolling ao5/ao12.
- **Sessions** — multiple named sessions, one puzzle each; switch and cycle puzzles on the fly.
- **Solve list** — scrollable history with +2 / DNF / clear penalties, delete, per-solve comment, and the scramble for any solve.
- **Analysis** — line graph of session times plus a histogram.
- **Scramble preview** — colored unfolded-net view of the current scramble.
- **Persistence** — sessions and config saved as JSON (atomic writes) under the OS data dir; autosaves after every solve and on quit.
- **Import / export** — native JSON, headless via CLI flags.

## Usage

```
tutimer [OPTIONS]

Options:
      --data-dir <PATH>   Override the data directory
      --import <FILE>     Import a session store JSON file and exit
      --export <FILE>     Export the session store to a JSON file and exit
      --session <NAME>    Select (or create) a session by name on startup
  -h, --help              Print help
  -V, --version           Print version
```

Data is stored under the OS application-data directory (macOS: `~/Library/Application Support/TUtimer/`); override with `--data-dir`.

## Keybindings

| Key | Action |
|-----|--------|
| `Space` | Hold to arm / start; press to stop (or start/stop inspection) |
| `n` | New scramble |
| `2` | Toggle +2 on the selected/last solve |
| `d` | Toggle DNF |
| `c` | Clear penalty |
| `Delete` / `Backspace` | Delete selected/last solve |
| `Tab` | Cycle screen (Timer → Solves → Stats → Sessions) |
| `s` | Sessions screen |
| `g` | Stats / graph screen |
| `z` | Cycle puzzle (uses/creates a session for it) |
| `i` | Toggle inspection |
| `p` | Toggle scramble preview pane |
| `e` | Export to `tutimer-export.json` |
| `↑`/`↓` or `j`/`k` | Navigate lists |
| `Enter` | Edit comment (Solves) / switch session (Sessions) |
| `?` | Help overlay |
| `q` | Quit (autosaves) |

## About this repo

This repository is the Homebrew tap only — it holds the formula (`Formula/tutimer.rb`) and the prebuilt release binaries. The TUtimer application source is not public.
