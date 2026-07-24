# Contributing

Additions, corrections and dead-link reports are all welcome. There is no gatekeeping here — if it
helps someone build or run a personal weather station website, it belongs.

---

## The fastest way

**[Open an "Add a tool" issue](../../issues/new?template=add-tool.yml)** — a short form, no git, no
fork. Takes about 30 seconds. Maintainers will place it in the right file.

Reporting a **dead or moved link** or an **abandoned project**? An issue is perfect. Half the value
of a list like this is that it's *currently true*.

---

## Sending a pull request

1. Fork, then edit the relevant file in [`docs/`](docs/)
2. One tool per line, in the existing table or list format
3. Commit and open a PR — describe *why* the tool is worth including

Don't worry about which file is exactly right; we'll move it if needed.

---

## Inclusion criteria

A tool goes in if it is:

- **Usable today.** Working links, and either recent activity or genuine ongoing usefulness. Stable-and-finished is fine; abandoned-and-broken is not.
- **Relevant** to building, running, hosting or feeding a personal weather station website.
- **Described in one line** that says what makes it *different* — not what category it's in.

It gets flagged rather than removed if it is:

- **⚠️ Legacy / unmaintained but still widely deployed** — people find it in old tutorials and need to know its status
- **⚠️ Cloud-locked** — no local data access
- **⚠️ Licence-restricted** — e.g. free only for non-commercial use

It doesn't go in if it is:

- Broken, gone, or last updated a decade ago with no users
- A pure affiliate/SEO page or content farm
- Only tangentially about weather (a generic charting library with no weather relevance)
- Your unfinished side project with no README — come back when it's usable, genuinely

**Self-promotion is fine.** Say it's yours in the PR description. Your own skin, template, driver or
station site is exactly the kind of thing this list exists to surface.

**Commercial entries** are welcome and get **no special treatment**: same one-line justification,
stated price, and an honest note on when *not* to use them. That includes the maintainers' own
product — [Pro Weather](https://pro-weather.com/) is listed and marked **ᴹ**, and if any entry reads
like an advert rather than an assessment, open an issue. A curated list that soft-pedals its own
commercial interest isn't worth reading.

---

## Style

- **One line per tool**, in the tables where the file already uses them
- **Bold the name**, link it, then a dash and one sentence:
  `**[ToolName](https://url)** — what it does and what makes it different.`
- Say what makes it *different*, not just what it is. "Weather software" is useless; "the only one with a built-in web UI" is useful.
- Note the **licence or cost** if it's not obviously free
- Note the **platform** if it's restricted (macOS-only, Windows-only, needs PHP)
- Flag status with ⚠️ (caveat), ✅ (verified good), ❌ (doesn't do this)
- **British or American English both fine.** Don't rewrite existing text to switch.
- Keep the tone plain and specific. This list is opinionated on purpose — a recommendation is more
  useful than a neutral catalogue. Back opinions with a reason.
- Prefer linking the **project's own site or repo**, not a review or a shop listing

---

## Structure

```
README.md              Hub — short lists + navigation. Keep it tight; detail goes in docs/.
docs/stacks.md         End-to-end recipes
docs/hardware.md       Stations, gateways, sensors, siting
docs/station-software.md   Collection & upload software
docs/website-templates.md  Skins, templates, dashboards
docs/charts-widgets.md     Charting, gauges, maps, real-time transport
docs/data-storage.md       Databases, formats, backups
docs/weather-apis.md       Forecast, radar, satellite, AQ, historical APIs
docs/networks.md           Where to upload observations
docs/hosting.md            Static hosts, tunnels, servers, monitoring
docs/diy.md                Microcontrollers, firmware, maths, building the site
docs/extras.md             Cameras, alerts, bots, astronomy, records
docs/community.md          Forums, chat, docs, standards, books
assets/                    Social preview image (source SVG + rendered PNG)
```

If your addition doesn't fit any of these, propose a new section in your PR.

---

## Maintainer note: the social preview

[`assets/social-preview.png`](assets/social-preview.png) is what shows as the banner when the repo
link is pasted anywhere that unfurls URLs. **GitHub has no API for it** — it has to be uploaded by
hand at *Settings → Social preview → Edit*, and re-uploaded after any change.

To regenerate it from [`assets/social-preview.svg`](assets/social-preview.svg):

```bash
# any Chromium build
chromium --headless --disable-gpu --force-device-scale-factor=1 \
  --window-size=1280,640 --screenshot=assets/social-preview.png \
  "file://$PWD/assets/social-preview.svg"

# or, on Linux, simpler:
rsvg-convert -w 1280 -h 640 assets/social-preview.svg -o assets/social-preview.png
```

Keep it 1280 × 640 (2:1) and under ~1 MB; leave important text out of the outer 5 %, since some
clients crop slightly.

---

## Reporting a dead link

The [link checker](.github/workflows/links.yml) runs weekly and opens an issue on failure, but it
misses domains that got parked or quietly changed owner. If you spot one:

- Open an issue with the file, the line, and the working replacement if you know it
- If a project has moved (a fork took over maintenance, say), say so — that's more useful than
  just deleting the entry

---

## Code of conduct

Be decent. Assume good faith, keep criticism about tools rather than people, and remember that
someone's "obviously wrong" station setup is often a reasonable answer to constraints you can't see.

Maintainers may edit, move, or decline entries. Nothing personal — the goal is a list that stays
useful to read end to end.

---

## Licence

Contributions are released under [CC0-1.0](LICENSE) — public domain. By contributing you agree to
that. Linked projects keep their own licences; nothing here changes them.
