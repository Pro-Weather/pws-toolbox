<div align="center">

# 🌦️ PWS Toolbox

**Every tool you need to turn a weather station in your garden into a website on the internet.**

Hardware → collection software → database → skin/template → charts → hosting → the networks you upload to.
Curated, categorised, and kept link-checked.

[![Awesome](https://img.shields.io/badge/awesome-list-ff69b4?style=flat-square)](https://github.com/Pro-Weather/pws-toolbox)
[![License: CC0-1.0](https://img.shields.io/badge/license-CC0--1.0-blue?style=flat-square)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?style=flat-square)](CONTRIBUTING.md)
[![Link Check](https://img.shields.io/github/actions/workflow/status/Pro-Weather/pws-toolbox/links.yml?style=flat-square&label=links)](../../actions/workflows/links.yml)

</div>

---

## 🧭 Start here

**Never built one before?** Read [Ready-made stacks](docs/stacks.md) — six complete, proven
hardware-to-website recipes (from "€60 and a Raspberry Pi" to "full pro setup" to "pay someone else
to run it"), so you can copy one instead of choosing 40 things individually.

**Know what you want?** Jump straight to a category:

| | Category | What lives here |
|---|---|---|
| 📡 | **[Hardware](docs/hardware.md)** | Stations, gateways, consoles, sensors — Ecowitt, Davis, Tempest, Ambient, Fine Offset |
| 🧰 | **[Station software](docs/station-software.md)** | WeeWX, CumulusMX, Weather Display, Meteobridge, rtl_433, Home Assistant |
| 🎨 | **[Website templates & skins](docs/website-templates.md)** | Belchertown, NeoWX Material, weewx-wdc, PWS Dashboard, Saratoga, Weather34 |
| 📈 | **[Charts, gauges & widgets](docs/charts-widgets.md)** | Highcharts, ECharts, Chart.js, SteelSeries gauges, windroses, Grafana |
| 🗄️ | **[Databases & storage](docs/data-storage.md)** | SQLite, MariaDB, InfluxDB, TimescaleDB, MQTT, VictoriaMetrics |
| 🔌 | **[Weather data APIs](docs/weather-apis.md)** | Open-Meteo, NWS, Met.no, Pirate Weather, DWD/Bright Sky, radar & satellite |
| 🌍 | **[Networks to upload to](docs/networks.md)** | Weather Underground, CWOP/APRS, Windy, PWSWeather, WOW, AWEKAS, Weathercloud |
| ☁️ | **[Hosting & deployment](docs/hosting.md)** | GitHub Pages, Cloudflare Pages/Tunnel, Docker, nginx, Tailscale, FTP from your Pi |
| 🔧 | **[DIY & build-your-own](docs/diy.md)** | ESP32/ESP8266, BME280, tipping buckets, 3D-printed screens, Astro/Next.js frontends |
| ✨ | **[Extras](docs/extras.md)** | All-sky cameras, lightning, air quality, alerts, Discord/Telegram bots, astronomy |
| 💬 | **[Community & learning](docs/community.md)** | Forums, Discords, subreddits, docs, books, standards |

**Spotted something missing?** → [Contributing](CONTRIBUTING.md) · [Add a tool](../../issues/new?template=add-tool.yml)

---

## ⚡ The 60-second version

A personal weather station website is always the same five links in a chain. Pick one from each row:

```
  ┌─────────────┐   ┌──────────────┐   ┌───────────┐   ┌────────────┐   ┌──────────┐
  │  HARDWARE   │──▶│  COLLECTION  │──▶│  STORAGE  │──▶│  TEMPLATE  │──▶│ HOSTING  │
  │             │   │   SOFTWARE   │   │           │   │  (SKIN)    │   │          │
  ├─────────────┤   ├──────────────┤   ├───────────┤   ├────────────┤   ├──────────┤
  │ Ecowitt     │   │ WeeWX        │   │ SQLite    │   │ Belchertown│   │ Pi+nginx │
  │ Davis       │   │ CumulusMX    │   │ MariaDB   │   │ NeoWX Mat. │   │ Cloudflare│
  │ Tempest     │   │ Weather Disp.│   │ InfluxDB  │   │ weewx-wdc  │   │ GH Pages │
  │ Ambient     │   │ Meteobridge  │   │ MQTT      │   │ PWS Dash.  │   │ Netlify  │
  │ DIY ESP32   │   │ rtl_433      │   │ Timescale │   │ Saratoga   │   │ Vercel   │
  └─────────────┘   └──────────────┘   └───────────┘   └────────────┘   └──────────┘
                              │                                 │
                              └────────▶ 🌍 NETWORKS ◀──────────┘
                              Wunderground · CWOP · Windy · PWSWeather · WOW
```

**The single most common stack in 2026:** Ecowitt GW2000 gateway → WeeWX (Docker) → SQLite →
Belchertown or NeoWX Material skin → served by nginx on a Raspberry Pi behind a Cloudflare Tunnel,
also uploading to Wunderground + CWOP + Windy.
Full walkthrough in [stacks.md](docs/stacks.md#stack-2-the-modern-default).

---

## 🏆 The short list

If you read nothing else, these are the tools that come up in almost every build.

### Collection software

| Tool | Platform | License | Why it's here |
|---|---|---|---|
| **[WeeWX](https://weewx.com/)** | Linux/macOS/BSD, Python | GPL-3.0 | The de-facto open-source standard. ~100 drivers, huge skin/extension ecosystem, generates a full static website for you. |
| **[CumulusMX](https://cumulus.hosiene.co.uk/viewforum.php?f=40)** | Win/Linux/Pi, .NET | Free (closed) | The Windows-world standard, now cross-platform. Built-in web UI, dead simple to get running, massive forum. |
| **[Weather Display](https://www.weather-display.com/)** | Win/Linux/Mac | Paid (~$70) | Ancient, ugly, and supports literally everything. `clientraw.txt` output feeds dozens of templates. |
| **[Meteobridge](https://www.meteobridge.com/)** | Router/NAS/Pi firmware | Paid | Tiny always-on appliance. Set-and-forget uploading to every network at once. |
| **[rtl_433](https://github.com/merbanan/rtl_433)** | Anywhere + RTL-SDR | GPL-2.0 | Receive 433/868/915 MHz sensors with a €25 USB dongle — no console required. |
| **[Home Assistant](https://www.home-assistant.io/)** | Docker/Pi/VM | Apache-2.0 | If you already run HA, it ingests almost any station and can publish dashboards. |

→ Deep dive with 25+ more: **[docs/station-software.md](docs/station-software.md)**

### Website templates & skins

| Template | For | Look |
|---|---|---|
| **[Belchertown](https://github.com/poblabs/weewx-belchertown)** | WeeWX | The classic modern skin. Highcharts, MQTT live updates, forecasts. ([active fork](https://github.com/uajqq/weewx-belchertown-new)) |
| **[NeoWX Material](https://github.com/neoground/neowx-material)** | WeeWX | Material Design, responsive, dark mode, very clean out of the box. |
| **[weewx-wdc](https://github.com/Daveiano/weewx-wdc)** | WeeWX | "Weather Data Center" — dashboard-style, D3 charts, IBM Carbon design. |
| **[PWS Dashboard](https://pwsdashboard.com/)** | Almost anything | PHP dashboard that eats `realtime.txt`, `clientraw.txt`, WU, Ecowitt, WeatherLink… Actively maintained. |
| **[Saratoga Templates](https://saratoga-weather.org/wxtemplates/)** | Cumulus/WeeWX/WD | The old-school powerhouse. Enormous script library, every page you could want. |
| **[Weather34](https://weather34.com/homeweatherstation/)** | Cumulus/WeeWX | Beautiful dark dashboard aesthetic that half the hobby has copied. |
| **[CU-HWS](https://github.com/ktrue/CU-HWS)** | Cumulus/WeeWX/WeatherCat | Ken True's Home Weather Station template — modern, maintained, well-documented. |
| **[Pro Weather](https://pro-weather.com/)** ᴹ | Davis/WeatherLink (+ upload URL) | Hosted, not self-run: paste a WeatherLink v2 key, get a site on your domain. Paid, ~€6/mo. |

<sub>ᴹ = built by the maintainers of this list. See [the full entry](docs/website-templates.md#pro-weather) for trade-offs.</sub>

→ Deep dive with 30+ more: **[docs/website-templates.md](docs/website-templates.md)**

### Free data APIs (no credit card)

| API | Key needed | Coverage | Notes |
|---|---|---|---|
| **[Open-Meteo](https://open-meteo.com/)** | ❌ No | 🌍 Global | 30+ models, history back to 1940, self-hostable. **Start here.** |
| **[Met.no / YR](https://api.met.no/)** | ❌ No (UA header) | 🌍 Global | Norwegian Met Institute. Excellent, free, just identify yourself. |
| **[NWS / api.weather.gov](https://www.weather.gov/documentation/services-web-api)** | ❌ No | 🇺🇸 US | Official US forecasts, alerts, observations. |
| **[Bright Sky](https://brightsky.dev/)** | ❌ No | 🇩🇪 DE | Friendly JSON wrapper around DWD open data. |
| **[Pirate Weather](https://pirateweather.net/)** | ✅ Free tier | 🌍 Global | Drop-in Dark Sky replacement — same JSON shape. |
| **[RainViewer](https://www.rainviewer.com/api.html)** | ❌ No (free tier) | 🌍 Global | Radar tiles for your Leaflet map, past + nowcast. |

→ Deep dive with 30+ more, incl. radar/satellite/lightning: **[docs/weather-apis.md](docs/weather-apis.md)**

### Networks to publish to

| Network | Cost | Why bother |
|---|---|---|
| **[Weather Underground](https://www.wunderground.com/pws/overview)** | Free | Biggest PWS network, everyone links to it. |
| **[CWOP / APRS](http://www.wxqa.com/)** | Free | Your data goes into **NOAA's forecast models**. Genuinely useful science. |
| **[Windy.com](https://community.windy.com/topic/26/how-to-add-your-weather-station-to-windy-com)** | Free | Huge audience, gorgeous map, easy setup. |
| **[PWSWeather](https://www.pwsweather.com/)** | Free | Aeris/Vaisala network, clean dashboards. |
| **[Met Office WOW](https://wow.metoffice.gov.uk/)** | Free | Official UK Met Office citizen network (global submissions accepted). |
| **[AWEKAS](https://www.awekas.at/)** | Free/Pro | Big in DE/AT/CH, good stats & rankings. |

→ Deep dive with 20+ more incl. regional networks: **[docs/networks.md](docs/networks.md)**

---

## 💸 Budget reality check

| Budget | What you get | Stack |
|---|---|---|
| **€0** | Website pulling from a free API — no hardware. Looks real, isn't yours. | Open-Meteo + Astro + Cloudflare Pages → [DIY](docs/diy.md) |
| **~€30** | Receive your *neighbours'* 433 MHz sensors with an SDR dongle. | RTL-SDR + rtl_433 + WeeWX → [software](docs/station-software.md#rtl_433) |
| **~€60–120** | Real DIY station: ESP32 + BME280 + tipping bucket, 3D-printed screen. | [DIY](docs/diy.md) |
| **~€150–250** | Ecowitt WS2910/WS90 + GW2000 gateway. The hobby's sweet spot. | [Stack 2](docs/stacks.md#stack-2-the-modern-default) |
| **~€300–450** | Tempest (no moving parts) or Ambient WS-5000. | [Hardware](docs/hardware.md) |
| **€700+** | Davis Vantage Pro2 + WeatherLink Live. Research-grade, 20-year lifespan. | [Stack 4](docs/stacks.md#stack-4-the-davis-classic) |
| **€2000+** | Fan-aspirated Davis / Vaisala. You are no longer a hobbyist. | [Hardware](docs/hardware.md#professional--research-grade) |
| **+ ~€6/mo** | Skip the server entirely — hosted site on your own domain. | [Stack 6](docs/stacks.md#stack-6-hosted-no-server) |

> The recurring cost of the self-hosted routes isn't €0 either — it's the evening you spend when the
> SD card dies. Price both honestly.

---

## 📚 All categories

- **[docs/stacks.md](docs/stacks.md)** — Six copy-me end-to-end builds
- **[docs/hardware.md](docs/hardware.md)** — Stations, gateways, individual sensors, siting guidance
- **[docs/station-software.md](docs/station-software.md)** — Collection, logging & upload software
- **[docs/website-templates.md](docs/website-templates.md)** — Skins, templates, dashboards
- **[docs/charts-widgets.md](docs/charts-widgets.md)** — Charting libs, gauges, windroses, embeds
- **[docs/data-storage.md](docs/data-storage.md)** — Databases, time-series, MQTT, backups
- **[docs/weather-apis.md](docs/weather-apis.md)** — Forecast, radar, satellite, lightning, air quality APIs
- **[docs/networks.md](docs/networks.md)** — Where to upload your observations
- **[docs/hosting.md](docs/hosting.md)** — Static hosts, tunnels, Docker, reverse proxies, TLS
- **[docs/diy.md](docs/diy.md)** — Build the sensors *and* the frontend yourself
- **[docs/extras.md](docs/extras.md)** — Cameras, alerts, bots, astronomy, air quality, moon phase
- **[docs/community.md](docs/community.md)** — Forums, Discords, wikis, standards, further reading

---

## 🤝 Contributing

Found a tool that isn't here? A dead link? A template that got abandoned?

1. Open an [Add a tool issue](../../issues/new?template=add-tool.yml) — 30 seconds, no git required, **or**
2. Send a PR editing the relevant `docs/*.md` file.

Rules of thumb: it must be **usable today**, **relevant to building or running a personal
weather station website**, and get **one line saying what makes it different**.
See [CONTRIBUTING.md](CONTRIBUTING.md).

## 🪧 Disclosure

This list is maintained by [Pro-Weather](https://github.com/Pro-Weather), who also build
[Pro Weather](https://pro-weather.com/) — a paid hosted service for Davis/WeatherLink stations.
It's listed here, marked **ᴹ**, and held to the same bar as everything else: what it does, what it
costs, and when *not* to use it. Free and self-hosted alternatives come first throughout, because
for most people they're the right answer. If you ever think an entry reads like an advert rather
than an assessment, [say so in an issue](../../issues/new?template=add-tool.yml) — that's a bug.

## 📄 License

[CC0-1.0](LICENSE) — public domain. Copy it, fork it, mirror it, no attribution needed.
Linked projects keep their own licenses.

<div align="center">
<sub>Maintained by <a href="https://github.com/Pro-Weather">Pro-Weather</a></sub>
</div>
