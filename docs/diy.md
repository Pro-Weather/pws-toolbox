# 🔧 DIY & build-your-own

Two kinds of DIY: **building the sensors** (microcontrollers, soldering, 3D printing) and
**building the website** (frameworks, APIs, no soldering). Both here.

[← Back to index](../README.md)

---

## Contents

- [Microcontroller platforms](#microcontroller-platforms)
- [Firmware you don't have to write](#firmware-you-dont-have-to-write)
- [Libraries if you do write it](#libraries-if-you-do-write-it)
- [3D-printable parts](#3d-printable-parts)
- [Complete open-source station projects](#complete-open-source-station-projects)
- [Build your own website](#build-your-own-website)
- [The maths you'll need](#the-maths-youll-need)
- [Calibration & validation](#calibration--validation)

---

## Microcontroller platforms

| Board | Why |
|---|---|
| **[ESP32](https://www.espressif.com/) / ESP32-S3 / C3** | **The default.** Wi-Fi + BLE, deep sleep, plenty of ADC/I²C, ~€4. Runs ESPHome, Arduino, MicroPython, Tasmota. |
| **[ESP8266](https://www.espressif.com/)** (Wemos D1 mini, NodeMCU) | ~€2, still perfectly good for a temperature/pressure node. One ADC pin. |
| **[Raspberry Pi Pico W](https://www.raspberrypi.com/products/raspberry-pi-pico/)** | ~€6, great MicroPython story, excellent PIO for pulse counting |
| **[Raspberry Pi](https://www.raspberrypi.com/)** (Zero 2 W / 4 / 5) | When you want Linux, a database and a web server on the same box |
| **[Arduino](https://www.arduino.cc/)** (Uno/Nano) | Fine for sensors, needs a separate radio/network module |
| **[Heltec / LilyGO / RAK](https://heltec.org/)** LoRa boards | ESP32 + LoRa in one — for a station 2 km down the field |
| **[Adafruit Feather](https://www.adafruit.com/feather)** ecosystem | Excellent docs, good battery/solar charging built in |
| **[Seeed XIAO](https://www.seeedstudio.com/)** | Thumbnail-sized ESP32/nRF boards, very low power |

**Power for an outdoor node:** solar panel + LiFePO₄ + deep sleep. Wake every 60 s, read, transmit,
sleep. An ESP32 doing this runs for months on a small cell. Do **not** use alkalines outdoors in
winter.

---

## Firmware you don't have to write

Strongly recommended over hand-rolled Arduino sketches — you get OTA updates, Wi-Fi recovery, and
web config for free.

| Firmware | Notes |
|---|---|
| **[ESPHome](https://esphome.io/)** | **Best starting point.** Describe your sensors in YAML, it compiles the firmware. Native BME280/SHT3x/pulse-counter/ADC support, MQTT + Home Assistant, OTA updates. A working weather node is ~30 lines of YAML. |
| **[Tasmota](https://tasmota.github.io/docs/)** | Web-configurable, MQTT-first, huge sensor list, no compilation needed |
| **[WLED](https://kno.wled.ge/)** | Not weather — but great for a physical "it's going to rain" indicator light |
| **[OpenMQTTGateway](https://docs.openmqttgateway.com/)** | 433 MHz / BLE / LoRa → MQTT bridge on an ESP32 |
| **[rtl_433_ESP](https://github.com/NorthernMan54/rtl_433_ESP)** | Decode 433 MHz weather sensors on an ESP32 + CC1101 |
| **[ESPEasy](https://espeasy.readthedocs.io/)** | Older but very capable, plugin-based |

**Minimal ESPHome weather node:**
```yaml
esphome:
  name: garden-sensor
esp32:
  board: esp32dev
wifi:
  ssid: !secret wifi_ssid
  password: !secret wifi_password
mqtt:
  broker: 192.168.1.10
  topic_prefix: weather/garden
i2c:
  sda: GPIO21
  scl: GPIO22
sensor:
  - platform: bme280_i2c
    temperature:
      name: "Outside Temperature"
      accuracy_decimals: 1
    humidity:
      name: "Outside Humidity"
    pressure:
      name: "Station Pressure"
    address: 0x76
    update_interval: 30s
  - platform: pulse_counter          # tipping-bucket rain gauge
    pin:
      number: GPIO14
      mode: INPUT_PULLUP
    name: "Rain Rate"
    unit_of_measurement: "mm/min"
    filters:
      - multiply: 0.2                # mm per tip — check your gauge
```

---

## Libraries if you do write it

| Language | Libraries |
|---|---|
| **Arduino/C++** | [Adafruit BME280](https://github.com/adafruit/Adafruit_BME280_Library), [Adafruit Unified Sensor](https://github.com/adafruit/Adafruit_Sensor), [SparkFun AS3935](https://github.com/sparkfun/SparkFun_AS3935_Lightning_Detector_Arduino_Library), [PubSubClient](https://github.com/knolleary/pubsubclient) (MQTT), [ArduinoJson](https://arduinojson.org/), [WiFiManager](https://github.com/tzapu/WiFiManager), [ESP32 deep sleep guide](https://randomnerdtutorials.com/esp32-deep-sleep-arduino-ide-wake-up-sources/) |
| **MicroPython** | [micropython-bme280](https://github.com/robert-hh/BME280), [umqtt.simple](https://github.com/micropython/micropython-lib), [Thonny](https://thonny.org/) as the IDE |
| **Python (Pi)** | [Adafruit CircuitPython Blinka](https://github.com/adafruit/Adafruit_Blinka), [gpiozero](https://gpiozero.readthedocs.io/), [smbus2](https://github.com/kplindegaard/smbus2), [w1thermsensor](https://github.com/timofurrer/w1thermsensor) (DS18B20), [paho-mqtt](https://github.com/eclipse/paho.mqtt.python), [pyserial](https://github.com/pyserial/pyserial) |
| **Go / Rust** | [periph.io](https://periph.io/), [rppal](https://github.com/golemparts/rppal), [embedded-hal](https://github.com/rust-embedded/embedded-hal) |
| **Meteorological maths** | [MetPy](https://unidata.github.io/MetPy/) (Python) — dewpoint, heat index, wind chill, all done correctly |

---

## 3D-printable parts

A printed radiation shield genuinely works — stacked-plate designs approximate a Stevenson screen well.

- **[Stevenson screen / stacked-plate radiation shields on Printables](https://www.printables.com/search/models?q=radiation%20shield)** — several excellent designs
- **[Thingiverse weather station collection](https://www.thingiverse.com/search?q=weather+station)**
- **[Anemometer + wind vane designs](https://www.printables.com/search/models?q=anemometer)** — pair with reed switches or a magnetometer/hall sensor
- **[Tipping bucket rain gauge](https://www.printables.com/search/models?q=rain%20gauge)** — printable, but **needs careful calibration** (pour a known volume, count tips)
- **[Open Weather Station (OWS)](https://openweatherstation.com/)** — open hardware designs
- **Printing tips:** **ASA or PETG**, never PLA — PLA warps and yellows in direct sun within a summer. White or light grey filament only. UV-resistant paint helps. Use stainless hardware.

---

## Complete open-source station projects

| Project | Notes |
|---|---|
| **[Sensor.Community kit](https://sensor.community/en/sensors/)** | Air quality + T/RH, ~€40, fully documented build, joins a global open network. The best "first build". |
| **[AirGradient DIY](https://www.airgradient.com/open-airgradient/instructions/)** | Open hardware + firmware + PCB, indoor & outdoor variants |
| **[Open Weather Station](https://openweatherstation.com/)** | Open hardware weather station platform |
| **[WeatherStation by SwitchDoc Labs](https://www.switchdoc.com/)** | Kits + tutorials + open code |
| **[Weather Station projects on Hackaday.io](https://hackaday.io/projects?tag=weather%20station)** | Endless inspiration and build logs |
| **[GitHub `weather-station` topic](https://github.com/topics/weather-station)** | Browse it — new projects constantly |
| **[Meshtastic environment telemetry](https://meshtastic.org/docs/configuration/module/telemetry/)** | LoRa-mesh weather nodes with no Wi-Fi at all |
| **[TinyGS / SatNOGS](https://satnogs.org/)** | Adjacent hobby: receive weather satellites yourself |

---

## Build your own website

No station required to start — point it at [Open-Meteo](weather-apis.md) and swap in your own data later.

### Recommended stack (2026)

```
Astro (static) + Tailwind + ECharts
    ↓ build-time fetch of your own JSON archive
    ↓ client-side fetch of realtime.json every 15 s
Cloudflare Pages (free) + Cloudflare Tunnel for the live JSON
```

Why: static output means it's fast and never breaks; ECharts is free and does windroses; Cloudflare
Pages is free and unmetered. Total cost: a domain.

| Piece | Options |
|---|---|
| **Framework** | [Astro](https://astro.build/) (best default — ships zero JS by default), [Next.js](https://nextjs.org/), [SvelteKit](https://svelte.dev/), [Nuxt](https://nuxt.com/), [Hugo](https://gohugo.io/), [Eleventy](https://www.11ty.dev/) |
| **Styling** | [Tailwind CSS](https://tailwindcss.com/), [shadcn/ui](https://ui.shadcn.com/), [Pico.css](https://picocss.com/) (classless, perfect for a simple station page), [Open Props](https://open-props.style/) |
| **Charts** | See [charts-widgets.md](charts-widgets.md) — [ECharts](https://echarts.apache.org/) or [uPlot](https://github.com/leeoniya/uPlot) |
| **Maps** | [Leaflet](https://leafletjs.com/) + [RainViewer](https://www.rainviewer.com/api.html) |
| **Backend (if needed)** | [FastAPI](https://fastapi.tiangolo.com/), [Flask](https://flask.palletsprojects.com/), [Hono](https://hono.dev/), [Express](https://expressjs.com/), [Go net/http](https://pkg.go.dev/net/http) |
| **Live data** | MQTT-over-WSS, SSE, or polling `realtime.json` — see [real-time transport](charts-widgets.md#real-time-transport) |
| **Deploy** | [hosting.md](hosting.md) |

### The data contract

Keep the boundary between "station" and "website" as one small file. Everything downstream gets easy:

```jsonc
// realtime.json — written every 10-30s, served with max-age=10
{
  "station": { "id": "example-1", "name": "Garden", "lat": 50.88, "lon": 4.70, "elevation_m": 42 },
  "observed_utc": "2026-07-24T14:32:00Z",
  "units": { "temp": "C", "wind": "m/s", "rain": "mm", "pressure": "hPa" },
  "current": {
    "temp": 24.3, "dewpoint": 15.1, "humidity": 57, "pressure_sea": 1013.2,
    "wind_speed": 3.4, "wind_gust": 7.1, "wind_dir": 214,
    "rain_rate": 0.0, "rain_today": 1.2, "solar_wm2": 612, "uv": 5.1
  },
  "today": { "temp_min": 14.2, "temp_max": 25.8, "gust_max": 11.3 },
  "trend": { "pressure_3h": -1.4, "temp_1h": 0.6 }
}
```

Rules that will save you later: **UTC timestamps**, **explicit units**, **flat structure**,
**never `null` silently** — omit the key or mark it stale. Add a `"stale": true` flag your frontend
can render as a warning banner.

---

## The maths you'll need

Do these correctly and your site is better than most. [MetPy](https://unidata.github.io/MetPy/) implements all of it if you're in Python.

| Quantity | Notes |
|---|---|
| **Dewpoint** | Magnus formula from T and RH. `a=17.625, b=243.04`. Universally used. |
| **Sea-level pressure (QFF/QNH)** | Barometric formula using station altitude *and* temperature. Getting this wrong is the most common PWS error — a 100 m altitude error is ~12 hPa. |
| **Wind chill** | Only defined for T ≤ 10 °C and wind ≥ 4.8 km/h. Don't display it in July. |
| **Heat index / apparent temperature** | Rothfusz regression (US) or the Australian AT. Only meaningful above ~27 °C. |
| **[Humidex](https://en.wikipedia.org/wiki/Humidex)** | Canadian alternative, common in Europe |
| **Wet-bulb temperature** | Stull's approximation is fine; increasingly worth showing |
| **Evapotranspiration (ET₀)** | [FAO-56 Penman-Monteith](https://www.fao.org/4/x0490e/x0490e00.htm). Needs solar radiation — the reason to buy a pyranometer. |
| **Beaufort scale** | For a human-readable wind description |
| **Growing degree days / chill hours** | Popular with the gardening audience |
| **Vector-average wind direction** | ⚠️ **Never arithmetically average degrees** — average the sine and cosine components, then `atan2`. Otherwise N winds average to S. |
| **Rain rate** | Derive from tip timing, not from a fixed window, or light drizzle reads as zero |

**References:** [WMO CIMO Guide (WMO-No. 8)](https://library.wmo.int/idurl/4/68695) ·
[NOAA/NWS formula pages](https://www.weather.gov/epz/wxcalc) ·
[MetPy calculations](https://unidata.github.io/MetPy/latest/api/generated/metpy.calc.html)

---

## Calibration & validation

- **Temperature:** compare against a calibrated reference, or the classic ice-bath (0.0 °C) check. Most cheap sensors read 0.5–1 °C high in sun — that's a **siting/shield** problem, not a sensor problem.
- **Humidity:** saturated salt solutions — NaCl ≈ 75 % RH, MgCl₂ ≈ 33 % RH, in a sealed container at stable temperature.
- **Pressure:** compare to your nearest airport METAR (they report QNH). Adjust your configured altitude until they match; do **not** apply an arbitrary offset.
- **Rain:** pour a measured volume of water slowly through the funnel and count tips. Compute mm/tip from your funnel area. Repeat after every cleaning.
- **Wind:** hardest to verify. Compare gust patterns with nearby stations during a frontal passage — you're checking correlation, not absolute agreement.
- **Ongoing QC:** [MADIS/CWOP quality plots](networks.md#cwop-citizen-weather-observer-program) grade your station against the model analysis for free, forever. **Upload to CWOP purely for this feedback loop, even if you care nothing for the science.**

---

[← Hosting](hosting.md) · [Back to index](../README.md) · [Next: Extras →](extras.md)
