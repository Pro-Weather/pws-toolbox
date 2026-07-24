# 📈 Charts, gauges & widgets

What actually makes a weather site feel like a weather site: a temperature trace, a windrose, a
spinning gauge, and a radar map.

[← Back to index](../README.md)

---

## Contents

- [Charting libraries](#charting-libraries)
- [Gauges](#gauges)
- [Windroses](#windroses)
- [Maps, radar & satellite embeds](#maps-radar--satellite-embeds)
- [Grafana](#grafana)
- [Real-time transport](#real-time-transport)
- [Weather icons & fonts](#weather-icons--fonts)
- [Design guidance](#design-guidance)

---

## Charting libraries

| Library | License | Why pick it |
|---|---|---|
| **[Highcharts](https://www.highcharts.com/)** | ⚠️ Free for personal/non-commercial, paid otherwise | What Belchertown and CumulusMX use. Best-in-class time-series UX out of the box: zoom, range selector, tooltips, export. **Check the licence if your site has ads or is commercial.** |
| **[Apache ECharts](https://echarts.apache.org/)** | Apache-2.0 | The best *free* answer to Highcharts. Huge chart type range (incl. polar/windrose), great performance on large series, canvas + SVG renderers. **Recommended default.** |
| **[Chart.js](https://www.chartjs.org/)** | MIT | Simplest to learn, tiny, plenty for a hobby site. Add [chartjs-adapter-date-fns](https://github.com/chartjs/chartjs-adapter-date-fns) for time axes and [chartjs-plugin-zoom](https://www.chartjs.org/chartjs-plugin-zoom/). Used by NeoWX Material. |
| **[uPlot](https://github.com/leeoniya/uPlot)** | MIT | Absurdly fast and ~45 KB. If you're plotting a year of 1-minute data in the browser, this is the one. |
| **[Plotly.js](https://plotly.com/javascript/)** | MIT | Batteries included, good scientific chart types, native `barpolar` windroses. Large bundle. |
| **[D3.js](https://d3js.org/)** | ISC | Not a chart library — a visualisation toolkit. Maximum control, maximum work. Used by weewx-wdc. |
| **[Observable Plot](https://observablehq.com/plot/)** | ISC | D3's grammar-of-graphics layer. Beautiful defaults, very concise. |
| **[Vega-Lite](https://vega.github.io/vega-lite/)** | BSD-3 | Declarative JSON chart specs — nice when charts are generated server-side. |
| **[Recharts](https://recharts.org/)** / **[visx](https://airbnb.io/visx/)** / **[Nivo](https://nivo.rocks/)** | MIT | If your site is React |
| **[LayerChart](https://www.layerchart.com/)** | MIT | Svelte |
| **[matplotlib](https://matplotlib.org/)** / **[plotnine](https://plotnine.org/)** | Python | For server-rendered PNG charts — exactly what WeeWX's built-in image generator does |
| **[gnuplot](http://www.gnuplot.info/)** | Own | Old-school, scriptable, still perfect for cron-generated PNGs |
| **[RRDtool](https://oss.oetiker.ch/rrdtool/)** | GPL | Round-robin database + graphs. Genuinely well-suited to weather; unfashionable but rock solid. |

**Practical picks:** ECharts if you want free + powerful. Chart.js if you want simple. uPlot if
you're plotting a lot. Highcharts if you're using a template that already ships with it.

---

## Gauges

The analogue dials every PWS site has.

| Project | Notes |
|---|---|
| **[SteelSeries Weather Gauges](https://github.com/mcrossley/SteelSeries-Weather-Gauges)** | Mark Crossley's canvas gauges — *the* PWS gauge set. Works with CumulusMX, WeeWX (`realtime.txt`/JSON), Weather Display, Meteobridge. Ships as a drop-in page. |
| **[steelseries (canvas gauges lib)](https://github.com/HanSolo/SteelSeries-Canvas)** | The underlying Gerrit Grunwald library the above is built on |
| **[canvas-gauges](https://canvas-gauges.com/)** | MIT, dependency-free radial + linear gauges, very configurable |
| **[JustGage](https://justgage.com/)** | MIT, SVG, dead simple |
| **[svg-gauge](https://github.com/naikus/svg-gauge)** | Tiny, SVG, no deps |
| **[ECharts gauge series](https://echarts.apache.org/examples/en/index.html#chart-type-gauge)** | If you're already on ECharts, don't add another library |
| **[Grafana gauge/stat panels](https://grafana.com/docs/grafana/latest/panels-visualizations/)** | Free, no code |

> ⚖️ **A design note:** gauges look great and communicate badly. Use them for *instantaneous* values
> (current wind, current temp) and keep the real information in the time-series charts.
> See [design guidance](#design-guidance).

---

## Windroses

Surprisingly fiddly to do well — you need speed-binned frequency by direction sector.

| Option | Notes |
|---|---|
| **[ECharts polar bar](https://echarts.apache.org/examples/en/editor.html?c=bar-polar-stack)** | Stacked speed bins on a polar axis = a proper windrose. Free. |
| **[Plotly `barpolar`](https://plotly.com/javascript/wind-rose-charts/)** | Literally documented as "wind rose chart". Fastest path. |
| **[windrose (Python)](https://github.com/python-windrose/windrose)** | matplotlib-based; great for server-side PNG generation and climatology reports |
| **[Highcharts wind rose demo](https://www.highcharts.com/demo/highcharts/polar-wind-rose)** | If you already own Highcharts |
| **[weewx-windrose extensions](https://github.com/topics/weewx-extension)** | Several exist; also built into Belchertown/wdc |
| **[D3 windrose examples](https://observablehq.com/@d3/gallery)** | Full control |

**Getting the data right:** bin direction into 16 (or 8/32) sectors, bin speed into 5–7 ranges,
compute % frequency per (direction, speed) cell over the period. Exclude calms and report them as a
centre percentage.

---

## Maps, radar & satellite embeds

| Tool | Notes |
|---|---|
| **[Leaflet](https://leafletjs.com/)** | BSD-2. The default lightweight web map. Pair with [OpenStreetMap](https://www.openstreetmap.org/) tiles. |
| **[MapLibre GL JS](https://maplibre.org/)** | BSD-3. Vector tiles, GPU rendering, the open fork of Mapbox GL. |
| **[OpenLayers](https://openlayers.org/)** | BSD-2. Heavier, but excellent WMS/GeoTIFF support — matters for met data. |
| **[RainViewer API](https://www.rainviewer.com/api.html)** | Free radar tile layers, past frames + nowcast. Drop straight into Leaflet. **Easiest radar you can add.** |
| **[Windy embed / Windy API](https://api.windy.com/)** | Free iframe embed and a JS API. Instant credibility on any weather page. |
| **[Blitzortung live map](https://map.blitzortung.org/)** | Lightning; embeddable |
| **[NASA GIBS / Worldview](https://worldview.earthdata.nasa.gov/)** | Free satellite imagery tiles (WMTS) |
| **[EUMETView (EUMETSAT)](https://view.eumetsat.int/)** | European satellite WMS |
| **[NOAA GOES imagery](https://www.star.nesdis.noaa.gov/goes/)** | US satellite, direct image URLs |
| **[Iowa State Mesonet (IEM)](https://mesonet.agron.iastate.edu/ogc/)** | Free NEXRAD radar WMS/tile services — a hobbyist favourite for US radar |
| **[Meteoblue / Ventusky / Zoom Earth](https://zoom.earth/)** | Embeddable third-party visualisations |

---

## Grafana

**[grafana.com](https://grafana.com/)** · AGPL-3.0 / free cloud tier

Worth its own section because it's the highest-leverage option on this page: point it at
[InfluxDB / TimescaleDB / Prometheus](data-storage.md), drag some panels around, and you have a
live, mobile-friendly, auto-refreshing weather dashboard in an afternoon.

- **Public dashboards** — Grafana can serve a read-only dashboard to anonymous visitors ([docs](https://grafana.com/docs/grafana/latest/dashboards/dashboard-public/))
- Panel types you'll want: Time series, Stat, Gauge, State timeline, Geomap, Candlestick (for min/max), [Windrose community panel](https://grafana.com/grafana/plugins/)
- Alerting built in → push to [Discord/Telegram](extras.md#alerts--notifications)
- Feed it with **[weewx-influx](https://github.com/matthewwall/weewx-influx)**, **[Telegraf](https://www.influxdata.com/time-series-platform/telegraf/)**, or MQTT
- Related: **[Chronograf](https://www.influxdata.com/time-series-platform/chronograf/)**, **[Metabase](https://www.metabase.com/)**, **[Apache Superset](https://superset.apache.org/)**

---

## Real-time transport

How the numbers on the page update without a refresh.

| Approach | Notes |
|---|---|
| **MQTT over WebSockets** | The PWS standard. [Mosquitto](https://mosquitto.org/) with `listener 9001` + `protocol websockets`, then [MQTT.js](https://github.com/mqttjs/MQTT.js) or [Paho](https://eclipse.dev/paho/) in the browser. This is how Belchertown does live updates. |
| **Server-Sent Events (SSE)** | Simplest one-way push. One HTTP endpoint, `EventSource` in the browser, works through every proxy. **Underrated — usually the right answer.** |
| **WebSockets** | Full duplex; overkill unless you need client→server too |
| **Polling `realtime.txt` / JSON** | `fetch()` every 5–10 s. Ugly but bulletproof, works on any static host. What most PHP templates do. |
| **[Centrifugo](https://centrifugal.dev/)** / **[Soketi](https://soketi.app/)** | If you outgrow a hand-rolled socket server |
| **[HTMX](https://htmx.org/) `hx-trigger="every 10s"`** | Zero-JS live updating for server-rendered sites |

⚠️ **Security note:** if you expose MQTT to the browser, use a **read-only user** on a
**separate listener**, over **WSS**, and only publish the topics you intend to be public.

---

## Weather icons & fonts

| Set | Notes |
|---|---|
| **[Weather Icons](https://erikflowers.github.io/weather-icons/)** (Erik Flowers) | 200+ icons, SIL OFL, includes WMO/Beaufort/moon-phase glyphs. The classic. |
| **[Meteocons](https://bas.dev/work/meteocons)** | Free, animated SVG versions available. Gorgeous. |
| **[Basmilius/weather-icons](https://github.com/basmilius/weather-icons)** | Animated SVG, MIT, actively maintained |
| **[amCharts animated weather icons](https://www.amcharts.com/free-animated-svg-weather-icons/)** | Free animated SVG set |
| **[Climacons](http://adamwhitcroft.com/climacons/)** | Minimal line icons |
| **[Google Material Symbols](https://fonts.google.com/icons)** | Has a decent weather subset, Apache-2.0 |
| **Moon phase rendering** | [SunCalc](https://github.com/mourner/suncalc) computes the phase; render with a CSS mask or an SVG set |

---

## Design guidance

Making a weather dashboard that reads well is a real design problem. A few load-bearing rules:

1. **One chart, one question.** "Is it warmer than yesterday?" and "how much has it rained this
   month?" are different charts.
2. **Time on X, always left-to-right, always labelled with the timezone.** State whether it's local
   or UTC. This is the #1 source of confusion on PWS sites.
3. **Colour by meaning, not by prettiness.** Temperature = diverging around a meaningful midpoint.
   Rain = single sequential ramp. Wind direction = a *cyclic* scale (so 359° and 1° look alike).
4. **Never use a rainbow scale** for continuous data — it invents boundaries that aren't in the data.
5. **Units and precision:** don't render 21.4832 °C. One decimal for temperature, whole numbers for
   humidity and wind, 0.1/0.2 mm for rain.
6. **Show the observation time**, prominently, and grey the whole panel out if the data is stale.
   A weather site that silently shows 3-day-old numbers is worse than one that's down.
7. **Accessibility:** check contrast in both light and dark mode; never encode information in colour alone.

Reading: [Datawrapper blog](https://blog.datawrapper.de/), [Financial Times Visual Vocabulary](https://github.com/Financial-Times/chart-doctor),
[ColorBrewer](https://colorbrewer2.org/), [cmocean](https://matplotlib.org/cmocean/) (oceanographic/atmospheric colormaps),
[Scientific colour maps (Crameri)](https://www.fabiocrameri.ch/colourmaps/).

---

[← Website templates](website-templates.md) · [Back to index](../README.md) · [Next: Databases & storage →](data-storage.md)
