# Versioning Rules

Hubsy follows **Semantic Versioning (SemVer)**:  
`MAJOR.MINOR.PATCH[-prerelease]`

---

## Rules

- **MAJOR**  
  - Increment when making incompatible or breaking changes.  
  - Example: removing features, changing CLI flags, or altering config paths.  

- **MINOR**  
  - Increment when adding new features that are backwards-compatible.  
  - Example: adding new menu options, tools, or setup scripts.  

- **PATCH**  
  - Increment when fixing bugs or making small, backwards-compatible improvements.  
  - Example: fixing a menu option, typo, or adjusting script behavior.  

---

## Pre-release tags
Use suffixes for unstable or in-progress versions:  

- `-alpha` → experimental, unstable, for internal/early testing.  
- `-beta` → feature-complete, but may contain bugs.  
- `-rc` → release candidate, nearly final.  

---

## Examples
- `0.1.0-alpha` → early experimental release.  
- `0.2.0-beta` → testing new features, mostly stable.  
- `1.0.0-rc` → preparing for stable launch.  
- `1.0.0` → first stable public release.  
- `1.0.1` → bug fix release.  
- `1.1.0` → new features, still backwards-compatible.  
- `2.0.0` → major breaking changes.  
