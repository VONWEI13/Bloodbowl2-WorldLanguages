# Known Issue: `$` References Adjacent to CJK or Other Non-ASCII Characters Fail to Resolve

## Symptom

The Japanese title screen displayed the raw key `ACTION_VALIDATE_BIGを押してください` instead of the resolved input prompt, such as `Enter を押してください`.

## Root Cause

`$XXX` references in the game's text fall into two categories:

1. **Input-action references** such as `$ACTION_VALIDATE_BIG` and other `$ACTION_*` keys. The input system replaces these with the bound key name at display time. Its parser requires the reference name to be followed by **a space or the end of the string** as a boundary.
2. **Runtime placeholders** such as `$LEAGUE`, `$COACH`, and `$VALUE`. Game logic supplies their values. These are not boundary-sensitive, although omitting spaces can still produce poor display results.

If translated text places a non-ASCII character—such as kana, a Han character, or an accented letter—directly after a `$` reference, as in `$ACTION_VALIDATE_BIGを...`, the first parser can consume the multibyte character as part of the key name. Lookup then fails and the game falls back to displaying the raw key.

## Translation and Proofreading Rules

- **Every `$XXX` reference must be followed by a space**, unless it is at the end of the string.
- No issue has been observed when a non-ASCII character immediately precedes a reference; for example, `请按$ACTION` resolves correctly. Adding a space before the reference as well is recommended for consistency.
- Include this rule in each language's translation instructions and run a boundary scan after translation:

```python
import re
PAT = re.compile(r'(\$[A-Z][A-Z_0-9]+)([^\x00-\x7f])')  # Non-ASCII character directly after a reference
# Scan each translated field and repair matches with:
# item[field] = PAT.sub(r'\1 \2', item[field])
```

## History

- 2026-11-08: First found in Japanese (162 occurrences) and Traditional Chinese (101 occurrences). All occurrences were fixed and committed in `043783d`.
- No occurrences were found by the PT-BR or Turkish scans. Latin text naturally tends to provide a space boundary or place the reference at the end of a sentence.
