# 🗄️ Databases & storage

Weather data is the friendliest workload in existence: append-only, one small row every 1–5 minutes,
never updated. **~500 MB will hold a decade.** Do not over-engineer this.

[← Back to index](../README.md)

---

## Contents

- [Just tell me what to use](#just-tell-me-what-to-use)
- [Relational](#relational)
- [Time-series databases](#time-series-databases)
- [Message brokers](#message-brokers)
- [File formats & interchange](#file-formats--interchange)
- [Backups](#backups)
- [Schema & retention notes](#schema--retention-notes)

---

## Just tell me what to use

| Situation | Use |
|---|---|
| Running WeeWX or CumulusMX normally | **SQLite** (the default). Genuinely fine forever. |
| You want Grafana dashboards | **InfluxDB** or **TimescaleDB** alongside your primary DB |
| Multiple machines / a proper web app | **MariaDB** or **PostgreSQL** |
| Live updates on the website | **MQTT** (Mosquitto) — not really storage, but the piece people miss |
| You're a metrics person already | **Prometheus + VictoriaMetrics** |

**The honest recommendation:** keep SQLite as the source of truth, mirror to InfluxDB for pretty
graphs, publish to MQTT for live values. Three tools, each doing one thing well.

---

## Relational

| DB | Notes |
|---|---|
| **[SQLite](https://www.sqlite.org/)** | WeeWX's default. Single file, zero admin, backs up with `cp`. Handles millions of weather rows without complaint. Use WAL mode if something else reads while WeeWX writes. |
| **[MariaDB](https://mariadb.org/) / [MySQL](https://www.mysql.com/)** | The standard step up. Supported natively by WeeWX and CumulusMX. Pick this if a PHP template ([Saratoga](website-templates.md), [PWS Dashboard](website-templates.md)) needs SQL access from a different host. |
| **[PostgreSQL](https://www.postgresql.org/)** | Better everything, but not natively supported by WeeWX/Cumulus — you'd be writing the glue. Worth it if you're building custom, especially with [TimescaleDB](#time-series-databases) or [PostGIS](https://postgis.net/). |
| **[DuckDB](https://duckdb.org/)** | Not for ingest — for *analysis*. Point it at your SQLite file or a folder of Parquet and run real climatology queries in milliseconds. Superb for "what was the wettest May since 2015". |

---

## Time-series databases

| DB | Notes |
|---|---|
| **[InfluxDB](https://www.influxdata.com/)** | The most common pairing with Grafana in this hobby. v2 (Flux/InfluxQL) is what most tutorials assume; v3 is the current line. Integrates via [weewx-influx](https://github.com/matthewwall/weewx-influx) or [Telegraf](https://www.influxdata.com/time-series-platform/telegraf/). |
| **[TimescaleDB](https://www.timescale.com/)** | PostgreSQL extension. Real SQL, hypertables, continuous aggregates, compression. **Best choice if you're comfortable with Postgres** — you get 10:1 compression and pre-computed daily/monthly rollups for free. |
| **[VictoriaMetrics](https://victoriametrics.com/)** | Apache-2.0, extremely efficient, Prometheus-compatible. Single binary, low RAM — excellent on a Pi. |
| **[Prometheus](https://prometheus.io/)** | Built for monitoring, not archival. Great for "is my station alive"; less good as a 10-year climate archive (use remote-write into VictoriaMetrics/Thanos for that). |
| **[QuestDB](https://questdb.io/)** | Very fast ingest, SQL with time-series extensions. Overkill here, but pleasant. |
| **[RRDtool](https://oss.oetiker.ch/rrdtool/)** | The original. Fixed-size files, automatic downsampling, built-in graphing. Unfashionable and completely appropriate for weather. |
| **[Graphite](https://graphiteapp.org/)** / **[Whisper](https://github.com/graphite-project/whisper)** | Similar niche, still deployed |

---

## Message brokers

For live website updates and gluing components together.

| Tool | Notes |
|---|---|
| **[Eclipse Mosquitto](https://mosquitto.org/)** | The MQTT broker. Tiny, EPL/EDL, runs anywhere. Enable the `websockets` listener so browsers can subscribe directly. |
| **[EMQX](https://www.emqx.io/)** / **[NanoMQ](https://nanomq.io/)** / **[VerneMQ](https://vernemq.com/)** | Scale-up alternatives; NanoMQ is nice on constrained hardware |
| **[HiveMQ Cloud](https://www.hivemq.com/)** / **[Flespi](https://flespi.com/)** | Free-tier hosted brokers — handy if your site is on a static host with no server |
| **[Redis](https://redis.io/) pub/sub + Streams** | If you already run Redis; Streams give you replay |
| **[NATS](https://nats.io/)** | Lightweight, great JetStream persistence |
| **[Vercel Queues](https://vercel.com/docs)** / cloud queues | Only relevant if your site is serverless |

**Topic layout that ages well:**
```
weather/<station-id>/loop           # every reading, JSON, retained
weather/<station-id>/archive        # every archive interval, JSON
weather/<station-id>/status         # online/offline, LWT
weather/<station-id>/sensor/<name>  # optional per-sensor for HA discovery
```
Set a **Last Will & Testament** on `status` so your site can grey out when the station drops.

---

## File formats & interchange

| Format | Use |
|---|---|
| **CSV** | Universal. What you'll publish for people who want your archive. |
| **[Parquet](https://parquet.apache.org/)** | Columnar, compressed ~10×, queryable directly by DuckDB/pandas/Polars. **The right format for a public data archive.** |
| **[NetCDF](https://www.unidata.ucar.edu/software/netcdf/)** / **[HDF5](https://www.hdfgroup.org/)** | The meteorological standard for gridded/multidimensional data. Overkill for a single station, essential if you ingest model data. |
| **[GRIB2](https://www.wmo.int/)** | How NWP model output ships. Read with [cfgrib](https://github.com/ecmwf/cfgrib), [wgrib2](https://www.nco.ncep.noaa.gov/pmb/codes/nwprod/util/sorc/wgrib2.cd/), [eccodes](https://confluence.ecmwf.int/display/ECC). |
| **[Zarr](https://zarr.dev/)** | Cloud-native array storage; how modern climate datasets are served |
| **`realtime.txt` / `clientraw.txt`** | The hobby's de-facto live-snapshot formats — see [station software](station-software.md#uploaders--bridges) |
| **[CF Conventions](https://cfconventions.org/)** | Naming/metadata standard. Worth following for variable names even in a hobby DB. |
| **[WMO BUFR / SYNOP](https://community.wmo.int/)** | What real stations transmit; occasionally useful to decode |

**Python/analysis toolkit:** [pandas](https://pandas.pydata.org/) ·
[Polars](https://pola.rs/) · [xarray](https://xarray.dev/) · [MetPy](https://unidata.github.io/MetPy/) ·
[Siphon](https://unidata.github.io/siphon/) · [cfgrib](https://github.com/ecmwf/cfgrib) ·
[Herbie](https://herbie.readthedocs.io/) (download NWP model data easily)

---

## Backups

**The single most common tragedy in this hobby is a dead SD card and no backup.** Ten years of
irreplaceable observations, gone.

- **[restic](https://restic.net/)** / **[BorgBackup](https://www.borgbackup.org/)** — deduplicating, encrypted, incremental. Nightly to a NAS *and* to cloud.
- **[rclone](https://rclone.org/)** — sync to any of 70 cloud providers
- **[Litestream](https://litestream.io/)** — continuous SQLite replication to S3-compatible storage. **Perfect fit for WeeWX.** Set it up once, never think about it.
- **[sqlite3 .backup / VACUUM INTO](https://www.sqlite.org/lang_vacuum.html)** — safe hot copies
- **[mysqldump](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html)** / **[mariabackup](https://mariadb.com/kb/en/mariabackup/)**
- **Publish your archive publicly** — a CSV/Parquet dump on GitHub or Zenodo *is* a backup, and it's a contribution to open data. See [Zenodo](https://zenodo.org/) for a citable DOI.
- **Let someone else archive it too.** Vendor clouds and hosted services keep their own copy — [Pro Weather](website-templates.md#pro-weather) archives every Davis/WeatherLink reading permanently, which is a real answer to [WeatherLink's limited retention window](website-templates.md#the-weatherlink-retention-problem). Treat it as a *second* copy, not your only one: an archive you can't export is a hostage, so check the export path before you rely on it.
- **Move the OS off the SD card.** Boot a Pi from USB SSD, or put `/var` on one. SD cards die from write cycles; a weather logger writes constantly.

---

## Schema & retention notes

- **Store everything at full resolution forever.** Weather data is tiny. 1 row/minute × 10 years ≈ 5 M rows. Do not downsample away your own history — you cannot get it back.
- **Store UTC.** Convert to local for display only. Every DST bug in this hobby comes from breaking this rule.
- **Store raw *and* derived.** Keep the observed values; recompute dewpoint/heat index/wind chill from them rather than only storing the derived value, so you can fix a formula later.
- **Record the unit system explicitly** (WeeWX's `usUnits` column is a good pattern). Ambiguous units are how a station ends up reporting 25 °F in July.
- **Sea-level pressure:** store station pressure (`pressure`), altimeter, *and* sea-level (`barometer`) if you can — networks want different ones.
- **Flag, don't delete, bad data.** Add a quality column. A sensor that read 60 °C during a firmware glitch is information.
- **QC references:** [WMO-No. 8 (CIMO Guide)](https://library.wmo.int/idurl/4/68695) · [MADIS QC](https://madis.ncep.noaa.gov/madis_qc.shtml) · WeeWX's [StdQC](https://www.weewx.com/docs/latest/usersguide/) min/max limits — set them, they catch most spikes.

---

[← Charts & widgets](charts-widgets.md) · [Back to index](../README.md) · [Next: Weather data APIs →](weather-apis.md)
