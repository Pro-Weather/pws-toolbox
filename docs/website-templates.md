# 🎨 Website templates & skins

The actual website. Four broad approaches:

1. **Skins** — your station software renders the site for you (WeeWX skins). Easiest, most robust.
2. **Templates** — a PHP/JS site that reads a live data file (`realtime.txt`, `clientraw.txt`, JSON)
   your software writes. Software-agnostic, more features, more setup.
3. **Hosted services** — you paste an API key, they run the site. No server, no maintenance, a monthly fee.
4. **Roll your own** — see [docs/diy.md](diy.md) and [docs/charts-widgets.md](charts-widgets.md).

[← Back to index](../README.md)

---

## Contents

- [Comparison table](#comparison-table)
- [Hosted services (no server)](#hosted-services-no-server)
- [WeeWX skins](#weewx-skins)
- [Software-agnostic templates](#software-agnostic-templates)
- [CumulusMX templates & add-ons](#cumulusmx-templates--add-ons)
- [Dashboard-style / self-hosted apps](#dashboard-style--self-hosted-apps)
- [Starters for building your own](#starters-for-building-your-own)
- [Legacy / historical](#legacy--historical)

---

## Comparison table

| Template | Works with | Tech | Live updates | Mobile | Maintained |
|---|---|---|---|---|---|
| [Belchertown](#belchertown) | WeeWX | Jinja + Highcharts | ✅ MQTT websocket | ✅ | ⚠️ original slow, fork active |
| [NeoWX Material](#neowx-material) | WeeWX | Jinja + Chart.js | ➖ page refresh | ✅ | ✅ |
| [weewx-wdc](#weewx-wdc) | WeeWX | Jinja + D3/Carbon | ➖ | ✅ | ✅ |
| [Seasons](#seasons-standard--the-built-ins) | WeeWX | built-in | ➖ | ✅ | ✅ core |
| [weewx-jas](#weewx-jas) | WeeWX | Bootstrap + ECharts | ✅ MQTT | ✅ | ✅ |
| [PWS Dashboard](#pws-dashboard) | Almost anything | PHP | ✅ AJAX | ✅ | ✅ |
| [Saratoga](#saratoga-weather-website-templates) | Cumulus/WeeWX/WD | PHP + AJAX | ✅ AJAX | ✅ | ✅ |
| [Weather34](#weather34) | Cumulus/WeeWX | PHP | ✅ AJAX | ✅ | ⚠️ slowed |
| [CU-HWS](#cu-hws) | Cumulus/WeeWX/WeatherCat | PHP | ✅ AJAX | ✅ | ✅ |
| [CumulusUtils](#cumulusutils) | CumulusMX | C# generator | ✅ | ✅ | ✅ |
| [Grafana](charts-widgets.md#grafana) | Anything → TSDB | Go/React | ✅ | ✅ | ✅ |
| [Pro Weather](#pro-weather) | Davis/WeatherLink first, others via upload URL | hosted SaaS | ➖ 10-min refresh | ✅ | ✅ paid |

---

## Hosted services (no server)

You never touch a server, a skin file or a cron job — you connect an account and configure the site
in a browser. The trade-off is a subscription and less control over the markup.

### Pro Weather
**[pro-weather.com](https://pro-weather.com/)** · free 14-day trial, then €5.99/mo or €59/yr per site

> ℹ️ **Maintainer's own product.** Pro Weather is built by [Pro-Weather](https://github.com/Pro-Weather),
> who also maintain this list. Listed because it's a genuine option in this category — judge it on
> the same criteria as everything else here.

Turns a **Davis WeatherLink** account into a hosted weather website on your own domain. You paste
your WeatherLink **v2 API key and secret**; it auto-discovers your stations and sensors and deploys
a site — no server, no PHP, no Raspberry Pi in the attic.

- **Eleven tabs** of live conditions, charts, history, records and forecast — each optional and reorderable
- **7-day daily + hourly forecast** for the station's exact location
- **Permanent history archive** — charts from 24 h up to a full year, plus a 30-day wind rose. This is
  the main technical reason to use it: it solves [WeatherLink's short retention window](#the-weatherlink-retention-problem) without you running a database.
- **Records & almanac** — all-time highs/lows, monthly climate summaries, yearly extremes, and a banner when today breaks a record
- **Branding** — logo, banner photo, fonts, colours, dark mode, about section, social links; branding removal on paid plans
- **Custom domain with automatic SSL**, or a free subdomain
- EN/NL/FR/DE, metric or imperial, Google Analytics, email alerts, monthly station reports, installs as a phone app
- **AirLink** air-quality panels if you have one

**Compatibility beyond Davis:** every site gets a personal upload URL, so
[Ecowitt/Fine Offset](hardware.md#all-in-one-consumer-stations) gateways (including Froggit and
Ambient) can post directly with no PC in between, and [WeeWX](station-software.md#weewx),
[Meteobridge](station-software.md#meteobridge) or [CumulusMX](station-software.md#cumulusmx) can
relay almost anything else. It can also forward your observations on to
[Weather Underground, WOW, CWOP and Windy](networks.md).

**Live example:** [weerstationardooie.be](https://weerstationardooie.be) — a real site running on it.
[Docs](https://pro-weather.com/docs) · [Blog](https://pro-weather.com/blog)

**Choose it if:** you own a Davis station, want a polished public site today, and would rather pay
€6/month than maintain a Pi. **Skip it if:** you want to own the stack end to end, you're not on
Davis/Ecowitt, or a recurring per-site fee is the wrong shape for you — [WeeWX + a free skin](#weewx-skins)
costs nothing but your time.

#### The WeatherLink retention problem

Worth understanding whichever route you take: Davis's WeatherLink cloud keeps **detailed history for
a limited window** depending on your subscription tier, so a site that only reads the live API can't
build multi-year charts or all-time records. Every long-lived Davis setup solves this by archiving
readings somewhere permanent — either **your own database** ([WeeWX/Cumulus + SQLite or MariaDB](data-storage.md)),
or a hosted service that archives for you. Decide this before you have two years of history you
can't get back.

---

## WeeWX skins

Install with `weectl extension install <url>`, then point `weewx.conf` at it. The generated HTML
lands in `HTML_ROOT` — serve that directory with any web server.

### Belchertown
**[github.com/poblabs/weewx-belchertown](https://github.com/poblabs/weewx-belchertown)** ·
active fork: **[uajqq/weewx-belchertown-new](https://github.com/uajqq/weewx-belchertown-new)**

The skin that defined what a modern PWS site looks like. Named after
[BelchertownWeather.com](https://belchertownweather.com/).

- **Real-time streaming via MQTT over websockets** — numbers tick without a page reload
- Interactive Highcharts graphs, fully configurable in `graphs.conf`
- Forecast integration (Aeris, NWS, Open-Meteo via forks), almanac, earthquake panel
- ~20 translations
- Needs: [weewx-mqtt](https://github.com/matthewwall/weewx-mqtt) + a broker for the live features

> The original repo has slowed; **the `uajqq` fork is where active development happens**. Check both before installing.

### NeoWX Material
**[github.com/neoground/neowx-material](https://github.com/neoground/neowx-material)** · MIT

Material Design skin — arguably the best-looking thing you can get running in ten minutes.

- Genuine dark mode, fully responsive, cards-based layout
- Chart.js graphs, configurable colours and units
- Multi-language, lightweight, no external services required
- Great default choice if you don't want to run MQTT

### weewx-wdc
**[github.com/Daveiano/weewx-wdc](https://github.com/Daveiano/weewx-wdc)** · MIT

"Weather Data Center". Built with a real frontend toolchain (TypeScript, D3, IBM Carbon Design
System) and it shows — dense, professional, dashboard-first.

- D3-based charts, extensive per-observation configuration
- Optional MQTT live updates, NOAA reports, climatological views
- Excellent [documentation site](https://github.com/Daveiano/weewx-wdc/wiki)

### Seasons, Standard & the built-ins
Shipped with WeeWX. **Seasons** is the modern default: responsive, tabbed sensor groups, works
immediately with zero configuration. Do not underestimate it — it's a perfectly respectable public
site, and it never breaks on upgrade. [Docs](https://www.weewx.com/docs/latest/usersguide/).

### weewx-jas
**[github.com/bellrichm/weewx-jas](https://github.com/bellrichm/weewx-jas)**

Bootstrap + Apache ECharts skin with MQTT live updates and a strong focus on configurability and
multi-year comparison charts.

### Other WeeWX skins worth a look
| Skin | Notes |
|---|---|
| **[weewx-Bootstrap](https://github.com/brewster76/fuzzy-archer)** (Fuzzy Archer) | Bootstrap skin + gauges, long-running project |
| **[weewx-WD (Weewx-Weather-Display)](https://github.com/gjr80/weewx-weewx-wd)** | Emits `clientraw.txt` so WD-format templates work with WeeWX. **The key bridge** if you want Saratoga/Weather34 on WeeWX. |
| **[Sofaskin](https://github.com/gjr80/weewx-sofaskin)** | Minimal, clean, easy to hack |
| **[weewx-nuvo / weewx-material](https://github.com/topics/weewx-skin)** | Browse the whole `weewx-skin` topic — new ones appear regularly |
| **[Weather34 for WeeWX](https://github.com/steepleian/weewx-Weather34)** | Weather34 look, ported to WeeWX |
| **[weewx-influx + Grafana](charts-widgets.md#grafana)** | Skip skins entirely; publish a Grafana dashboard |

📎 **Browse:** [github.com/topics/weewx-skin](https://github.com/topics/weewx-skin) ·
[WeeWX wiki skin list](https://github.com/weewx/weewx/wiki)

---

## Software-agnostic templates

These read a live data file and don't care who wrote it — which makes them the most flexible option.

### PWS Dashboard
**[pwsdashboard.com](https://pwsdashboard.com/)** · PHP · free

Wim van der Kuil's dashboard. Probably the most *compatible* template in existence: it accepts
`realtime.txt` (Cumulus, WeeWX, WeatherCat, Meteobridge, WiFiLogger, WeatherLink),
`clientraw.txt` (Weather Display, Meteohub, WsWin), **or** cloud APIs
(WeatherLink v1/v2, Wunderground, Ambient, WeatherFlow, Ecowitt custom upload).

- Actively maintained, self-updating via `PWS_updates.php`
- Multi-language, dark mode, radar/satellite panels, air quality, webcams
- Requires PHP hosting (shared hosting is fine)

### Saratoga Weather Website Templates
**[saratoga-weather.org/wxtemplates](https://saratoga-weather.org/wxtemplates/)** ·
[CumulusMX setup guide](https://saratoga-weather.org/wxtemplates/setup-CumulusMX.php) · PHP

Ken True's long-running template suite. Not the prettiest, but it has **every page you could
possibly want**: forecasts, advisories, radar, tides, earthquakes, air quality, station status,
climate reports, plus a big library of standalone PHP scripts you can borrow individually.

- Works with Cumulus/CumulusMX, WeeWX (via weewx-WD), Weather Display, Meteobridge, WeatherCat
- Base-USA and Base-World variants
- Ken maintains the scripts actively — when an upstream API dies, a replacement usually appears within days

### CU-HWS
**[github.com/ktrue/CU-HWS](https://github.com/ktrue/CU-HWS)** · PHP

Also by Ken True — a **modern, lighter** Home Weather Station template for Cumulus/CumulusMX,
WeeWX and WeatherCat. Good middle ground if the full Saratoga suite is too much.

### Weather34
**[weather34.com/homeweatherstation](https://weather34.com/homeweatherstation/)** · PHP

Brian Underdown's template. The dark, tile-based aesthetic that a huge fraction of the hobby
imitates. Gorgeous, opinionated, and quite involved to configure.

- Cumulus (`realtime.txt`) and Ecowitt-direct variants; [WeeWX port](https://github.com/steepleian/weewx-Weather34)
- Development has slowed — check the [support forum](https://cumulus.hosiene.co.uk/) for the current recommended release

### Leuven template
**[meteo-leuven.be](https://www.meteo-leuven.be/)** style templates — Belgian/Dutch community
templates built on Cumulus webtags. Ask on the [Cumulus forum](https://cumulus.hosiene.co.uk/) for
current versions.

---

## CumulusMX templates & add-ons

### CumulusUtils
**[cumulususers.eu](https://cumulususers.eu/)** · by Hans Rottier

A generator that turns your CumulusMX data into a full website: charts, records, top-10s, maps,
yearly/monthly reports, station map, and more. Extremely popular in the Benelux community and very
actively developed. If you run CumulusMX, look at this before anything else.

### Built-in CumulusMX web interface
Ships with a perfectly usable default site (`web/` folder) — dashboard, charts, records, reports.
Many people just restyle this and stop there. [Wiki: Customised templates](https://www.cumuluswiki.org/a/Customised_templates)

### Webtags
**[cumuluswiki.org/a/Webtags](https://www.cumuluswiki.org/a/Webtags)** — the mail-merge system:
put `<#temp>` in an HTML file, Cumulus substitutes the value and uploads it. This is how you write a
completely custom site with zero programming.

---

## Dashboard-style / self-hosted apps

| Project | Notes |
|---|---|
| **[Grafana](https://grafana.com/)** | Point it at InfluxDB/Timescale, build a dashboard, publish it read-only. Best time-to-value of anything on this page. See [charts](charts-widgets.md#grafana). |
| **[Weewx-Reports / weewx-jas](https://github.com/bellrichm/weewx-jas)** | Comparison/analysis-heavy views |
| **[Meteotemplate](https://www.meteotemplate.com/)** | PHP template + plugin system, big in EU. ⚠️ development has largely stopped; still widely deployed. |
| **[wx-dashboard projects](https://github.com/topics/weather-dashboard)** | A long tail of modern React/Vue dashboards on GitHub — quality varies, but several are excellent starting points |
| **[Home Assistant + Lovelace](https://www.home-assistant.io/)** | Private dashboard; combine with [HA Cloud / a reverse proxy](hosting.md) for public read-only views |
| **[Windy / WU embeds](networks.md)** | Sometimes the fastest "website" is an iframe of your station page on a big network |

---

## Starters for building your own

If you want a bespoke site — Astro/Next/SvelteKit + a data source. Details in [diy.md](diy.md).

| Starter | Stack |
|---|---|
| **[Astro](https://astro.build/)** + Open-Meteo + your own JSON | Static, fast, free on Cloudflare Pages. **Best default for a custom site.** |
| **[Next.js](https://nextjs.org/)** + API routes reading your DB | If you want server-rendered live data + ISR |
| **[SvelteKit](https://svelte.dev/)** / **[Nuxt](https://nuxt.com/)** | Same idea, different flavour |
| **[Hugo](https://gohugo.io/)** / **[Eleventy](https://www.11ty.dev/)** | Regenerate the site from a cron job — very close to how WeeWX skins already work |
| **[shadcn/ui](https://ui.shadcn.com/)** + **[Tailwind](https://tailwindcss.com/)** | Component layer so your dashboard doesn't look homemade |
| **[Grafana Scenes](https://grafana.com/developers/scenes/)** | Embed Grafana-quality panels in your own React app |

---

## Legacy / historical

Useful to recognise in old forum threads; **don't start new projects on these**.

- **Meteotemplate** — see above; effectively frozen
- **Carterlake / Saratoga v1** templates — the ancestor of the modern Saratoga suite
- **AJAX Cumulus templates (Beteljuice)** — many scripts still circulate
- **wxsim / WD PHP templates** — Weather Display-era pages
- **Weather Underground "Personal Weather Station" widgets v1/v2** — the free widget API was retired; use [network embeds](networks.md) or your own charts instead
- **Dark Sky API / Forecast.io widgets** — API shut down 2023. Migrate to [Pirate Weather](weather-apis.md) (drop-in) or [Open-Meteo](weather-apis.md).

---

[← Station software](station-software.md) · [Back to index](../README.md) · [Next: Charts & widgets →](charts-widgets.md)
