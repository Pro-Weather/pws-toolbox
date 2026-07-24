# 🧱 Ready-made stacks

Five complete, working builds. Pick the one that matches your budget and patience, then use the
other pages for detail. Every one of these is a real configuration people run today.

[← Back to index](../README.md)

---

| # | Stack | Cost | Effort | Best for |
|---|---|---|---|---|
| [1](#stack-1-no-hardware) | **No hardware** — API-driven site | €0 | ⭐ | Learning; a site for a place you don't live |
| [2](#stack-2-the-modern-default) | **Ecowitt + WeeWX + Belchertown** | ~€250 | ⭐⭐ | **Most people. Start here.** |
| [3](#stack-3-zero-maintenance) | **Tempest + cloud only** | ~€400 | ⭐ | You want it to just work forever |
| [4](#stack-4-the-davis-classic) | **Davis + CumulusMX + PWS Dashboard** | ~€800 | ⭐⭐⭐ | Data quality, 20-year horizon |
| [5](#stack-5-full-diy) | **ESP32 + MQTT + Astro** | ~€80 | ⭐⭐⭐⭐ | You want to build every part |

---

## Stack 1: No hardware

**A real weather website with no station at all.** Pulls from [Open-Meteo](weather-apis.md), free
forever, deploys in an afternoon. A perfectly good way to learn the frontend half before spending
money — and to have something running while your station is on a slow boat.

```
Open-Meteo API ──▶ Astro (build-time + client fetch) ──▶ Cloudflare Pages
                    + ECharts + Leaflet/RainViewer
```

**Cost:** €0 (+ ~€10/yr for a domain)

**Steps:**
1. `npm create astro@latest` → pick minimal
2. Fetch `https://api.open-meteo.com/v1/forecast?latitude=50.85&longitude=4.35&current=temperature_2m,relative_humidity_2m,wind_speed_10m&hourly=temperature_2m,precipitation&timezone=auto` — no key required
3. Chart the hourly arrays with [ECharts](charts-widgets.md#charting-libraries)
4. Add a [Leaflet](charts-widgets.md#maps-radar--satellite-embeds) map with the free [RainViewer](https://www.rainviewer.com/api.html) radar layer
5. Push to GitHub → connect [Cloudflare Pages](hosting.md#static-hosts) → done

**Upgrade path:** when your station arrives, replace the Open-Meteo "current" block with your own
`realtime.json` ([contract here](diy.md#the-data-contract)) and keep everything else.

---

## Stack 2: The modern default

**Ecowitt hardware → WeeWX in Docker → a modern skin → tunnelled to the internet.**
This is what most new stations built in the last few years look like, and it's what to build if
you're not sure.

```
Ecowitt WS90/WS2910 ──📻──▶ GW2000 gateway ──LAN──▶ WeeWX (Docker, Raspberry Pi)
                                    │                    ├──▶ SQLite archive
                                    │                    ├──▶ Belchertown / NeoWX skin → /var/www
                                    │                    ├──▶ MQTT (live page updates)
                                    │                    └──▶ Wunderground · CWOP · Windy · PWSWeather
                                    └──(also direct)──────────▶ ecowitt.net
nginx ──▶ cloudflared tunnel ──▶ https://weather.example.com
```

**Shopping list (~€250):**
| Item | ~Cost |
|---|---|
| [Ecowitt WS90 "Wittboy"](hardware.md#all-in-one-consumer-stations) or WS2910 array | €130–200 |
| [Ecowitt GW2000 gateway](hardware.md#gateways-consoles--bridges) | €55 |
| Raspberry Pi 4/5 + **USB SSD** (not an SD card) | €80 (or reuse anything) |
| Mounting pole, stainless hardware | €30 |

**Build:**
1. **Mount it properly first** — [siting guide](hardware.md#siting--mounting). This matters more than any software choice.
2. Pair sensors to the GW2000; confirm data at `http://<gateway-ip>` .
3. On the Pi, `docker compose up -d` with the compose file below.
4. Configure the WeeWX Ecowitt/GW1000 driver to poll the gateway over the LAN.
5. Install a skin: `weectl extension install https://github.com/neoground/neowx-material/releases/latest/download/neowx-material.zip` (or [Belchertown](website-templates.md#belchertown)).
6. Enable uploads in `weewx.conf` `[StdRESTful]`: Wunderground, CWOP, Windy, PWSweather.
7. `cloudflared tunnel` → point it at nginx → add the DNS record. **No port forwarding.**
8. Set up [Litestream or restic backups](data-storage.md#backups). Do this *now*, not later.

**`docker-compose.yml`:**
```yaml
services:
  weewx:
    image: felddy/weewx:5
    restart: unless-stopped
    volumes:
      - ./weewx/data:/data          # weewx.conf + archive DB live here
      - ./www:/data/public_html     # generated site
    environment:
      TZ: Europe/Brussels

  mosquitto:
    image: eclipse-mosquitto:2
    restart: unless-stopped
    ports: ["1883:1883", "9001:9001"]   # 9001 = websockets for the browser
    volumes:
      - ./mosquitto/config:/mosquitto/config
      - ./mosquitto/data:/mosquitto/data

  web:
    image: nginx:alpine
    restart: unless-stopped
    ports: ["8080:80"]
    volumes:
      - ./www:/usr/share/nginx/html:ro

  tunnel:
    image: cloudflare/cloudflared:latest
    restart: unless-stopped
    command: tunnel --no-autoupdate run
    environment:
      TUNNEL_TOKEN: ${CLOUDFLARE_TUNNEL_TOKEN}
```

**Total running cost:** ~€0/month plus a few watts. Domain optional.

---

## Stack 3: Zero maintenance

**For when you want observations on the internet and never want to think about it again.**

```
Tempest station ──▶ Tempest cloud (public page, API)
        └──UDP──▶ (optional) Home Assistant / WeeWX on the LAN
Tempest auto-uploads to: Wunderground · CWOP · PWSWeather
```

**Cost:** ~€400 hardware, €0/month.

- One-piece, solar, **no moving parts and no batteries to change** — the actual reason to buy it
- Installs in 10 minutes on a single pole
- Public station page you can link immediately; built-in uploads to the major networks
- **You still get local data:** the hub broadcasts JSON over UDP on your LAN, so you can add
  WeeWX or Home Assistant later without touching the cloud setup

**Caveats:** haptic rain measurement under-reads light drizzle and needs the (automatic) cloud
calibration to be at its best; you're dependent on one vendor's cloud for the public page. If a
self-hosted site matters to you, add [Stack 2](#stack-2-the-modern-default)'s software half using the
[UDP listener](station-software.md#tempest-specific).

**The same idea, cheaper:** an Ecowitt array + GW2000 uploading straight to Ecowitt.net, WU and
Windy from the gateway itself — no computer at all, ~€200, and you get a shareable dashboard.

---

## Stack 4: The Davis classic

**Maximum data quality and a 20-year horizon.** The setup serious amateur observers run.

```
Davis Vantage Pro2 (fan-aspirated) ──▶ WeatherLink Live ──LAN──▶ CumulusMX (Pi/NUC)
                                              │                      ├──▶ MariaDB
                                              │                      ├──▶ realtime.txt ─▶ PWS Dashboard (PHP)
                                              │                      └──▶ every network, built in
                                              └──▶ weatherlink.com (backup + API)
Apache/nginx + PHP ──▶ Cloudflare Tunnel ──▶ https://weather.example.com
```

**Shopping list (~€800–1200):**
| Item | ~Cost |
|---|---|
| [Davis Vantage Pro2](hardware.md#all-in-one-consumer-stations) (24 h fan-aspirated) | €700–900 |
| [WeatherLink Live](hardware.md#gateways-consoles--bridges) | €180 |
| Solar radiation + UV sensors (optional) | €250 |
| Small server / Pi | €80 |

**Why:** the fan-aspirated radiation shield eliminates daytime solar heating error — the single
largest error source in every cheap station. Davis hardware routinely runs 15+ years; spares are
available for models two decades old. If you intend to build a climate record rather than a gadget,
this is the tier where that becomes realistic.

**Software notes:**
- [CumulusMX](station-software.md#cumulusmx) has the most complete built-in uploader set of anything — tick boxes, done
- [PWS Dashboard](website-templates.md#pws-dashboard) or [Saratoga](website-templates.md#saratoga-weather-website-templates) need **PHP hosting** — either cheap shared hosting, or a tunnel to your own Apache/nginx+PHP
- Consider [CumulusUtils](website-templates.md#cumulusutils) for records/charts generation
- WeeWX works just as well here (`vantage` driver over the datalogger, or the WeatherLink Live JSON) — the choice is taste

---

## Stack 5: Full DIY

**Build the sensors and the website.** The most work and by far the most satisfying.

```
ESP32 + BME280/SHT35 + anemometer + tipping bucket   (ESPHome, solar + LiFePO₄)
        └──MQTT──▶ Mosquitto ──▶ Telegraf ──▶ InfluxDB / TimescaleDB
                        │                          └──▶ Grafana (public dashboard)
                        └──▶ small Python service ──▶ realtime.json + hourly aggregates
                                                        └──▶ Astro site ──▶ Cloudflare Pages
```

**Cost:** ~€80 of parts, plus your weekends.

**Order of work — do it in this order or you'll get discouraged:**
1. **One sensor, indoors, on your desk.** ESP32 + SHT35 + [ESPHome](diy.md#firmware-you-dont-have-to-write) → MQTT. Get a number into a database. This is the whole project in miniature.
2. **Store and chart it.** InfluxDB + Grafana, or SQLite + a static chart. Now you have a working pipeline.
3. **Put it outside.** [3D-printed radiation shield](diy.md#3d-printable-parts) (ASA/PETG, never PLA), solar + LiFePO₄, deep sleep. Expect to redo the enclosure once.
4. **Add rain**, then wind. Pulse counting is easy; **calibration is the real work** ([how](diy.md#calibration--validation)).
5. **Publish `realtime.json`** to the [data contract](diy.md#the-data-contract), then build the frontend against it.
6. **Validate against a neighbour** — upload to [CWOP](networks.md#cwop-citizen-weather-observer-program) and read the free MADIS quality plots. They will find your errors for you.

**Honest advice:** DIY temperature/humidity/pressure is genuinely easy and can be *accurate*.
DIY **rain and wind are hard** to make accurate — mechanical tolerances, bearing friction, and
calibration dominate. A very common and sensible hybrid: **DIY the electronics and the website, but
buy the wind and rain sensors** (Fine Offset spares are ~€25–40 and are already calibrated).

---

## Choosing between them

| If you care most about… | Go with |
|---|---|
| Getting something online this weekend | [1](#stack-1-no-hardware) then [2](#stack-2-the-modern-default) |
| Value for money | [2](#stack-2-the-modern-default) |
| Never touching it again | [3](#stack-3-zero-maintenance) |
| Data accuracy and longevity | [4](#stack-4-the-davis-classic) |
| Learning / the process itself | [5](#stack-5-full-diy) |
| A site that looks better than everyone else's | Any stack + [charts-widgets.md](charts-widgets.md) + [design guidance](charts-widgets.md#design-guidance) |

**Three things that apply to every stack:**
1. **Siting beats hardware.** A €150 station sited correctly beats a €900 one above a driveway.
2. **Back up from day one.** [Litestream](data-storage.md#backups) takes ten minutes and saves ten years.
3. **Upload to CWOP.** Free, and its quality-control feedback is the only independent check you'll ever get on your own data.

---

[← Back to index](../README.md) · [Hardware →](hardware.md)
