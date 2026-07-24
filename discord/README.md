# 💬 Discord share kit

Everything needed to make this repo look good when it lands in a Discord channel — plus the pieces
for posting your **own** station's weather to Discord.

[← Back to index](../README.md)

---

## 1. Make the link embed look good (do this once)

Discord builds its preview from the repo's OpenGraph tags. GitHub generates those from three things:

| What Discord shows | Where it comes from | Action |
|---|---|---|
| **Big image** | The repo's **social preview** | ⚠️ **Must be uploaded by hand** — there is no API for it |
| **Title** | Repo name | Set at creation |
| **Description** | Repo *About* description | Set with `gh repo edit -d "…"` |
| **Site name** | `GitHub` | Automatic |

### Upload the social preview (60 seconds, manual, required)

1. Go to **`https://github.com/Pro-Weather/pws-toolbox/settings`**
2. Scroll to **Social preview** → **Edit** → **Upload an image**
3. Choose **[`assets/social-preview.png`](../assets/social-preview.png)** (1280 × 640, 412 KB)
4. Paste the repo link into any Discord channel to check it

> Without this step, Discord shows GitHub's auto-generated grey card. With it, you get the full-width
> banner. It is the single highest-impact thing on this page.

To regenerate the image after editing [`assets/social-preview.svg`](../assets/social-preview.svg):

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless --disable-gpu --force-device-scale-factor=1 \
  --window-size=1280,640 \
  --screenshot=assets/social-preview.png \
  "file://$PWD/assets/social-preview.svg"
```
(Any Chromium works — `chromium --headless --screenshot=…`. On Linux, `rsvg-convert -w 1280 -h 640` is simpler.)

**Image rules Discord actually cares about:** ≥ 1200 px wide, **2:1 ratio**, under ~8 MB, PNG or JPG,
served over HTTPS. Keep important text out of the outer 5 % — mobile clients crop slightly.

---

## 2. Copy-paste messages

### One-liner
```
🌦️ Every tool for building a personal weather station website — hardware, software, skins, APIs, hosting.
https://github.com/Pro-Weather/pws-toolbox
```

### Short pitch (general channels)
```
Put together an aggregation repo: **PWS Toolbox** 🌦️

Everything you need to get a weather station in your garden onto the internet —
stations & sensors, collection software (WeeWX / CumulusMX / rtl_433), website
skins & templates, charting libs, free weather APIs, the networks to upload to
(Wunderground, CWOP, Windy), and hosting.

Plus 5 copy-me end-to-end stacks, from €0 to full DIY.

<https://github.com/Pro-Weather/pws-toolbox>
```
> Wrapping a URL in `<angle brackets>` suppresses the embed — use that when you post several links
> at once, and leave the *one* link you want previewed bare.

### For a weather / meteorology server
```
🌦️ **PWS Toolbox** — a curated index of every tool for running a PWS website.

📡 Hardware — Ecowitt · Davis · Tempest · Ambient · DIY
🧰 Software — WeeWX · CumulusMX · Weather Display · Meteobridge · rtl_433
🎨 Skins — Belchertown · NeoWX Material · weewx-wdc · PWS Dashboard · Saratoga
🔌 APIs — Open-Meteo · met.no · NWS · RainViewer radar (all free, no key)
🌍 Networks — Wunderground · CWOP · Windy · PWSWeather · WOW
☁️ Hosting — Cloudflare Tunnel · GitHub Pages · Docker

CC0, PRs welcome: https://github.com/Pro-Weather/pws-toolbox
```

### For a homelab / selfhosted server
```
If anyone here has a weather station gathering dust: **PWS Toolbox** 🌦️

Full self-hosted path — WeeWX/CumulusMX in Docker → SQLite/InfluxDB → a skin or Grafana →
nginx behind a Cloudflare Tunnel. Ready-made docker-compose included, no port forwarding.

