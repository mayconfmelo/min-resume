# 0.1.0

- Minimal résumé following some Brazilian HR trends
- Customizable optional data
  - Academic title and/or main occupation
  - Personal information
  - Age calculation based on (not disclosed) birth date
  - Email (with _mailto:_ link)
  - Phone number (with WhatsApp link)
  - Photo
  - Linkedin profile QR Code
  - Professional letter
- Professional experience with `#xp`
  - Automatically calculates work experience time
  - Work skills as inline topics (saves space)
  - Work skills as standard topics (bullet list)
- Academic formation with `#edu`
  - Automatically calculates course/graduation time
  - Learned skills as inline topics (saves space)
  - Learned skills as standard topics (bullet list)
- Arbitrary soft skills with `#skills`
  - Inline topics (saves space)
  - Standard topics (bullet list)

### 0.2.0

- Complete internal re-design
- Removed: `#resume(date)`
- Removed: `#resume(paper)`
- Removed: `#resume(lang)`
- Removed: `#resume(justify)`
- Removed: `#resume(line-space)`
- Removed: `#resume(par-margin)`
- Removed: `#resume(margin)`
- Removed: `#resume(font)`
- Added: Development tests (using `tt`)
- Added: `#resume(typst-defaults)` to disable _min-resume_ defaults
- Added: `#resume(data)` for YAML-based résumé
- Added: `#resume(cfg)` for general settings
- Updated: `#resume(show-country-code)` &larr; `#resume(cfg.country-code)`
- Updated: `#resume(letter)` &larr; `#resume(cfg.letter-show)`
- Updated: `#resume(skills)` &larr; `#resume(cfg.lists)`
- Updated: `#resume(lang-data)` &larr; `#resume(translation)`
- Updated: `#resume(personal)` &larr; `#resume(info)`
- Updated: `#skills` &larr; `#list`
- Updated: `#xp`/`#edu` &larr; `#entry`
- Updated: `#Linkedin-qrcode` &larr; `#Linkedin`