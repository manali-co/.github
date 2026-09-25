# Manali Apps: brand

## The mark

One continuous line draws two hills. Neither is the whole shape on its own; the line only makes sense with both. Behind the second hill a sun rises, with a soft halo for the warmth that reaches past the ridge. When the logo animates, the ridge draws first, the sun rises over it, then the name settles in beneath.

## Colour

| | | |
|---|---|---|
| Indigo deep | `#2C2B6B` | ridge start |
| Indigo | `#5B63C7` | ridge end, accent, "apps" |
| Ink | `#23224A` | text, dark surfaces |
| Gold | `#F2B84B` | the sun, "apps" on dark |
| Halo | `#FBE7B8` | sun ring, soft fills |
| Paper | `#F7F5EE` / `#FFFFFF` | grounds |

## Type

**Comfortaa** for the wordmark and headings. Always lowercase in the lockup: "manali" at 500, "apps" at 400 in indigo (gold on dark). Rounded terminals match the curve of the ridge. **Inter** for body and interface text, 400 to 600, never below 14 px in product chrome.

All lockups in this folder have the type converted to outlines, so they render the same everywhere with no font loading.

## Files

`svg/`
- `mark-color.svg`, `mark-on-dark.svg`, `mark-mono-indigo.svg`, `mark-mono-white.svg` — the ridge mark. Colour on white and paper; on ink or indigo the ridge turns white and the sun stays gold. One-colour versions are for embossing, stamps and favicons.
- `lockup-light.svg`, `lockup-dark.svg`, `lockup-stacked.svg`, `lockup-stacked-dark.svg` — horizontal and stacked lockups.
- `logo-animated-light.svg`, `logo-animated-dark.svg` — the lockup that draws itself in. CSS inside the SVG, plays once, respects `prefers-reduced-motion`. Use in READMEs.
- `banner-light.svg`, `banner-dark.svg` — org README header with the tagline, animated. `social-preview.svg` — the 1280×640 card.
- `github-avatar.svg`, `app-icon.svg`, `app-icon-light.svg`, `favicon.svg` — avatar, app icon, and a simplified heavier-line mark for small sizes.

`png/`
- `github-avatar-500.png` — upload as the org avatar (**Organization settings › Profile**).
- `social-preview-1280x640.png` — upload under **Settings › Social preview** on any repo that wants the org card.
- `app-icon-1024.png`, `app-icon-light-1024.png`, `mark-color-1024.png`, `mark-on-dark-1024.png`, `favicon-16/32/48.png`, `apple-touch-icon-180.png`.
- `lockup-*.png`, `banner-*.png` — rasters of the lockups and banners at 2× to 4×.

`apps/`
- `yapp-icon.png`, `what-should-we-watch-icon.png` — each app's icon at 1024, copied from its repo so the org README never depends on a branch.

`support.js` is the Claude Design preview runtime for the original guide, which stays out of this repo.

## Rules

Keep clear space of at least the sun's diameter around the mark. Never rotate, outline or recolour the sun. Don't stretch the ridge; if you need a wider mark, use the horizontal lockup.
