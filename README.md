# Tim McCoy's Homebrew tap

Casks for my Mac apps.

## Usage

    brew install --cask spurious-cox/tap/kbd

Homebrew reads `spurious-cox/tap` as this repository, so there is no need to
`brew tap` first.

## Casks

| Cask | Description |
| ---- | ----------- |
| [kbd](Casks/kbd.rb) | Floating numeric keypad that types into any application's text field |

## Updating a cask after a release

Each release changes the DMG, so the cask needs the new version and checksum:

    shasum -a 256 KBD-<version>.dmg

Edit `version` and `sha256` in the cask, commit, push. Anyone on the tap gets
the update with `brew upgrade`.
