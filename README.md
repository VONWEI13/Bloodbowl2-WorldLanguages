# Blood Bowl 2 World Languages

An unofficial multilingual localization Mod for Blood Bowl 2. It deploys text and fonts as loose files without modifying the game's CPK archives. Keep the in-game language set to **English**.

This package is a superset of the [standalone Simplified Chinese localization](https://github.com/VONWEI13/Bloodbowl2-Chinese/blob/main/README.md): it includes the same language database, font, and `fonts.xml`, plus Traditional Chinese, Japanese, Brazilian Portuguese, and Turkish. The standalone Chinese package remains complete and can still be installed, uninstalled, and distributed independently.

## Supported Languages / Regions

| Language | Region | Directory | Standalone installer |
|---|---|---|---|
| Simplified Chinese / Traditional Chinese | 🇨🇳 | `zhhans` / `zhhant` | [Simplified Chinese](install-ChineseSimplified.bat) / [Traditional Chinese](install-ChineseTraditional.bat) |
| Japanese | 🇯🇵 | `ja` | [install-Japanese.bat](install-Japanese.bat) |
| Portuguese (Brazil) | 🇧🇷 | `ptbr` | [install-PortuguesBR.bat](install-PortuguesBR.bat) |
| Turkish | 🇹🇷 | `tr` | [install-Turkce.bat](install-Turkce.bat) |

## Compatibility

Built for the file layout of **Steam version v3.0.219.2**. Other versions may work but have not been individually verified. Before installing, confirm that this file exists:

`Data\DBToolDB\Localization\Default_loc_English.db`

## Installation

1. Place the folder containing `install.bat` in the game root directory, which contains `BloodBowl2.exe`. If you downloaded a ZIP archive, extract it there; the extracted folder name does not matter.
2. Run [install.bat](install.bat) and select a language from the menu, or use a standalone installer from the table above.
3. After `Done!` appears, start the game with its language set to **English**.

The installer accepts the language codes `zhhans`, `zhhant`, `ja`, `ptbr`, and `tr`. You can also select a language from the command line:

```bat
install.bat zhhans
```

The installer checks the source files, preserves an existing original backup, deploys the selected language database, and installs the required fonts.

## Switching Languages

Only one language is active at a time. Run the target language's installer to switch directly; uninstalling first is not necessary. Loose fonts and `fonts.xml` from the previous language are removed.

- Simplified Chinese, Traditional Chinese, and Japanese each use their own bundled CJK font.
- Brazilian Portuguese and Turkish do not install custom fonts. Switching to either language removes CJK fonts left by the previous language.
- An existing `backup\Default_loc_English.db` is never overwritten.

> If another localization Mod has already changed the game and this package does not yet have an original backup, restore English with the other Mod's uninstaller before the first installation. This prevents translated text from being saved as the original backup.

## Uninstallation / Restoring English

Run [uninstall.bat](uninstall.bat). It restores the backed-up original English database and removes the fonts and `fonts.xml` deployed by this Mod. The backup is retained for future installations.

- Use this package's `uninstall.bat` for languages installed by World Languages.
- Use `BB2ChineseMod\uninstall.bat` for languages installed by the standalone Chinese package.
- Keep each package's original backup; neither backup should be deleted.

## Fonts

| Language directory | Deployed font | Notes |
|---|---|---|
| `zhhans` | WenQuanYi Micro Hei | Byte-identical to the standalone Chinese package's `ChineseFont.ttf` |
| `zhhant` | Noto Sans TC | `ChineseFont.ttf` is the font deployed by the installer |
| `ja` | Noto Sans JP | Used to render Japanese text |
| `ptbr`, `tr` | Original game fonts | No additional CJK font is required |

`zhhant\NotoSansTC-Regular.otf` is the complete Noto Sans CJK TC source font retained for maintenance or rebuilding. The installer neither deploys it nor uses it to overwrite the actual deployment font.

## Directory Structure

```text
BB2WorldLang/
├── README.md
├── install.bat                       Unified menu for five languages
├── install-ChineseSimplified.bat     Simplified Chinese entry point
├── install-ChineseTraditional.bat    Traditional Chinese entry point
├── install-Japanese.bat              Japanese entry point
├── install-PortuguesBR.bat           Brazilian Portuguese entry point
├── install-Turkce.bat                Turkish entry point
├── uninstall.bat                     Restore English and remove Mod files
├── zhhans/                           Complete Simplified Chinese resources
├── zhhant/                           Traditional Chinese resources and fonts
├── ja/                               Japanese resources and font
├── ptbr/                             Brazilian Portuguese language database
├── tr/                               Turkish language database
├── docs/
│   └── KNOWN_ISSUES.md               Localization technical notes
└── backup/
    └── Default_loc_English.db        Created on first install; excluded from Git
```

## Known Issues and Translation Rules

Appending kana, Han characters, or other non-ASCII characters directly after runtime references such as `$ACTION_*` can make the game display the raw key instead of resolving it. See [KNOWN_ISSUES.md](docs/KNOWN_ISSUES.md) for the translation and proofreading rules and the history of previous fixes.

## Security and Disclaimer

- This Mod contains no `.exe` or `.dll` files. Installation, language switching, and removal use public Windows batch scripts; they do not access the network, download files, or change system settings.
- Audio does not change with the display language. Voices remain in the language supplied by the game.
- This Mod replaces local display text and required fonts only. It does not modify game logic or server data. Behavior on official servers cannot be guaranteed; use offline if this is a concern.
- Blood Bowl 2 © Cyanide Studio / Focus Home Interactive. This unofficial Mod is provided for learning, personal use, and interoperability.
