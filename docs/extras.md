# ✨ Extras

The things that turn a data page into a site people come back to.

[← Back to index](../README.md)

---

## Contents

- [Cameras & all-sky](#cameras--all-sky)
- [Timelapse & video](#timelapse--video)
- [Alerts & notifications](#alerts--notifications)
- [Discord & chat bots](#discord--chat-bots)
- [Astronomy & sky](#astronomy--sky)
- [Air quality](#air-quality)
- [Lightning](#lightning)
- [Records, stats & climatology](#records-stats--climatology)
- [Forecasting your own](#forecasting-your-own)
- [Adjacent hobbies](#adjacent-hobbies)
- [Accessibility & i18n](#accessibility--i18n)

---

## Cameras & all-sky

A live sky image is the single highest-impact addition to a weather site. People look at pictures.

| Project | Notes |
|---|---|
| **[Thomas Jacquin's AllSky](https://github.com/AllskyTeam/allsky)** | **The standard all-sky camera software.** Raspberry Pi + a ZWO/RPi HQ camera, produces live images, startrails, keograms and nightly timelapses. Superb documentation and a big community. |
| **[Indi-Allsky](https://github.com/aaronwmorris/indi-allsky)** | INDI-based alternative with more astro-imaging control |
| **[motionEye](https://github.com/motioneye-project/motioneye)** | Turn any USB/Pi camera into a streaming, snapshotting webcam server |
| **[MediaMTX](https://github.com/bluenviron/mediamtx)** | RTSP/WebRTC/HLS server — put a cheap IP camera on your site with sub-second latency |
| **[go2rtc](https://github.com/AlexxIT/go2rtc)** | Lightweight, brilliant camera stream multiplexer |
| **[ffmpeg](https://ffmpeg.org/)** | The universal tool: grab frames, overlay data, build HLS, encode timelapses |
| **[Windy Webcams](https://www.windy.com/webcams)** | Publish your webcam to Windy's network for a big audience |
| **[YouTube Live / Owncast](https://owncast.online/)** | 24/7 sky stream. [Owncast](https://owncast.online/) if you want to self-host it. |

**Sky camera tips:** dome heater (or you'll photograph dew every night), silica gel inside the
housing, tilt the dome ~5° so rain runs off, and **overlay the current observations onto the image**
with ffmpeg `drawtext` — one image then carries your whole station.

---

## Timelapse & video

- **[ffmpeg](https://ffmpeg.org/)** — `ffmpeg -framerate 30 -pattern_type glob -i '*.jpg' -c:v libx264 -crf 20 out.mp4`
- **[AllSky](https://github.com/AllskyTeam/allsky)** generates nightly timelapses, keograms and startrails automatically
- **[Timelapse Deflicker](https://github.com/cyberang3l/timelapse-deflicker)** — fixes exposure flicker
- **Cloud-motion GIFs** from radar frames — [RainViewer](weather-apis.md#radar) tiles + ffmpeg
- Publish as **HLS** or a plain MP4; don't embed a 200 MB GIF

---

## Alerts & notifications

| Tool | Notes |
|---|---|
| **[Apprise](https://github.com/caronc/apprise)** | **One library, 100+ notification services** (Discord, Telegram, Signal, Matrix, ntfy, email, SMS, Slack…). Call it from a cron script and you're done. |
| **[ntfy](https://ntfy.sh/)** | Dead-simple push to phone: `curl -d "Frost warning: -2°C" ntfy.sh/my-weather`. Self-hostable, free, no account. **Best effort-to-value ratio here.** |
| **[Gotify](https://gotify.net/)** | Self-hosted push server |
| **[Home Assistant automations](https://www.home-assistant.io/)** | If HA already has your data, alerting is a few clicks |
| **[Node-RED](https://nodered.org/)** | Visual rules: "if temp < 1 and humidity > 90 → frost alert" |
| **[Grafana alerting](https://grafana.com/docs/grafana/latest/alerting/)** | Threshold + no-data alerts on your time series |
| **[Healthchecks.io](https://healthchecks.io/)** | Alert when your station *stops* reporting — the alert you actually need |
| **[NWS CAP / MeteoAlarm feeds](weather-apis.md#alerts--warnings)** | Relay official warnings, don't invent your own |

**Alerts worth building:** frost/freeze tonight · first/last frost of the season · rain started ·
strong gust threshold · station offline > 15 min · new all-time record · pressure falling fast ·
sensor battery low. That last one saves more data than any of the others.

---

## Discord & chat bots

See also the **[Discord share kit](../discord/)** in this repo for posting the *repo* to Discord.

| Tool | Notes |
|---|---|
| **[Discord webhooks](https://discord.com/developers/docs/resources/webhook)** | No bot, no hosting, no OAuth — one `POST` to a URL puts a rich embed in a channel. **Start here.** |
| **[discord.py](https://discordpy.readthedocs.io/)** / **[discord.js](https://discord.js.org/)** | Full bots with slash commands (`/weather`, `/rain`, `/records`) |
| **[Vercel Chat SDK](https://vercel.com/docs)** | One codebase → Discord, Slack, Telegram, Teams |
| **[python-telegram-bot](https://python-telegram-bot.org/)** | Telegram equivalent |
| **[matrix-nio](https://github.com/matrix-nio/matrix-nio)** / **[maubot](https://github.com/maubot/maubot)** | Matrix |
| **[Mastodon.py](https://mastodonpy.readthedocs.io/)** / **[atproto](https://github.com/MarshalX/atproto)** | Auto-post a daily summary to Mastodon or Bluesky — surprisingly popular for weather accounts |
| **[Apprise](https://github.com/caronc/apprise)** | Again — one call, every platform |

**A weather webhook in 10 lines:**
```bash
curl -H "Content-Type: application/json" -X POST "$DISCORD_WEBHOOK_URL" -d '{
  "username": "Garden Weather",
  "embeds": [{
    "title": "Current conditions",
    "url": "https://weather.example.com",
    "color": 3447003,
    "fields": [
      {"name": "🌡️ Temperature", "value": "24.3 °C", "inline": true},
      {"name": "💨 Wind",        "value": "3.4 m/s SW", "inline": true},
      {"name": "🌧️ Rain today",  "value": "1.2 mm", "inline": true}
    ],
    "footer": {"text": "Updated"},
    "timestamp": "2026-07-24T14:32:00Z"
  }]
}'
```
Post it hourly from cron. Keep `timestamp` in ISO-8601 UTC and Discord renders it in each viewer's
local time automatically. Add `"thumbnail": {"url": "https://.../sky.jpg"}` to include your webcam.

---

## Astronomy & sky

- **[SunCalc](https://github.com/mourner/suncalc)** / **[Astral](https://astral.readthedocs.io/)** — sunrise, sunset, civil/nautical/astronomical twilight, golden hour, moon phase & illumination. No API needed.
- **[Skyfield](https://rhodesmill.org/skyfield/)** — planetary positions, ISS passes, eclipses
- **[NOAA SWPC](https://www.swpc.noaa.gov/)** — Kp index, aurora forecast, solar wind. A great panel for northern stations.
- **[Clear Outside](https://clearoutside.com/)** / **[7Timer! astro](http://www.7timer.info/)** — astronomer's cloud-cover forecasts
- **[Light pollution map](https://www.lightpollutionmap.info/)** / **[Sky Quality Meter (SQM)](http://unihedron.com/projects/darksky/)** — measure your night-sky brightness alongside the weather
- **[Heavens-Above](https://heavens-above.com/)** — satellite pass predictions to embed
- **Moon phase rendering:** compute with SunCalc, draw with a CSS mask or an SVG set — see [icons](charts-widgets.md#weather-icons--fonts)

---

## Air quality

Full API list in [weather-apis.md](weather-apis.md#air-quality); hardware in [hardware.md](hardware.md#air-quality).

- **[AirGradient](https://www.airgradient.com/)** — open hardware, local API, outdoor model
- **[Sensor.Community](https://sensor.community/)** — €40 DIY kit, joins a 15 000-node open network
- **[PurpleAir](https://www2.purpleair.com/)** — local `http://<ip>/json` endpoint
- **[Ecowitt WH41/WH43](https://www.ecowitt.com/)** — plugs into your existing gateway, zero integration work
- **Display it properly:** show the pollutant concentration (µg/m³) *and* the AQI band, and say which AQI standard (US EPA vs EU CAQI vs UK DAQI — they disagree substantially).

---

## Lightning

- **[Ecowitt WH57](https://www.ecowitt.com/)** — easiest local strike counter
- **[AS3935 modules](hardware.md#lightning-detection)** — DIY, noise-sensitive, rewarding
- **[Blitzortung.org](https://www.blitzortung.org/)** — build a receiver, join the network, get data access
- **[LightningMaps embed](https://www.lightningmaps.org/)** — free live map on your page
- **Site idea:** a "strikes in the last hour, nearest distance" tile plus a sparkline. During a storm it is the most-refreshed thing on your entire site.

---

## Records, stats & climatology

The reason people bookmark a station site.

- **NOAA-style monthly/yearly reports** — built into WeeWX (`NOAA` reports) and CumulusMX
- **[CumulusUtils](https://cumulususers.eu/)** — records, top-10s, charts, yearly comparisons, generated automatically
- **[Meteostat](https://meteostat.net/)** — pull the 30-year normal for your area and plot "today vs normal". This single chart makes a site feel authoritative.
- **[Open-Meteo Historical](https://open-meteo.com/en/docs/historical-weather-api)** — free ERA5 back to 1940 for the same purpose
- **[xclim](https://xclim.readthedocs.io/)** / **[climdex](https://www.climdex.org/)** — standard climate indices (frost days, summer days, growing season length)
- **Ideas that work:** all-time records table · this month vs the 30-year normal · warmest/coldest day each year · rainfall accumulation vs average (a "race" chart) · first/last frost dates · consecutive dry days · wind rose for the year · "on this day" from your own archive

---

## Forecasting your own

Beyond re-displaying someone else's forecast:

- **[Zambretti forecaster](https://en.wikipedia.org/wiki/Zambretti_Forecaster)** — a 1915 pressure-trend algorithm. Charming, surprisingly decent, ~30 lines of code. Every hobby station should have one.
- **[weewx-forecast](https://github.com/chaunceygardiner/weewx-forecast)** — ingest NWS/Aeris/WU forecasts into your DB
- **[Open-Meteo ensemble & multi-model](https://open-meteo.com/en/docs/ensemble-api)** — show model spread, not a single number. Much more honest.
- **[Herbie](https://herbie.readthedocs.io/)** + **[xarray](https://xarray.dev/)** — download and slice raw GFS/HRRR/ICON output for your exact point
- **[MOS / model-output statistics](https://vlab.noaa.gov/web/mdl/mos)** — the classic bias-correction approach
- **ML nowcasting** — train on your own archive (scikit-learn/PyTorch) to bias-correct the model forecast for your microclimate. A genuinely fun project with real skill gains, and a great excuse for a "how accurate was yesterday's forecast?" verification page.
- **Verification page** — track your forecast (or the model's) against your own observations. Almost nobody does this and it's the most interesting page on any weather site.

---

## Adjacent hobbies

Your Pi and antenna are already up there:

- **[SatDump](https://www.satdump.org/) / [goestools](https://github.com/pietern/goestools)** — receive weather satellites (NOAA APT, Meteor LRPT, GOES) with an SDR
- **[SatNOGS](https://satnogs.org/)** — join a global satellite ground-station network
- **[ADS-B (tar1090 / readsb)](https://github.com/wiedehopf/readsb)** — aircraft tracking; aircraft also report [temperature and wind aloft](https://www.flightradar24.com/)
- **[Radiosonde tracking (radiosonde_auto_rx)](https://github.com/projecthorus/radiosonde_auto_rx)** — receive and even **chase** weather balloons launched near you. Extremely fun.
- **[Blitzortung](https://www.blitzortung.org/)** lightning receiver
- **[Seismographs (Raspberry Shake)](https://raspberryshake.org/)** — earthquakes alongside the weather
- **[GNSS meteorology](https://www.unavco.org/)** — precipitable water vapour from GPS delays
- **[Meshtastic](https://meshtastic.org/)** — LoRa mesh with weather telemetry modules

---

## Accessibility & i18n

Easy to skip, cheap to do, and it's what separates a good site from a nice-looking one.

- **Never encode data in colour alone** — add labels, patterns, or text values
- **Contrast** ≥ 4.5:1 for text; check both themes with [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- **Charts need text alternatives** — a data table behind a `<details>`, or `aria-label` with the summary
- **Units toggle** (°C/°F, mm/in, m/s ⇄ km/h ⇄ mph ⇄ kt) stored in `localStorage`. Your international visitors will thank you.
- **Timezone clarity** — always label; consider a UTC toggle
- **i18n:** [i18next](https://www.i18next.com/), [Paraglide](https://inlang.com/), or just a JSON dictionary. Belchertown, NeoWX and weewx-wdc all ship translations you can crib from.
- **Respect `prefers-reduced-motion`** — kill the auto-scrolling radar loop for those who ask
- **Test:** [axe DevTools](https://www.deque.com/axe/devtools/), [Lighthouse](https://developer.chrome.com/docs/lighthouse/), and actually tabbing through the page

---

[← DIY](diy.md) · [Back to index](../README.md) · [Next: Community →](community.md)
