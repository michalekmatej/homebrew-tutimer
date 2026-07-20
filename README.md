# TUtimer - Terminal speedcubing timer

A terminal speedcubing timer in the spirit of [cstimer](https://cstimer.net), built as a fast, single-binary TUI in Rust.

WCA-style inspection and penalties, true random-state scrambles for 2x2/3x3, running averages, multiple sessions, a scramble net preview, and a session graph — all in the terminal.

## Features

- **Precise timing** — solve time is measured from `Instant` deltas at the keypress, independent of render cadence (accurate to the millisecond).
- **Hold-to-start** — hold space to arm (turns green when ready), release to start, press to stop. On terminals without key-release reporting (e.g. macOS Terminal.app) it falls back to a press-to-start / press-to-stop model automatically.
- **WCA inspection** — optional 15s inspection with +2 (15–17s) and DNF (>17s) penalties and 8s/12s cues.
- **Scrambles**
  - 2x2 and 3x3: true **random-state** (3x3 via the Kociemba two-phase solver, 2x2 via a full BFS optimal solver).
  - 4x4–7x7: WCA **random-move** scrambles (40/60/80/100 moves, no consecutive same-face turns).
  - Generated on a background thread so the UI never blocks.
- **Statistics** — best, worst, session mean, standard deviation, mo3, and rolling ao5 / ao12 / ao50 / ao100 / ao1000 with cstimer/WCA trim + DNF rules, plus best rolling ao5/ao12.
- **Sessions** — multiple named sessions, one puzzle each; switch and cycle puzzles on the fly.
- **Solve list** — scrollable history with +2 / DNF / clear penalties, delete, per-solve comment, and the scramble for any solve.
- **Analysis** — line graph of session times plus a histogram.
- **Scramble preview** — colored unfolded-net view of the current scramble.
- **Persistence** — sessions and config saved as JSON (atomic writes) under the OS data dir; autosaves after every solve and on quit.
- **Import / export** — native JSON, headless via CLI flags.

## Install / Build

Requires a Rust toolchain (stable). If you don't have one:

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Build and run:

```sh
cargo run --release
```

Install with Homebrew (tap):

```sh
brew tap michalekmatej/tutimer
brew trust michalekmatej/tutimer
brew install tutimer
```

Upgrade / uninstall:

```sh
brew upgrade tutimer
brew uninstall tutimer
```

Install the binary onto your PATH:

```sh
cargo install --path .
tutimer
```

For maintainers configuring the tap and release automation, see `docs/homebrew-tap.md`.

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

## Scramble fidelity

2x2 and 3x3 scrambles are true random-state and WCA-quality. Big cubes (4x4–7x7) use WCA random-move scrambles, which satisfy the WCA minimum requirements; full TNoodle-style random-state (4x4) and axis-group clustering are intentionally out of scope for v1.

## Development

```sh
cargo test                                 # unit + integration tests
cargo clippy --all-targets -- -D warnings  # lints
cargo fmt                                  # format
```

The codebase is organized into small, focused modules: `puzzle`, `cube` (facelet model + net), `scramble` (kociemba3x3 / state2x2 / randommove), `session`, `stats`, `storage`, `timer`, and `ui` + `app` for the TUI.

> Note: `kociemba 0.5.3` requires `bincode` pinned to `2.0.0-rc.3` (later 2.0.x introduced a breaking change). This pin is declared in `Cargo.toml`; keep it if regenerating `Cargo.lock`.

## Out of scope (v1)

Metronome, BLD / multi-phase timing, color themes, Stackmat input, virtual cube, cstimer-format import, and random-state scrambles for 4x4+. The module layout leaves room to add each as an additive feature.
