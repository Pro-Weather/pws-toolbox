# 🧰 Station software

The program that talks to your hardware, writes readings to a database, and pushes them onward.
This is the single most important choice you make — it determines which
[templates](website-templates.md) you can use and which [networks](networks.md) you can upload to.

[← Back to index](../README.md)

---

## Contents

- [Pick one in 30 seconds](#pick-one-in-30-seconds)
- [Open source](#open-source)
- [Freeware & commercial](#freeware--commercial)
- [Radio / SDR receivers](#radio--sdr-receivers)
- [Home automation platforms](#home-automation-platforms)
- [Drivers & extensions](#drivers--extensions)
- [Uploaders & bridges](#uploaders--bridges)
- [Running it in Docker](#running-it-in-docker)

---

## Pick one in 30 seconds

| If you… | Use |
|---|---|
| …run Linux and want maximum control + ecosystem | **[WeeWX](#weewx)** |
| …want a GUI, a built-in web server, and zero Python | **[CumulusMX](#cumulusmx)** |
| …want an appliance you configure once and forget | **[Meteobridge](#meteobridge)** |
| …have no console, just an SDR dongle | **[rtl_433](#rtl_433)** |
| …already run Home Assistant for everything else | **[Home Assistant](#home-assistant)** |
| …have an obscure old station nothing else supports | **[Weather Display](#weather-display)** |
| …want to write it yourself in Python/Node/Go | [docs/diy.md](diy.md) |

---

## Open source

### WeeWX
**[weewx.com](https://weewx.com/)** · [GitHub](https://github.com/weewx/weewx) · Python · GPL-3.0 · Linux/macOS/BSD

The reference implementation of "hobby weather software". Small, boring, extremely stable — people
run WeeWX installs for a decade without touching them.

- **~100 hardware drivers** (Davis, Ecowitt/Fine Offset, Acurite, Tempest, Ambient, rtl_433, …)
- **Generates a complete static website** every archive interval — you literally just need a web server
- Enormous [extension catalogue](https://github.com/weewx/weewx/wiki/wee_extension) — MQTT, forecasts, alerts, uploads
- SQLite by default, MySQL/MariaDB optional
- Docs are genuinely excellent: [Users Guide](https://www.weewx.com/docs/latest/usersguide/)

**Key links:** [Wiki](https://github.com/weewx/weewx/wiki) · [weewx-user group](https://groups.google.com/g/weewx-user) · [Docker image](https://github.com/felddy/weewx-docker)

### pywws
**[GitHub](https://github.com/jim-easterbrook/pywws)** · Python · GPL-2.0

Lightweight logger for **Fine Offset USB** stations. Predates most of the modern ecosystem, still
works, still maintained-ish. Good on a very low-power device.

### wview / wview-ng
**[GitHub](https://github.com/leon-anavi/wview)** · C · GPL

Legacy C daemon for Davis/Fine Offset. Mostly historical now — listed because you will find old
tutorials referencing it. Prefer WeeWX for new builds.

### weatherd / Open Weather Station projects
- **[Open Weather Station (OWS)](https://openweatherstation.com/)** — open hardware + software project
- **[WeatherStation by BME](https://github.com/topics/weather-station)** — the GitHub topic itself is worth browsing

### Ecowitt-specific open tooling
- **[ecowitt2mqtt](https://github.com/bachya/ecowitt2mqtt)** — turns Ecowitt custom-upload POSTs into MQTT. Excellent glue.
- **[Ecowitt local API docs (unofficial)](https://github.com/tinize/ecowitt-gateway-api)** — reverse-engineered `/get_livedata_info` endpoints
- **[gw1000-api](https://github.com/mheinen/gw1000)** — Python client for the GW1000/1100/2000 binary protocol

### Tempest-specific
- **[WeatherFlow UDP listener](https://github.com/vinceskahan/weatherflow-udp-listener)** — the Tempest broadcasts JSON on the LAN; grab it directly
- **[weewx-weatherflow-udp](https://github.com/captain-coredump/weatherflow-udp)** — WeeWX driver for the same
- **[pyweatherflowudp](https://github.com/briis/pyweatherflowudp)** — Python library

---

## Freeware & commercial

### CumulusMX
**[Forum & downloads](https://cumulus.hosiene.co.uk/viewforum.php?f=40)** · [Wiki](https://www.cumuluswiki.org/) · [GitHub](https://github.com/cumulusmx/CumulusMX) · .NET · Free (closed source) · Win/Linux/Pi

The other giant. Maintained by Mark Crossley. Runs as a service with a **browser-based admin UI**,
supports every mainstream station, and has built-in uploaders for basically every network.

- Outputs `realtime.txt` / `webtags` that **dozens of third-party templates** consume — this is why it matters
- Built-in charts, records, monthly/yearly reports, NOAA-style reports
- Extremely active [support forum](https://cumulus.hosiene.co.uk/) with fast answers
- Legacy **Cumulus 1** (Windows-only, Delphi) is still out there; do not start new builds on it

### Weather Display
**[weather-display.com](https://www.weather-display.com/)** · ~US$70 · Win/Linux/Mac

Twenty-five years old and supports absolutely everything, including stations nothing else touches.
The UI is from another era. Its `clientraw.txt` output format became a de-facto standard consumed by
many templates (PWS Dashboard, Saratoga, Weather34).

### WeatherCat
**[weathercat.info](https://weathercat.info/)** · ~€60 · macOS only

The polished Mac option. Native, attractive, good graphing, exports in formats the common templates
read. Small but loyal user base.

### Meteobridge
**[meteobridge.com](https://www.meteobridge.com/)** · from ~€65 · Router/NAS/Pi firmware · [Meteobridge PRO / Nano SD](https://shop.smartbedded.com/)

A tiny Linux appliance whose entire job is: read station → push to N networks → serve a template.
Rock solid, sips power, no OS maintenance. The pragmatic choice if you don't *want* a server.

### Virtual Weather Station (VWS)
**[ambientweather.com/vws](https://ambientweather.com/)** · Windows

Long-standing commercial Windows package. Largely superseded, but still in use.

### WeatherLink (Davis cloud)
**[weatherlink.com](https://www.weatherlink.com/)** · Free tier + paid

Davis's own cloud. Has a good [v2 REST API](https://weatherlink.github.io/v2-api/) — you can build a
website that reads from WeatherLink without running any local software at all.

---

## Radio / SDR receivers

### rtl_433
**[GitHub](https://github.com/merbanan/rtl_433)** · C · GPL-2.0

Decodes 300+ device protocols on 433/868/915 MHz with a ~€30 RTL-SDR dongle. You can read your own
station **without its console**, and often your neighbours' too.

```bash
# See everything in range, as JSON
rtl_433 -F json
# Publish straight to MQTT for Home Assistant / Node-RED / your own site
rtl_433 -F "mqtt://192.168.1.10:1883,retain=1,devices=rtl_433[/model][/id]"
```

- Feed into WeeWX via **[weewx-sdr](https://github.com/matthewwall/weewx-sdr)**
- **[rtl_433_ESP](https://github.com/NorthernMan54/rtl_433_ESP)** — a subset running on an ESP32 + CC1101, no PC needed
- **[SDR++](https://www.sdrpp.org/)** / **[GQRX](https://gqrx.dk/)** for finding out what frequency your sensors actually use

### Other radio tooling
- **[OpenMQTTGateway](https://docs.openmqttgateway.com/)** — ESP32 firmware bridging 433 MHz/BLE/LoRa → MQTT
- **[Sonoff RF Bridge + Tasmota](https://tasmota.github.io/docs/devices/Sonoff-RF-Bridge-433/)** — cheap 433 MHz to MQTT

---

## Home automation platforms

| Platform | Weather station story |
|---|---|
| **[Home Assistant](https://www.home-assistant.io/)** | Integrations for Ecowitt, Tempest, Netatmo, AirGradient, Davis, plus MQTT catch-all. [HACS](https://hacs.xyz/) adds more. Dashboards are decent but not a public weather site — pair with [Grafana](charts-widgets.md#grafana) or export to InfluxDB. |
| **[Domoticz](https://www.domoticz.com/)** | Long-standing, lightweight, native weather station support, popular on Pi. |
| **[ioBroker](https://www.iobroker.net/)** | Big in DE. Adapters for Ecowitt, WU, DWD; strong charting via Flot/eCharts. |
| **[openHAB](https://www.openhab.org/)** | Java-based; bindings for Netatmo, OpenWeatherMap, MQTT. |
| **[Node-RED](https://nodered.org/)** | Not a platform so much as the universal glue. Ingest MQTT/HTTP, transform, push to your DB and website. [node-red-dashboard](https://flows.nodered.org/node/node-red-dashboard) can be your whole frontend. |
| **[ESPHome](https://esphome.io/)** | If you build your own sensors, ESPHome is the fastest path from BME280 to Home Assistant. See [DIY](diy.md). |

---

## Drivers & extensions

### Essential WeeWX extensions
| Extension | What it does |
|---|---|
| **[weewx-gw1000 / weewx-ecowitt](https://github.com/gjr80/weewx-gw1000)** | Poll an Ecowitt gateway directly over the LAN |
| **[weewx-interceptor](https://github.com/matthewwall/weewx-interceptor)** | Sniff/intercept the station's cloud upload and keep the data locally |
| **[weewx-mqtt](https://github.com/matthewwall/weewx-mqtt)** | Publish every archive/loop packet to MQTT (required by Belchertown live updates) |
| **[weewx-sdr](https://github.com/matthewwall/weewx-sdr)** | rtl_433 as a WeeWX data source |
| **[weewx-forecast](https://github.com/chaunceygardiner/weewx-forecast)** | Pull NWS/Aeris/WU forecasts into your DB for the skin to render |
| **[weewx-influx](https://github.com/matthewwall/weewx-influx)** | Mirror data into InfluxDB for Grafana |
| **[weewx-aercus / weewx-purpleair / weewx-airlink](https://github.com/topics/weewx-extension)** | Air quality ingestion |
| **[weewx-DP (Data Push)](https://github.com/topics/weewx)** & the [extension index](https://github.com/weewx/weewx/wiki/WeeWX-Extensions) | The canonical list — browse it |

### CumulusMX add-ons
- **[External programs / user webtags](https://www.cumuluswiki.org/a/Webtags)** — call any script per update
- **[Custom logs & extra sensors](https://www.cumuluswiki.org/)** — wiki is the manual
- **[CumulusUtils](https://cumulususers.eu/)** — Hans Rottier's huge add-on generating charts, records, maps, and a whole website from Cumulus data. Very popular in NL/BE.

---

## Uploaders & bridges

| Tool | Purpose |
|---|---|
| **[wunderground-uploader / pywu](https://github.com/topics/weather-underground)** | Push to WU from anything |
| **[cwop-uploader / aprs-weather](https://github.com/topics/cwop)** | CWOP/APRS packet submission |
| **[ecowitt2mqtt](https://github.com/bachya/ecowitt2mqtt)** | Ecowitt HTTP POST → MQTT |
| **[weatherflow2mqtt](https://github.com/briis/weatherflow2mqtt)** | Tempest UDP → MQTT |
| **[wxbridge / weewx-wxnow](https://github.com/topics/weewx-extension)** | Emit `wxnow.txt` for APRS software |
| **[Telegraf](https://www.influxdata.com/time-series-platform/telegraf/)** | Generic agent: MQTT/HTTP in → InfluxDB out. Great for a Grafana-based site. |
| **[MQTT Explorer](https://mqtt-explorer.com/)** | Debug what your station is actually publishing |

**Protocol cheat-sheet** — the formats these tools speak:
- **Ecowitt protocol** — HTTP POST, form-encoded, richest field set. Prefer this.
- **Wunderground protocol** — HTTP GET with query params. Universal, older, fewer fields.
- **`realtime.txt`** — Cumulus's space-separated one-line snapshot. Consumed by most templates.
- **`clientraw.txt`** — Weather Display's equivalent. Also widely consumed.
- **APRS/CWOP** — text packet over TCP to a CWOP server.
- **MQTT/JSON** — what you want for anything modern and real-time.

---

## Running it in Docker

Most people should. It makes the "my SD card died" recovery a 5-minute job.

| Image | Notes |
|---|---|
| **[felddy/weewx-docker](https://github.com/felddy/weewx-docker)** | The most-used WeeWX image. Config + DB on a volume. |
| **[CumulusMX Docker](https://hub.docker.com/r/optoisolated/cumulusmx)** (community) | Several community images exist; check recency before adopting. |
| **[eclipse-mosquitto](https://hub.docker.com/_/eclipse-mosquitto)** | Your MQTT broker |
| **[influxdb](https://hub.docker.com/_/influxdb)** + **[grafana/grafana](https://hub.docker.com/r/grafana/grafana)** | The metrics half of the stack |
| **[nginx](https://hub.docker.com/_/nginx)** / **[caddy](https://hub.docker.com/_/caddy)** | Serve the generated HTML |

A complete `docker-compose.yml` for the common stack is in
[docs/stacks.md](stacks.md#stack-2-the-modern-default).

---

[← Hardware](hardware.md) · [Back to index](../README.md) · [Next: Website templates →](website-templates.md)
