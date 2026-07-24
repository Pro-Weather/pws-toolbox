# 🌍 Networks to upload to

Uploading is free, takes ten minutes, and gives you: a public page you can link to, an independent
backup of your data, third-party charts, and — with CWOP — an actual contribution to weather
forecasting.

Every serious station uploads to **at least three**: one big consumer network (Wunderground),
one scientific network (CWOP), one map (Windy).

[← Back to index](../README.md)

---

## Contents

- [The big four](#the-big-four)
- [Official / national citizen networks](#official--national-citizen-networks)
- [Community & regional networks](#community--regional-networks)
- [Specialist networks](#specialist-networks)
- [Vendor clouds](#vendor-clouds)
- [How the upload actually works](#how-the-upload-actually-works)
- [Embedding your network page](#embedding-your-network-page)

---

## The big four

### Weather Underground
**[wunderground.com/pws/overview](https://www.wunderground.com/pws/overview)** · free · 🌍 global

The largest PWS network (~250 000 stations). Every station gets a public page and a station ID
(e.g. `IBRUSS42`). Supported by literally every piece of station software.

- ✅ Biggest audience, everyone recognises it, good historical tables
- ⚠️ Owned by IBM/The Weather Company. The free API for *reading* your own data was heavily
  restricted years ago — you can still upload freely, but don't build your site on their read API.
- Setup: register the station → get station ID + key → paste into WeeWX/Cumulus

### CWOP (Citizen Weather Observer Program)
**[wxqa.com](http://www.wxqa.com/)** · free · 🌍 global (via APRS-IS)

**The one that matters scientifically.** Your observations are quality-controlled by NOAA/MADIS and
ingested into operational forecast models (RTMA/HRRR analysis).

- Register at [madis-data.ncep.noaa.gov/CWOPRequest](https://madis-data.ncep.noaa.gov/cgi-bin/madisRegistration.pl) → you get a station ID (`CW####`, `DW####`, `EW####`)
- Radio amateurs use their callsign directly
- **Check your quality:** [MADIS QC page](https://madis-data.ncep.noaa.gov/madisPublic1/data/) and
  [findu.com](https://www.findu.com/) show how your station compares to its neighbours and to the
  model analysis. It is *extremely* satisfying, and it will find your siting problems for you.
- Requires reasonably good siting to be useful — read [hardware.md#siting--mounting](hardware.md#siting--mounting) first

### Windy.com
**[Add your station](https://community.windy.com/topic/26/how-to-add-your-weather-station-to-windy-com)** · free · 🌍 global

Huge consumer audience, beautiful map, simple REST upload API. Your station appears as a live pin
that thousands of people will actually see.

### PWSWeather
**[pwsweather.com](https://www.pwsweather.com/)** · free · 🌍 global

Run by AerisWeather (Vaisala Xweather). Clean dashboards, reliable, no drama. Supported by all
mainstream software.

---

## Official / national citizen networks

Run by actual met services — the most credible place your data can appear.

| Network | Country | Notes |
|---|---|---|
| **[Met Office WOW](https://wow.metoffice.gov.uk/)** | 🇬🇧 + global | The UK Met Office's citizen network; accepts worldwide submissions. Clean API, official standing. |
| **[WOW-NL](https://wow.knmi.nl/)** | 🇳🇱 | KNMI's WOW instance |
| **[KNMI / IRM-KMI citizen data](https://www.meteo.be/)** | 🇧🇪🇳🇱 | Regional programmes; see also [Meteoclub.be](https://www.meteoclub.be/) |
| **[DWD Wettermeldungen / Wetterdienst-Netzwerke](https://www.dwd.de/)** | 🇩🇪 | Via AWEKAS/Wetter-Netzwerke partners |
| **[MeteoNetwork](https://www.meteonetwork.eu/)** | 🇮🇹 + EU | Large, well-run Italian association with an open API |
| **[Météo-France Observations citoyennes](https://meteofrance.com/)** | 🇫🇷 | Via partner networks such as [InfoClimat](https://www.infoclimat.fr/) |
| **[Environment Canada / CoCoRaHS](https://www.cocorahs.org/)** | 🇨🇦🇺🇸 | **CoCoRaHS** — manual daily rain/hail/snow reports. Low-tech, high scientific value, huge community. |
| **[BOM Weather Observations](http://www.bom.gov.au/)** | 🇦🇺 | Limited citizen intake; [WeatherZone](https://www.weatherzone.com.au/) is the practical route |

---

## Community & regional networks

| Network | Region | Notes |
|---|---|---|
| **[AWEKAS](https://www.awekas.at/)** | 🇦🇹🇩🇪🇨🇭 + global | Big, well-featured, rankings and stats. Free + paid tiers. Supported by WeeWX/Cumulus natively. |
| **[Weathercloud](https://weathercloud.net/)** | 🌍 | Attractive station pages, free tier, easy embeds |
| **[Wetter-Netzwerk / Wetterstationen.info](https://www.wetterstationen.info/)** | 🇩🇪 | German network + station directory |
| **[InfoClimat](https://www.infoclimat.fr/)** | 🇫🇷 | Excellent French association, StatIC network, strict siting standards |
| **[Meteoclimatic](https://www.meteoclimatic.net/)** | 🇪🇸🇵🇹 | Iberian network |
| **[Meteolive / Meteonetwork](https://www.meteonetwork.eu/)** | 🇮🇹 | |
| **[Weerstations.nl / Weerhuisje](https://www.weerhuisje.nl/)** | 🇳🇱 | Dutch community |
| **[Meteobelgique](https://www.meteobelgique.be/)** · **[Meteoclub.be](https://www.meteoclub.be/)** | 🇧🇪 | Belgian communities — worth joining if you're local |
| **[Anemoi](https://www.anemoi.eu/)** | 🇪🇺 | |
| **[Weather Underground alternatives list](https://www.wxforum.net/)** | 🌍 | The forum keeps the definitive current list |
| **[Windguru](https://www.windguru.cz/)** | 🌍 | Kite/windsurf-focused; upload a station if you're near water |
| **[Weatherlink.com](https://www.weatherlink.com/)** | 🌍 | Davis's own network (see [vendor clouds](#vendor-clouds)) |
| **[OpenWeatherMap Stations API](https://openweathermap.org/stations)** | 🌍 | Contribute your data into OWM's model |
| **[Sensor.Community](https://sensor.community/)** | 🌍 | Air quality + basic weather, fully open data |
| **[Netatmo Weathermap](https://weathermap.netatmo.com/)** | 🌍 | Automatic if you own a Netatmo |

---

## Specialist networks

- **[CoCoRaHS](https://www.cocorahs.org/)** — 🇺🇸🇨🇦 manual precipitation observers. A proper 4" gauge and five minutes a day. Genuinely valuable data.
- **[Blitzortung.org](https://www.blitzortung.org/)** — host a lightning receiver, get network data access
- **[GLOBE Program](https://www.globe.gov/)** — NASA-backed school/citizen science observations
- **[mPING](https://mping.ou.edu/)** — 🇺🇸 crowd-sourced precipitation *type* reports (rain vs sleet vs snow) that verify radar algorithms
- **[Skywarn / Spotter Network](https://www.spotternetwork.org/)** — 🇺🇸 trained severe-weather spotters
- **[Snow Spotters / CoCoRaHS snow](https://www.cocorahs.org/)** — snow depth and SWE
- **[WOW phenology / nature networks](https://www.naturescalendar.org.uk/)** — if you like the seasonal-observation side
- **[Weather Observations Website (aviation) / OGIMET](https://www.ogimet.com/)** — SYNOP/METAR archives
- **[APRS-IS](https://www.aprs-is.net/)** — if you're a licensed amateur, your weather goes out over RF too

---

## Vendor clouds

You'll usually end up on one of these automatically. Useful as a free backup and a shareable page,
but **don't make them your only copy**.

| Cloud | For | Public page? | Local data escape? |
|---|---|---|---|
| **[Ecowitt.net](https://www.ecowitt.net/)** | Ecowitt/Fine Offset | ✅ shareable dashboards | ✅ yes, plus custom upload |
| **[WeatherLink.com](https://www.weatherlink.com/)** | Davis | ✅ | ✅ [v2 API](https://weatherlink.github.io/v2-api/) |
| **[Ambient Weather Network](https://ambientweather.net/)** | Ambient | ✅ | ✅ [API](https://ambientweather.docs.apiary.io/) |
| **[Tempest / WeatherFlow](https://tempestwx.com/)** | Tempest | ✅ | ✅ REST + local UDP |
| **[Netatmo](https://weathermap.netatmo.com/)** | Netatmo | ✅ | ⚠️ cloud OAuth API only |
| **[Meteobridge cloud](https://www.meteobridge.com/)** | Meteobridge users | ✅ | ✅ |

---

## How the upload actually works

Almost all of these speak one of three dialects. Your software handles it — but knowing this makes
debugging trivial.

**1. Wunderground protocol (HTTP GET)** — the universal fallback. Many networks (PWSWeather, WOW,
Windy, OWM stations) accept a WU-shaped request:
```
GET https://rtupdate.wunderground.com/weatherstation/updateweatherstation.php
    ?ID=ISTATION1&PASSWORD=xxxx&dateutc=now
    &tempf=68.2&humidity=61&baromin=29.92&windspeedmph=4.1&winddir=210&dailyrainin=0.12
    &action=updateraw&realtime=1&rtfreq=5
```

**2. Ecowitt protocol (HTTP POST, form-encoded)** — richer field set (soil, PM2.5, lightning,
leaf wetness, multi-channel sensors). Prefer this where supported, e.g. when pointing your gateway
at *your own* server.

**3. APRS/CWOP (TCP text packet)** — connect to `cwop.aprs.net:14580`, log in, send one line:
```
CW1234>APRS,TCPIP*:@241830z5052.00N/00423.00E_210/004g008t068r000p012P008h61b10132
```
Your software builds this for you. The `wxnow.txt` format is the same data for APRS clients.

**Setting it up in practice:**
- **WeeWX** → `weewx.conf` `[StdRESTful]` sections (`[[Wunderground]]`, `[[CWOP]]`, `[[PWSweather]]`, `[[WOW]]`, `[[AWEKAS]]`, `[[Windy]]`) — mostly built in
- **CumulusMX** → Settings → Internet Settings → per-network tabs. The most complete built-in uploader set of any software.
- **Meteobridge** → one config page, ~30 services, tick the boxes
- **Ecowitt gateway** → Weather Services page: WU + Ecowitt + two custom servers, directly from the hardware, **no computer required**

---

## Embedding your network page

Most networks give you an embeddable widget or at least a stable URL to link:

- **Windy:** `https://embed.windy.com/embed2.html?lat=..&lon=..&detailLat=..&detailLon=..&type=station`
- **Weathercloud:** account → Devices → Widgets (several sizes, iframe)
- **Wunderground:** the old free widget API is gone; link to `https://www.wunderground.com/dashboard/pws/<ID>` instead
- **Ecowitt.net:** Dashboard → Share → public link
- **CWOP:** link to `https://www.findu.com/cgi-bin/wxpage.cgi?call=<ID>` and the
  [MADIS QC plot](https://madis-data.ncep.noaa.gov/) — a great "proof my data is good" page
- **Better idea:** don't embed at all. Serve your own data from your own charts
  ([charts-widgets.md](charts-widgets.md)) and *link* to the network pages. Iframes are slow,
  break, and leak your visitors to third parties.

---

[← Weather APIs](weather-apis.md) · [Back to index](../README.md) · [Next: Hosting →](hosting.md)