https://github.com/Pro-Weather/pws-toolbox
```

---

## 3. Post it as a rich embed (webhook)

Nicer than a plain link: coloured sidebar, field grid, thumbnail. No bot, no hosting.

**Set up:** Discord → Server Settings → Integrations → **Webhooks** → New Webhook → pick a channel →
**Copy Webhook URL**.

```bash
export DISCORD_WEBHOOK_URL="https://discord.com/api/webhooks/…"
./discord/post.sh                      # posts the repo announcement embed
./discord/post.sh embed.json           # or any payload file
```

Payload: [`embed.json`](embed.json). Edit the fields, keep the JSON valid, re-run.

> 🔒 The webhook URL **is** the credential — anyone with it can post to your channel.
> Keep it in an env var, never in a committed file. `.gitignore` already covers `.env`.

---

## 4. Post your own weather to Discord

The same webhook mechanism, run from cron on your station box. Full context in
[docs/extras.md](../docs/extras.md#discord--chat-bots).

```bash
#!/usr/bin/env bash
# /usr/local/bin/weather-to-discord.sh  —  run hourly from cron
set -euo pipefail
DATA=$(curl -fsS https://weather.example.com/realtime.json)

jq -n --argjson d "$DATA" '{
  username: "Garden Weather",
  embeds: [{
    title: "Current conditions",
    url: "https://weather.example.com",
    color: 3447003,
    fields: [
      {name: "🌡️ Temperature", value: "\($d.current.temp) °C",        inline: true},
      {name: "💧 Humidity",    value: "\($d.current.humidity) %",      inline: true},
      {name: "📊 Pressure",    value: "\($d.current.pressure_sea) hPa", inline: true},
      {name: "💨 Wind",        value: "\($d.current.wind_speed) m/s",  inline: true},
      {name: "🌧️ Rain today",  value: "\($d.current.rain_today) mm",   inline: true},
      {name: "☀️ Solar",       value: "\($d.current.solar_wm2) W/m²",  inline: true}
    ],
    footer: {text: "Observed"},
    timestamp: $d.observed_utc
  }]
}' | curl -fsS -H "Content-Type: application/json" -X POST -d @- "$DISCORD_WEBHOOK_URL"
```

```cron
# hourly conditions
0 * * * * DISCORD_WEBHOOK_URL='https://discord.com/api/webhooks/…' /usr/local/bin/weather-to-discord.sh
```

**Tips that make it feel polished:**
- Put an **ISO-8601 UTC** value in `timestamp` — Discord renders it in each viewer's own local time.
- Add `"thumbnail": {"url": "https://weather.example.com/sky.jpg?t=…"}` for a live sky image. Append a
  cache-buster; Discord caches images aggressively.
- Use **[`<t:UNIX:R>`](https://discord.com/developers/docs/reference#message-formatting)** in message
  text for "3 minutes ago" that stays correct: `Updated <t:1753367520:R>`.
- Set `color` by condition — freezing `0x38bdf8`, hot `0xef4444`, rain `0x3b82f6`, normal `0x22c55e`.
- **Don't spam.** One hourly post, plus event-driven alerts (frost, first rain, gust threshold,
  station offline) is the right cadence. Rate limit is 5 requests / 2 s per webhook; a 429 returns
  `retry_after` — respect it.
- For an always-current single message instead of a feed, `PATCH` the same message:
  `PATCH /webhooks/{id}/{token}/messages/{message_id}` — post once, edit it every 5 minutes.

---

## 5. Getting it seen

- **Pin it** in the relevant channel after posting
- Add it to your server's `#resources` / `#links` channel
- Post in the [communities listed in docs/community.md](../docs/community.md) — r/weatherstations,
  WXforum, the Cumulus forum, the Home Assistant Discord `#esphome` channel
- Add the GitHub topics so it's findable: `weather-station`, `awesome-list`, `weewx`, `cumulusmx`,
  `pws`, `meteorology`, `weather`, `iot`
- Submit to [awesome](https://github.com/sindresorhus/awesome) once the list has some history behind it

---

[← Back to index](../README.md)
