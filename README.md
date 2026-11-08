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

## Installation Issues / Other Versions: One-Prompt AI Adaptation

If manual installation fails because of a different game layout, a non-Steam release, or a game update, an AI coding tool can adapt the package for you. Tools such as **Kimi Code**, WorkBuddy, ZCode, Cursor, and Claude Code can inspect the files and perform the adaptation.

Copy the entire prompt below, replacing the paths and language code with your own:

```text
My Blood Bowl 2 installation is at C:\Program Files (x86)\Steam\steamapps\common\Blood Bowl 2.
Please adapt the World Languages package at C:\Users\<username>\Downloads\Bloodbowl2-WorldLanguages-main and install the <language code> language:
1. Inspect the actual game layout before changing anything. If the expected paths differ, locate the corresponding files first.
2. Back up Data\DBToolDB\Localization\Default_loc_English.db to the package's backup\ directory. Never overwrite an existing original backup.
3. Copy the selected language's files\Data\ content into the corresponding game Data\ directory. Supported codes are zhhans, zhhant, ja, ptbr, and tr.
4. For zhhans, zhhant, or ja, deploy that language's ChineseFont.ttf as the nine font files listed in install.bat under both Data\Gui\Fonts\ and Data\Gui\Fonts\english\. For ptbr or tr, do not install a custom font.
5. Do not modify any CPK archive. Preserve the loose-file override approach and explain any additional changes before making them.
6. Verify that the deployed database, fonts.xml when required, and fonts match the selected language's source files. Show me how to restore the original files.
```

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

## Requesting or Developing Another Language

If your region's language is not yet included, you are welcome to [open an issue](https://github.com/VONWEI13/Bloodbowl2-WorldLanguages/issues) and suggest it. Include the language and region, your game version, and whether you can help test the resulting package.

You can also use **Kimi Code** or another AI coding tool to develop your own language Mod with this package as a reference. The following prompt provides a starting point:

```text
Please develop a new <language> (<region>) localization Mod for Blood Bowl 2 using this World Languages repository as a reference:
1. Read README.md, install.bat, and docs\KNOWN_ISSUES.md, then inspect the existing language directories and deployment layout.
2. Start from the original English Default_loc_English.db. Preserve all keys and the DSMGR database structure. Translate the display text without changing game logic.
3. Preserve every $XXX runtime reference and follow the boundary rules in docs\KNOWN_ISSUES.md. In particular, leave a space after each reference unless it ends the string.
4. Create a separate language directory containing files\Data\DBToolDB\Localization\Default_loc_English.db. Do not overwrite any existing language or original backup.
5. If the language needs additional glyphs, use an openly licensed font that covers them and prepare an appropriate fonts.xml by following the existing CJK language resources.
6. Extend install.bat with the new language code and menu option, add a standalone installer, and update the supported-language table in README.md.
7. Test installation, switching to and from other languages, font cleanup, and uninstallation in a disposable copy of the game directory. Verify deployed files against their sources and report any untranslated or untested content.
```

## Security and Transparency

This Mod contains no `.exe` or `.dll` files. Its installation, language switching, and removal logic is implemented entirely in public Windows batch scripts:

- [`install.bat`](install.bat): checks source files, preserves the original backup, deploys the selected language, and verifies copied files.
- The five standalone installers listed in the language table only pass their language code to `install.bat`.
- [`uninstall.bat`](uninstall.bat): restores the original language database and removes the Mod's loose font files.

The scripts do not access the network, upload data, change system settings, or modify files outside the game directory. You can review every command before running them.

## Disclaimer

- Audio does not change with the display language. Voices remain in the language supplied by the game.
- This Mod replaces local display text and required fonts only. It does not modify game logic or server data. Behavior on official servers cannot be guaranteed; use offline if this is a concern.
- Blood Bowl 2 © Cyanide Studio / Focus Home Interactive. This unofficial Mod is provided for learning, personal use, and interoperability.
