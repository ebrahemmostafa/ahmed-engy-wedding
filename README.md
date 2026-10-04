# حفل زفاف أحمد و إنجي — Arabic Wedding Invitation

Arabic (RTL) version of the Ahmed & Engy invitation (English version: https://github.com/ebrahemmostafa/leila-wedding).

**Source:** https://www.farha-invitations.com/templates/lail/preview/

## File Structure

```
+-- index.html              # Main invitation page
+-- css/
|   +-- invite.css          # Beautified invitation styles
|   +-- google-fonts.css    # Google Fonts with local references
+-- js/
|   +-- invite.js           # Beautified invitation script
+-- assets/
    +-- fonts/              # All font files (Google woff2 + custom TTF/OTF)
    +-- images/             # All images (WebP, JPEG, JPG)
    +-- videos/             # Video files (MP4)
    +-- audio/              # Audio files (MP3)
```

## Fonts Used

**Google Fonts:** Amiri, Aref Ruqaa, Cairo, Cormorant Garamond, Gelasio, Great Vibes, Marcellus, Montserrat, Playfair Display, Reem Kufi, Tajawal

**Custom Fonts:** GreatVibes-Regular, Diwani_Letter, Daustley, DTHULUTH-II-1

## Notes

- All external URLs replaced with local file references
- CSS and JS beautified for readability
- Font URLs in google-fonts.css point to local woff2 files
- Background music: assets/audio/background-music.mp3

## Color Theme — White & Olive

- Envelope intro video and poster recolored from royal blue to olive (`goldleaf-olive-open.*`); the gold leaf seal is unchanged
- Navy sections → deep olive, cream sections → white, gold/navy accents → olive tones
- Hero titles are white with a soft olive shadow so they read over both the day and night frames of the hero video

## Arabic Version

- Page is `lang="ar" dir="rtl"`; all text translated to Arabic
- `css/arabic.css` maps the Latin display fonts to Arabic ones for Arabic letters only (Amiri for headings/body, Diwani for the hero names and title, Aref Ruqaa for decorative lines), removes letter-spacing that breaks joined letters, and forces RTL text direction inside blocks the template sets to LTR

## Guest Messages (Supabase)

- The RSVP form on **both** sites (this one and the English one, https://github.com/ebrahemmostafa/leila-wedding) sends each message to the Supabase table `ahmed_engy_wedding_responses` via `js/rsvp-supabase.js`, tagged `ar` or `en`.
- `ahmed-engy-wedding-responses.html` shows all messages from both sites behind a passcode. The passcode is checked inside Supabase (`ahmed_engy_wedding_responses_list` function), so it isn't in the page's code. It has totals, an English/Arabic filter, search and CSV export.
- Guests can only add messages; the public key can't read, edit or delete them.
- Database setup: run `supabase/setup.sql` once in the Supabase SQL Editor. It only creates objects named `ahmed_engy_wedding_*`. To change the passcode, edit it there and re-run the `create or replace function …` part.
