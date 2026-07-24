# 🔌 Weather data APIs

Your station measures the *present*. For a forecast panel, a radar map, a lightning layer, or a
"compare me to the official station" widget, you need someone else's data.

[← Back to index](../README.md)

---

## Contents

- [Free, no API key](#free-no-api-key)
- [Free tier with a key](#free-tier-with-a-key)
- [Commercial](#commercial)
- [National met services (open data)](#national-met-services-open-data)
- [Radar](#radar)
- [Satellite](#satellite)
- [Lightning](#lightning)
- [Air quality](#air-quality)
- [Marine, hydrology & other](#marine-hydrology--other)
- [Historical & climate](#historical--climate)
- [Alerts & warnings](#alerts--warnings)
- [Astronomy](#astronomy)
- [Client libraries](#client-libraries)

---

## Free, no API key

The good stuff. Start here.

| API | Coverage | Notes |
|---|---|---|
| **[Open-Meteo](https://open-meteo.com/)** | 🌍 Global | **The best free weather API, full stop.** No key, no signup, CORS-enabled (call it straight from the browser), 30+ models (ECMWF, GFS, ICON, MET Norway, Météo-France, JMA…), hourly/15-min, historical to 1940, air quality, marine, flood, climate projections. Free for non-commercial use; [self-hostable](https://github.com/open-meteo/open-meteo) (AGPL). |
| **[MET Norway Locationforecast (YR)](https://api.met.no/weatherapi/locationforecast/2.0/documentation)** | 🌍 Global | Excellent quality, free, no key — just send an identifying `User-Agent`. Respect the [ToS](https://api.met.no/doc/TermsOfService) and cache with `If-Modified-Since`. |
| **[NWS API](https://www.weather.gov/documentation/services-web-api)** (`api.weather.gov`) | 🇺🇸 US | Official US: forecasts, observations, alerts, radar stations, zone/point lookup. No key, just a `User-Agent`. |
| **[Bright Sky](https://brightsky.dev/)** | 🇩🇪 DE | Clean JSON over DWD open data — current, forecast, and historical station records. Open source. |
| **[7Timer!](http://www.7timer.info/)** | 🌍 Global | Ancient, no-frills, popular with astronomers (astro seeing forecast). |
| **[wttr.in](https://wttr.in/)** | 🌍 Global | Terminal-friendly ASCII/JSON weather. `curl wttr.in/Brussels?format=j1`. Fun, not for production. |
| **[Sunrise-Sunset.org](https://sunrise-sunset.org/api)** | 🌍 Global | Sun times without doing the maths (or use [SunCalc](#astronomy) locally). |
| **[Open-Elevation](https://open-elevation.com/)** / **[OpenTopoData](https://www.opentopodata.org/)** | 🌍 Global | Station altitude lookup for pressure reduction |
| **[Nominatim / OSM](https://nominatim.org/)** | 🌍 Global | Geocoding for a location picker (mind the usage policy) |

---

## Free tier with a key

| API | Free tier | Notes |
|---|---|---|
| **[Pirate Weather](https://pirateweather.net/)** | Generous | **Drop-in Dark Sky replacement** — identical JSON shape, so old Dark Sky code works unchanged. Open source, built on NOAA data. [Get a key](https://pirate-weather.apiable.io/). |
| **[OpenWeatherMap](https://openweathermap.org/api)** | 1 000 calls/day | The most tutorial-ed API. Quality is middling and the free tier has been trimmed repeatedly, but it's everywhere. Also runs a [station upload API](networks.md). |
| **[WeatherAPI.com](https://www.weatherapi.com/)** | 1 M calls/month | Very generous free tier, forecast + history + astronomy + air quality in one call. Underrated. |
| **[Visual Crossing](https://www.visualcrossing.com/)** | 1 000 records/day | **Best free historical/timeline API.** Excellent for backfilling and climatology comparisons. |
| **[Tomorrow.io](https://www.tomorrow.io/weather-api/)** | 500 calls/day | Good hyperlocal nowcasting, many niche parameters |
| **[Meteosource](https://www.meteosource.com/)** | Small | Simple, clean |
| **[Weatherbit](https://www.weatherbit.io/)** | 50 calls/day | Tight free tier, good docs |
| **[AerisWeather (Vaisala Xweather)](https://www.xweather.com/)** | Dev tier | Powers PWSWeather; used by Belchertown's forecast module |
| **[Windy API](https://api.windy.com/)** | Free for non-commercial | Map embeds, point forecast, webcams |
| **[Météo-Concept](https://api.meteo-concept.com/)** | Free tier | 🇫🇷 France |
| **[Met Office DataHub](https://datahub.metoffice.gov.uk/)** | Free tier | 🇬🇧 Official UK site-specific forecasts |

---

## Commercial

Worth knowing exist; almost certainly not needed for a hobby site.

- **[Meteomatics](https://www.meteomatics.com/)** — enormous parameter catalogue, clean URL-based API
- **[Vaisala Xweather](https://www.xweather.com/)** — the professional tier of AerisWeather
- **[The Weather Company (IBM)](https://www.ibm.com/weather)** — powers Weather Underground
- **[AccuWeather APIs](https://developer.accuweather.com/)** · **[Foreca](https://corporate.foreca.com/)** · **[DTN](https://www.dtn.com/)** · **[Spire](https://spire.com/)**
- **[ECMWF](https://www.ecmwf.int/)** — the best global model; [Open Data](https://www.ecmwf.int/en/forecasts/datasets/open-data) subset is free at 0.25°

---

## National met services (open data)

Often the highest-quality data for your own country, and usually free.

| Country | Service |
|---|---|
| 🇺🇸 US | [NOAA/NWS API](https://www.weather.gov/documentation/services-web-api), [NOMADS](https://nomads.ncep.noaa.gov/) (model data), [NCEI](https://www.ncei.noaa.gov/) (climate archive), [MADIS](https://madis.ncep.noaa.gov/) |
| 🇩🇪 DE | [DWD Open Data](https://opendata.dwd.de/), [Bright Sky](https://brightsky.dev/) |
| 🇳🇱 NL | [KNMI Data Platform](https://dataplatform.knmi.nl/), [Buienradar API](https://www.buienradar.nl/overbuienradar/gratis-weerdata) |
| 🇧🇪 BE | [RMI / KMI-IRM open data](https://opendata.meteo.be/), [Meteo.be](https://www.meteo.be/) |
| 🇫🇷 FR | [Météo-France public API portal](https://portail-api.meteofrance.fr/) |
| 🇬🇧 UK | [Met Office DataHub](https://datahub.metoffice.gov.uk/), [CEDA Archive](https://archive.ceda.ac.uk/) |
| 🇳🇴 NO | [MET Norway (api.met.no)](https://api.met.no/) — also the best global free option |
| 🇨🇦 CA | [MSC GeoMet](https://eccc-msc.github.io/open-data/), [Environment Canada](https://weather.gc.ca/) |
| 🇦🇺 AU | [BOM](http://www.bom.gov.au/) (FTP/ftp-derived JSON; no formal public API) |
| 🇨🇭 CH | [MeteoSwiss Open Data](https://www.meteoswiss.admin.ch/services-and-publications/service/open-data.html) |
| 🇦🇹 AT | [GeoSphere Austria Data Hub](https://data.hub.geosphere.at/) |
| 🇪🇸 ES | [AEMET OpenData](https://opendata.aemet.es/) |
| 🇮🇹 IT | Regional ARPA services (e.g. [ARPAE](https://www.arpae.it/)) |
| 🇩🇰 DK | [DMI Open Data](https://opendatadocs.dmi.govcloud.dk/) |
| 🇫🇮 FI | [FMI Open Data](https://en.ilmatieteenlaitos.fi/open-data) |
| 🇸🇪 SE | [SMHI Open Data](https://opendata.smhi.se/) |
| 🇵🇱 PL | [IMGW API](https://danepubliczne.imgw.pl/) |
| 🇮🇪 IE | [Met Éireann](https://www.met.ie/climate/available-data) |
| 🌍 EU | [Copernicus CDS](https://cds.climate.copernicus.eu/) (ERA5!), [EUMETSAT](https://www.eumetsat.int/), [MeteoAlarm](https://meteoalarm.org/) |

---

## Radar

| Source | Notes |
|---|---|
| **[RainViewer API](https://www.rainviewer.com/api.html)** | 🌍 Global composite radar tiles, past 2 h + 30 min nowcast, free tier. **The easiest radar layer to add to Leaflet.** |
| **[Iowa State Mesonet (IEM)](https://mesonet.agron.iastate.edu/ogc/)** | 🇺🇸 Free NEXRAD WMS/tiles + archives. A community staple. |
| **[NOAA nowCOAST / NWS radar](https://www.weather.gov/gis/)** | 🇺🇸 Official layers |
| **[Buienradar](https://www.buienradar.nl/overbuienradar/gratis-weerdata)** | 🇳🇱🇧🇪 Free rain-nowcast images and a simple text API |
| **[RainAlarm / Meteox / Weerplaza](https://www.weerplaza.nl/)** | 🇳🇱🇧🇪 Alternative regional radar embeds |
| **[DWD RADOLAN](https://opendata.dwd.de/climate_environment/CDC/grids_germany/)** | 🇩🇪 Gauge-adjusted radar precipitation grids |
| **[Met Office DataHub radar](https://datahub.metoffice.gov.uk/)** | 🇬🇧 |
| **[OPERA (EUMETNET)](https://www.eumetnet.eu/observations/weather-radar-network/)** | 🇪🇺 European radar composite (access varies) |
| **[Windy](https://api.windy.com/) / [Ventusky](https://www.ventusky.com/) / [Zoom Earth](https://zoom.earth/)** | Embeddable rendered radar |
| **[Py-ART](https://arm-doe.github.io/pyart/)** / **[wradlib](https://wradlib.org/)** | If you want to process raw radar volumes yourself |

---

## Satellite

- **[NASA GIBS / Worldview](https://worldview.earthdata.nasa.gov/)** — free WMTS tiles, near-real-time, global
- **[NOAA STAR GOES](https://www.star.nesdis.noaa.gov/goes/)** — direct GOES-East/West imagery URLs
- **[EUMETView](https://view.eumetsat.int/)** — Meteosat WMS
- **[Sat24](https://en.sat24.com/)** — simple European embeds
- **[Sentinel Hub](https://www.sentinel-hub.com/)** — Copernicus imagery API (free tier)
- **[Himawari / JMA](https://www.data.jma.go.jp/mscweb/data/himawari/)** — Asia-Pacific
- 🛰️ **Receive it yourself:** [SatDump](https://www.satdump.org/), [goestools](https://github.com/pietern/goestools) — decode GOES/Meteor/NOAA APT with an SDR and a dish. See [extras](extras.md).

---

## Lightning

- **[Blitzortung.org](https://www.blitzortung.org/)** — community TOA network. Free access to the raw data **if you host a station**; the [live map](https://map.blitzortung.org/) is publicly embeddable.
- **[LightningMaps.org](https://www.lightningmaps.org/)** — Blitzortung frontend with embeds
- **[Vaisala GLD360 / NLDN](https://www.vaisala.com/)** — commercial, authoritative
- **[Earth Networks (ENTLN)](https://www.earthnetworks.com/)** — commercial
- **Local detection:** an [AS3935 or Ecowitt WH57](hardware.md#lightning-detection) gives you your own strike count and distance — much more fun than an API

---

## Air quality

| API | Notes |
|---|---|
| **[Open-Meteo Air Quality](https://open-meteo.com/en/docs/air-quality-api)** | Free, no key, CAMS-based. Best default. |
| **[OpenAQ](https://openaq.org/)** | Open aggregation of global reference-grade monitors, free API |
| **[PurpleAir API](https://api.purpleair.com/)** | The big consumer sensor network |
| **[Sensor.Community](https://sensor.community/)** | Fully open data + open hardware, [raw API](https://data.sensor.community/) |
| **[AirGradient API](https://www.airgradient.com/)** | Open hardware, local + cloud API |
| **[IQAir / AirVisual](https://www.iqair.com/air-pollution-data-api)** | Free tier, AQI-focused |
| **[EEA Air Quality](https://www.eea.europa.eu/en/analysis/maps-and-charts)** | 🇪🇺 Official European reference data |
| **[AirNow](https://docs.airnowapi.org/)** | 🇺🇸 Official US AQI |
| **[IRCEL-CELINE](https://www.irceline.be/)** | 🇧🇪 Belgian official air quality |

---

## Marine, hydrology & other

- **[Open-Meteo Marine](https://open-meteo.com/en/docs/marine-weather-api)** — waves, swell, SST. Free.
- **[NOAA NDBC](https://www.ndbc.noaa.gov/)** — buoy observations
- **[NOAA CO-OPS Tides & Currents](https://api.tidesandcurrents.noaa.gov/)** — tide predictions, free
- **[WorldTides](https://www.worldtides.info/)** / **[Admiralty UK](https://admiraltyapi.portal.azure-api.net/)** — tides elsewhere
- **[Copernicus Marine](https://marine.copernicus.eu/)** — ocean models
- **[USGS Water Services](https://waterservices.usgs.gov/)** — 🇺🇸 river gauges, free
- **[GloFAS / EFAS](https://www.globalfloods.eu/)** — flood forecasting
- **[Open-Meteo Flood API](https://open-meteo.com/en/docs/flood-api)** — river discharge, free
- **[NASA POWER](https://power.larc.nasa.gov/)** — solar & agroclimatology, free, excellent for solar-panel maths
- **[PVGIS](https://re.jrc.ec.europa.eu/pvg_tools/en/)** — 🇪🇺 solar irradiance database
- **[Solcast](https://solcast.com/)** — solar forecasting, free hobbyist tier

---

## Historical & climate

- **[Open-Meteo Historical (ERA5)](https://open-meteo.com/en/docs/historical-weather-api)** — 1940→present, free, no key. **Start here.**
- **[Copernicus Climate Data Store](https://cds.climate.copernicus.eu/)** — ERA5 at the source, free with registration
- **[NOAA NCEI / GHCN-Daily](https://www.ncei.noaa.gov/products/land-based-station/global-historical-climatology-network-daily)** — the global station archive
- **[Meteostat](https://meteostat.net/)** — friendly API + [Python library](https://github.com/meteostat/meteostat-python) over GHCN/other archives. Great for "compare my station to the 30-year normal".
- **[Visual Crossing Timeline](https://www.visualcrossing.com/)** — easiest paid-ish historical
- **[Iowa Environmental Mesonet ASOS](https://mesonet.agron.iastate.edu/request/download.phtml)** — bulk airport observation downloads, free
- **[Berkeley Earth](https://berkeleyearth.org/data/)** · **[HadCRUT](https://www.metoffice.gov.uk/hadobs/)** · **[NASA GISTEMP](https://data.giss.nasa.gov/gistemp/)** — global temperature records

---

## Alerts & warnings

- **[NWS Alerts (CAP)](https://api.weather.gov/alerts)** — 🇺🇸 free, GeoJSON + CAP
- **[MeteoAlarm](https://meteoalarm.org/)** — 🇪🇺 aggregated national warnings, CAP/RSS feeds
- **[DWD Warnungen](https://www.dwd.de/DE/leistungen/opendata/opendata.html)** — 🇩🇪
- **[Met Office warnings RSS](https://www.metoffice.gov.uk/weather/guides/rss)** — 🇬🇧
- **[KMI/RMI waarschuwingen](https://www.meteo.be/)** — 🇧🇪
- **[CAP (Common Alerting Protocol)](https://docs.oasis-open.org/emergency/cap/v1.2/CAP-v1.2.html)** — the standard they all speak. Parse it once, support everyone.
- Push them onward → [Discord/Telegram bots](extras.md#alerts--notifications)

---

## Astronomy

- **[SunCalc](https://github.com/mourner/suncalc)** (JS) / **[Astral](https://astral.readthedocs.io/)** (Python) — sunrise/sunset, golden hour, moon phase & illumination, locally, no API call
- **[Skyfield](https://rhodesmill.org/skyfield/)** — serious ephemeris maths in Python
- **[USNO Astronomical Applications API](https://aa.usno.navy.mil/data/)** — authoritative
- **[NOAA Solar Calculator](https://gml.noaa.gov/grad/solcalc/)** — reference formulas
- **[NOAA SWPC](https://www.swpc.noaa.gov/products/aurora-30-minute-forecast)** — aurora/space weather, free API. A popular panel on northern PWS sites.

---

## Client libraries

| Language | Libraries |
|---|---|
| **Python** | [openmeteo-requests](https://pypi.org/project/openmeteo-requests/), [meteostat](https://github.com/meteostat/meteostat-python), [MetPy](https://unidata.github.io/MetPy/), [Siphon](https://unidata.github.io/siphon/), [herbie](https://herbie.readthedocs.io/), [pyowm](https://github.com/csparpa/pyowm), [noaa-sdk](https://pypi.org/project/noaa-sdk/) |
| **JS/TS** | [openmeteo](https://www.npmjs.com/package/openmeteo), [weather-js](https://www.npmjs.com/package/weather-js), plain `fetch` (most of these APIs are CORS-friendly) |
| **Go** | [go-openmeteo](https://github.com/hectormalot/omgo), stdlib `net/http` |
| **R** | [openmeteo](https://cran.r-project.org/package=openmeteo), [rnoaa](https://docs.ropensci.org/rnoaa/) |

---

### ⚖️ Using APIs responsibly

- **Cache.** A forecast that updates hourly does not need fetching every page load. Cache server-side, serve a static JSON to visitors.
- **Send a real `User-Agent`** with contact info — met.no and NWS require it and will block you otherwise.
- **Read the licence.** Open-Meteo and Windy free tiers are **non-commercial**. "My site has one AdSense banner" is commercial.
- **Attribute.** Every national met service asks for it and it costs you one line of footer.
- **Never put a paid API key in frontend JS.** Proxy through your own server or a serverless function.

---

[← Databases & storage](data-storage.md) · [Back to index](../README.md) · [Next: Networks →](networks.md)
