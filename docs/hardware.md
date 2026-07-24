# 📡 Hardware

The station itself. Everything downstream — software, database, website — depends on what you buy
here, and specifically on **whether the manufacturer lets you get the raw data out locally**.

> **The one rule:** before buying, check that the station can push data to *your* server, not only
> to the vendor cloud. Look for "custom server upload", "Ecowitt protocol", "Wunderground protocol",
> a local HTTP/JSON endpoint, or a documented serial/USB interface. Everything on this page qualifies
> unless flagged ⚠️.

[← Back to index](../README.md)

---

## Contents

- [All-in-one consumer stations](#all-in-one-consumer-stations)
- [Gateways, consoles & bridges](#gateways-consoles--bridges)
- [Professional & research grade](#professional--research-grade)
- [Individual sensors](#individual-sensors)
- [Air quality](#air-quality)
- [Lightning detection](#lightning-detection)
- [Power & connectivity](#power--connectivity)
- [Siting & mounting](#siting--mounting)
- [Where to buy / compare](#where-to-buy--compare)

---

## All-in-one consumer stations

| Brand / Model | Price band | Local data? | Notes |
|---|---|---|---|
| **[Ecowitt](https://www.ecowitt.com/)** WS2910 / WS3900 / WS90 "Wittboy" | €120–330 | ✅ Excellent | The hobby's current default. Enormous modular sensor range, "Custom Upload" to any server, cheap spares. WS90 is haptic rain + ultrasonic wind (no moving parts). |
| **[Ambient Weather](https://ambientweather.com/)** WS-2902 / WS-5000 | €190–500 | ✅ Good | US-focused, same Fine Offset OEM lineage. WS-5000 has an ultrasonic anemometer. API + local access on newer consoles. |
| **[WeatherFlow Tempest](https://shop.tempest.earth/)** | ~€350 | ✅ Good (UDP broadcast) | Zero moving parts, solar, one-piece, self-installs in 10 min. Broadcasts JSON over local UDP — trivially easy to integrate. Rain-by-haptics is less accurate in light drizzle. |
| **[Davis Instruments](https://www.davisinstruments.com/)** Vantage Vue / Vantage Pro2 | €400–1200 | ✅ Excellent | The durability benchmark. 15–20 year lifespans are normal. Needs a [WeatherLink Live](#gateways-consoles--bridges) or datalogger to get data out. |
| **[Fine Offset](http://www.foshk.com/)** (OEM: WH2900, WH65, HP2551…) | €90–250 | ✅ Good | The factory behind Ecowitt, Ambient, Froggit, Sainlogic, Misol and a dozen rebadges. Identical internals, different stickers — buy whichever is cheap locally. |
| **[Froggit](https://www.froggit.de/)** HP1000SE / WH3000 | €130–300 | ✅ Good | German Fine Offset rebadge with local support and warranty. Popular in DE/AT/CH/BE/NL. |
| **[Netatmo](https://www.netatmo.com/)** Weather Station | €180–350 | ⚠️ Cloud API only | Beautiful hardware, cloud-locked. Usable via their OAuth API but there is no local mode. Wind/rain modules are pricey. |
| **[La Crosse Technology](https://www.lacrossetechnology.com/)** | €50–250 | ⚠️ Varies | Cheap and widely available; local access ranges from "easy over 433 MHz" to "impossible". Check the exact model before buying. |
| **[Bresser](https://www.bresser.de/)** 7-in-1 / 5-in-1 | €100–250 | ✅ Usually | Another Fine Offset-adjacent line, big in Europe. Many models readable by [rtl_433](station-software.md#rtl_433). |
| **[Acurite](https://www.acurite.com/)** Atlas / Iris | €120–350 | ⚠️ Mixed | Good sensors, awkward data escape. The Atlas + Access hub can do custom upload; older hubs cannot. |

**Buying advice in one paragraph:** if you want it to just work and be supportable in five years, buy
**Ecowitt** (best value + modularity) or **Davis** (best build). Buy **Tempest** if you cannot climb
on your roof twice a year. Avoid anything whose only documented output is a phone app.

---

## Gateways, consoles & bridges

The box that turns radio packets into something your server can read.

| Device | Works with | Notes |
|---|---|---|
| **[Ecowitt GW2000 / GW1200 / GW1100](https://www.ecowitt.com/shop/goodsDetail/275)** | Ecowitt + Fine Offset family | The workhorse. Local HTTP/JSON API, MQTT (GW2000), custom-server upload to WU **and** Ecowitt protocol simultaneously. ~€40–70. |
| **[Davis WeatherLink Live](https://www.davisinstruments.com/products/weatherlink-live)** | Davis | Local JSON at `http://<ip>:80/v1/current_conditions` + UDP broadcast. The right way to get Davis data into WeeWX. |
| **[Davis USB/Serial Datalogger](https://www.davisinstruments.com/)** | Davis consoles | Cheaper, wired, classic WeeWX `vantage` driver path. |
| **[Meteobridge / Meteobridge Nano / PRO](https://www.meteobridge.com/)** | Almost everything | Commercial firmware appliance: reads the station, uploads to ~30 networks, serves templates. Set-and-forget. |
| **[WiFiLogger 2](https://www.wifilogger.net/)** | Davis | Polish-made Davis Wi-Fi logger — web UI, MQTT, many upload targets. Great value alternative to WeatherLink. |
| **[RTL-SDR v4 dongle](https://www.rtl-sdr.com/)** | 433/868/915 MHz sensors | ~€30. With [rtl_433](station-software.md#rtl_433) you skip the console entirely. Also picks up neighbours' sensors, Blitzortung, ADS-B… |
| **[Ecowitt WittBoy / GW3000](https://www.ecowitt.com/)** | Ecowitt | Newer combined console+gateway units; check local-API support per model revision. |

---

## Professional & research grade

| Product | Notes |
|---|---|
| **[Vaisala](https://www.vaisala.com/)** WXT530 series | The instrument national met services actually use. All-in-one, no moving parts, ~€2–4k. |
| **[Campbell Scientific](https://www.campbellsci.com/)** dataloggers | CR300/CR1000X — the research standard for custom sensor arrays. |
| **[Lufft](https://www.lufft.com/)** WS series | German-made compact multi-parameter sensors, road/rail/aviation grade. |
| **[RainWise](https://rainwise.com/)** MK-III | Rugged US-made mid/pro tier, popular with fire services. |
| **Davis fan-aspirated radiation shield** ([7714](https://www.davisinstruments.com/)) | The single biggest accuracy upgrade available to a hobbyist. Kills daytime solar-heating error on the temperature reading. |
| **[Gill Instruments](https://gillinstruments.com/)** WindSonic / MaxiMet | Ultrasonic anemometry benchmark. |

---

## Individual sensors

For DIY builds — see [docs/diy.md](diy.md) for wiring and code.

### Temperature & humidity
| Sensor | Accuracy | Notes |
|---|---|---|
| **BME280 / BMP280** | ±1 °C, ±3 % RH | The default hobby chip. BME has humidity, BMP doesn't. Beware fake/heat-soaked clones — mount away from the board. |
| **BME680 / BME688** | + gas/VOC | Adds an air-quality-ish gas resistance channel; needs BSEC library for meaningful IAQ. |
| **SHT31 / SHT35 / SHT45** (Sensirion) | ±0.2 °C, ±1.5 % RH | Noticeably better than BME280. Worth the extra €5. **Recommended.** |
| **DS18B20** | ±0.5 °C | Waterproof-probe version is perfect for soil, water, ground temperature. 1-Wire. |
| **AHT20 / AHT21** | ±0.3 °C | Cheap, decent, common on combo boards with BMP280. |
| **[MCP9808](https://www.adafruit.com/product/1782)** | ±0.25 °C | High-accuracy temperature only. |

### Pressure
BME280/BMP280/BMP388 all fine — pressure is the easiest measurement to get right.
Remember to publish **sea-level (QFF/QNH) reduced** pressure, not station pressure.

### Wind
| Option | Notes |
|---|---|
| **Reed-switch + cup anemometer** (Davis 6410, Fine Offset spares, [Misol](https://www.misolie.com/)) | Cheap, replaceable, needs a pulse counter. Fine Offset spare wind sets are ~€25. |
| **Ultrasonic** (Ecowitt WS90, Ambient WS-5000, Gill, [Calypso](https://calypsoinstruments.com/)) | No moving parts, no bearings to fail. Higher cost, occasional rain artefacts. |
| **[Adafruit anemometer](https://www.adafruit.com/product/1733)** | 0–5 V analog output, easy on ESP32/ADC. |

### Rain
| Option | Notes |
|---|---|
| **Tipping bucket** (Davis 6463, Fine Offset, [Misol](https://www.misolie.com/)) | The standard. 0.2 mm or 0.01" per tip. Needs debounce + annual cleaning. |
| **Haptic / piezo** (Ecowitt WS90, Tempest) | No clogging, no cleaning, but under-reports drizzle and needs firmware calibration. |
| **Optical / laser disdrometer** ([OTT Parsivel](https://www.ott.com/), [Thies LPM](https://www.thiesclima.com/)) | Measures drop size distribution. Pro budget. |

### Solar / UV
| Sensor | Notes |
|---|---|
| **[LTR390](https://www.adafruit.com/product/4831)** | UV + ambient light, I²C, cheap, common. |
| **VEML6075 / VEML7700** | UVA/UVB and lux respectively. |
| **SI1145** | UV index + IR + visible, but discontinued — buy stock while it lasts. |
| **Silicon pyranometer** ([Apogee SP-110](https://www.apogeeinstruments.com/), Davis 6450) | Proper W/m² solar radiation. Needed for real evapotranspiration maths. |

### Soil / agriculture
- **Capacitive soil moisture** (v1.2 boards) — cheap, corrosion-free, needs per-soil calibration
- **[Ecowitt WH51](https://www.ecowitt.com/)** wireless soil moisture — €25, just works, up to 8 channels
- **Ecowitt WN34** soil/water temperature probes
- **[TEROS 12](https://metergroup.com/)** — research-grade moisture/EC/temp

### Leaf wetness, snow, water level
- **Ecowitt WH55** water leak, **WN35** leaf wetness
- **[Ultrasonic HC-SR04 / JSN-SR04T](https://www.adafruit.com/product/4007)** for snow depth (point at the ground, subtract)
- **[VL53L1X](https://www.adafruit.com/product/3967)** time-of-flight laser for precise snow depth

---

## Air quality

| Device | Notes |
|---|---|
| **[AirGradient](https://www.airgradient.com/)** ONE / Open Air | Open-source hardware + firmware, local API, outdoor model. **Best open choice.** |
| **[PurpleAir](https://www2.purpleair.com/)** PA-II / Zen | Huge public network, local JSON endpoint at `http://<ip>/json`. |
| **[Sensor.Community](https://sensor.community/)** (ex-Luftdaten) DIY kit | €40 of SDS011 + DHT22 + ESP8266, joins a 15 000-station open network. |
| **SDS011 / PMS5003 / PMS7003** | The bare PM2.5/PM10 laser sensors inside most of the above. |
| **[Ecowitt WH41/WH43](https://www.ecowitt.com/)** | PM2.5 sensors that dock straight into your existing Ecowitt gateway. |
| **SCD40 / SCD41 / MH-Z19** | True NDIR CO₂ (indoor use — outdoor CO₂ is boringly constant). |

---

## Lightning detection

| Device | Notes |
|---|---|
| **AS3935** (`CJMCU-3935`, [SparkFun](https://www.sparkfun.com/products/15441), [DFRobot](https://www.dfrobot.com/)) | Franklin lightning sensor IC — distance-to-storm estimate. Extremely noise-sensitive: keep it away from switching supplies, PWM and Wi-Fi antennas. |
| **[Ecowitt WH57](https://www.ecowitt.com/)** | AS3935 in a weatherproof box that pairs with your gateway. ~€40, zero effort. |
| **[Blitzortung.org](https://www.blitzortung.org/) station kit** | Build a TOA receiver, join the global network, get access to the full lightning dataset. Community-run, non-commercial. |

---

## Power & connectivity

- **Solar + LiFePO₄** — LiFePO₄ hugely outperforms NiMH/Li-ion below freezing. Most stock stations ship with rechargeable AAs that die in winter; **lithium primary AAs are the cheap fix.**
- **PoE** — [PoE splitters](https://www.tp-link.com/) to 5 V/12 V for a rooftop Pi or gateway
- **[Waveshare](https://www.waveshare.com/) / [Adafruit](https://www.adafruit.com/) solar charger boards** for DIY nodes
- **LoRa / LoRaWAN** ([Heltec](https://heltec.org/), [RAK](https://www.rakwireless.com/), [The Things Network](https://www.thethingsnetwork.org/)) — kilometres of range for a remote field station
- **Meshtastic** — [meshtastic.org](https://meshtastic.org/), LoRa mesh with telemetry modules that can carry BME280 data
- **Lightning/surge protection** — gas-discharge arrestors on any cable that leaves the building. Cheap insurance.

---

## Siting & mounting

Bad siting ruins better data than bad sensors do.

- **WMO Guide to Instruments and Methods of Observation (CIMO Guide, WMO-No. 8)** — [wmo.int](https://library.wmo.int/idurl/4/68695). The actual standard.
- **[NOAA/NWS Cooperative Observer siting standards](https://www.weather.gov/coop/)**
- Quick rules: thermometer **1.25–2 m** above short grass in a ventilated white screen, never above tarmac or against a wall. Anemometer **10 m**, or as high as you can manage, ≥10× the height of any obstacle away. Rain gauge at **~1 m**, in the open, not under eaves.
- **[Stevenson screen](https://en.wikipedia.org/wiki/Stevenson_screen) / radiation shields** — Davis 7714 (fan-aspirated, best), Barani MeteoShield, or [3D-printed stacked-plate designs](diy.md#3d-printable-parts).
- **[Weather Station Siting Quality (CRN ratings)](https://www.ncei.noaa.gov/access/crn/)** — self-rate your own site 1–5.
- **[surfacestations.org](http://www.surfacestations.org/)** — the classic siting-quality photo survey project.

---

## Where to buy / compare

- **[Ecowitt store](https://www.ecowitt.com/)** · **[Davis](https://www.davisinstruments.com/)** · **[Ambient](https://ambientweather.com/)** · **[Tempest](https://shop.tempest.earth/)**
- 🇪🇺 **[Froggit](https://www.froggit.de/)**, **[Wetterladen](https://www.wetterladen24.de/)**, **[Weatherstations.eu](https://www.weerstation.nl/)**, **[MeteoShop](https://www.meteoshop.be/)** (BE)
- 🇬🇧 **[Weather Spares](https://www.weatherspares.co.uk/)**, **[Prodata](https://www.weatherstations.co.uk/)** (Davis specialists, excellent advice)
- 🇺🇸 **[Scientific Sales](https://www.scientificsales.com/)**, **[Weather Shack](https://www.weathershack.com/)**
- Reviews & shootouts: **[WXforum.net hardware boards](https://www.wxforum.net/)** — the most honest reviews in the hobby

---

[← Back to index](../README.md) · [Next: Station software →](station-software.md)
