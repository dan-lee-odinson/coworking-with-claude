# Anonymization — What to Scrub and What to Use Instead

This skill folder is meant to be shareable (it lives in a public learning repo). Before any code, summary, listing, or screenshot goes somewhere public, replace real account details with the placeholders below. The point isn't secrecy theater — it's avoiding leaking a working credential or an address that invites spam, while keeping the material useful as a template.

## Replace these

| Real thing | Placeholder to use |
|---|---|
| Support / developer email | `[your-support-email]` |
| Google developer account | "the Google account that owns the listing" |
| Published extension ID / store URL | `[your-extension-id]` |
| GitHub username + repo | `[your-github-username]` / `[your-repo]` |
| Privacy-page URL | `https://[your-github-username].github.io/[your-repo]/` |
| Launch / social handle | "your launch account" |
| N2YO (or any) API key | never include it at all — entered by the user in app settings |

## Never include, anywhere public

- A live API key or token, in any file, even commented out.
- Real coordinates of a home address (use a city centroid or a placeholder lat/lon in examples).
- Screenshots that show a real email, key, or precise location — crop or blur them.

## Why the API key rule is strict

The whole privacy story of an app like Next Pass is "your key and location stay on your device." A key checked into a public repo breaks that promise and can be scraped and abused within minutes. Keys belong in the browser's local storage, entered by the user — full stop.

## When reusing this skill for a new app

Swap the Next Pass specifics (ISS, N2YO, satellite communities) for the new app's domain, but keep the structure and the rules. The placeholders above stay the same.
