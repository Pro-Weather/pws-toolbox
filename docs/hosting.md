# ☁️ Hosting & deployment

Your station software generates HTML somewhere on a Raspberry Pi in a cupboard. This page is about
getting that onto the internet without opening port 80 to the world.

[← Back to index](../README.md)

---

## Contents

- [Pick a strategy](#pick-a-strategy)
- [Static hosts](#static-hosts)
- [Tunnels (no port forwarding)](#tunnels-no-port-forwarding)
- [Self-hosting on your own box](#self-hosting-on-your-own-box)
- [VPS & container hosts](#vps--container-hosts)
- [Getting files from the Pi to the host](#getting-files-from-the-pi-to-the-host)
- [Domains, DNS & TLS](#domains-dns--tls)
- [CDN, caching & performance](#cdn-caching--performance)
- [Monitoring & uptime](#monitoring--uptime)
- [Security checklist](#security-checklist)

---

## Pick a strategy

| Strategy | Effort | Cost | Best when |
|---|---|---|---|
| **A. Push static files to a static host** | Low | €0 | WeeWX/Cumulus generates HTML → FTP/rsync/git-push it out. **The classic, and still the best.** |
| **B. Tunnel to your Pi** | Low | €0 | You need live/PHP/dynamic content, or a database on the LAN |
| **C. Serve directly from home** | Medium | €0 | You have a static IP and are comfortable with the security work |
| **D. VPS** | Medium | €4/mo | You want a normal server you fully control |
| **E. Vendor cloud only** | None | €0 | You just want a link to share — use [network pages](networks.md) |

**Most people should do A + B:** static site on Cloudflare Pages for the public, tunnel for the
admin UI and live MQTT feed.

---

## Static hosts

All free tiers below are more than enough for a weather site.

| Host | Free tier | Deploy from | Notes |
|---|---|---|---|
| **[Cloudflare Pages](https://pages.cloudflare.com/)** | Unlimited bandwidth, 500 builds/mo | Git, [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/), direct upload | **Best free option.** Unmetered bandwidth, global CDN, free TLS, [Workers](https://workers.cloudflare.com/) for dynamic bits, [R2](https://www.cloudflare.com/developer-platform/r2/) for data dumps. |
| **[GitHub Pages](https://pages.github.com/)** | 1 GB, 100 GB/mo | Git push, Actions | Zero extra accounts if the repo's already on GitHub. Static only. **Publish your data archive here too.** |
| **[Netlify](https://www.netlify.com/)** | 100 GB/mo | Git, CLI, drag-drop | Great DX, forms, redirects, edge functions |
| **[Vercel](https://vercel.com/)** | Generous hobby tier | Git, CLI | Best if your site is Next.js/Astro/SvelteKit; ISR is a nice fit for "regenerate the forecast panel hourly" |
| **[Codeberg Pages](https://codeberg.page/)** / **[GitLab Pages](https://docs.gitlab.com/ee/user/project/pages/)** | Yes | Git | Non-GitHub options |
| **[Surge.sh](https://surge.sh/)** | Yes | `surge ./public` | Simplest possible CLI deploy |
| **[Neocities](https://neocities.org/)** | 1 GB | Web/API | Charmingly old-web; a lot of PWS sites belong here spiritually |
| **[Cloudflare R2](https://www.cloudflare.com/developer-platform/r2/) / [Backblaze B2](https://www.backblaze.com/) + CDN** | 10 GB | S3 API | For hosting large historical data dumps |

⚠️ Static hosts can't run PHP — so **[PWS Dashboard](website-templates.md#pws-dashboard),
[Saratoga](website-templates.md#saratoga-weather-website-templates) and
[Weather34](website-templates.md#weather34) need real hosting** (shared PHP hosting, a VPS, or a
tunnel to your own box). WeeWX skins produce plain HTML and work anywhere.

---

## Tunnels (no port forwarding)

Expose a service running at home without touching your router, and without revealing your home IP.

| Tool | Free tier | Notes |
|---|---|---|
| **[Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/)** (`cloudflared`) | ✅ Free, unlimited | **The best answer.** Outbound-only connection, free TLS, real domain, DDoS protection, optional [Access](https://www.cloudflare.com/zero-trust/products/access/) auth in front of your admin UI. Runs fine on a Pi Zero. |
| **[Tailscale](https://tailscale.com/)** + [Funnel](https://tailscale.com/kb/1223/funnel) | ✅ Free (100 devices) | WireGuard mesh for private access; **Funnel** publishes one service publicly. Superb for admin access. |
| **[ngrok](https://ngrok.com/)** | ✅ Limited | Great for testing, static domains now on free tier |
| **[Pinggy](https://pinggy.io/)** / **[localhost.run](https://localhost.run/)** / **[bore](https://github.com/ekzhang/bore)** | ✅ | Minimal alternatives |
| **[frp](https://github.com/fatedier/frp)** | Self-hosted | If you have a VPS, frp gives you your own tunnel |
| **[WireGuard](https://www.wireguard.com/)** / **[Netbird](https://netbird.io/)** / **[ZeroTier](https://www.zerotier.com/)** | Self/free | Private networking; pair with a VPS reverse proxy for public serving |

**The standard safe setup:**
```
Internet → Cloudflare (TLS, cache, WAF) → cloudflared tunnel → nginx on Pi → /var/www/weewx
                                                             └→ :1883 MQTT-WSS (read-only user)
Admin UI (CumulusMX :8998, Grafana :3000) → Tailscale only, never public
```

---

## Self-hosting on your own box

| Server | Notes |
|---|---|
| **[Caddy](https://caddyserver.com/)** | **Easiest.** Automatic Let's Encrypt TLS with a 3-line Caddyfile. Start here. |
| **[nginx](https://nginx.org/)** | The standard. Fast static serving, easy reverse proxy, huge documentation. |
| **[Apache httpd](https://httpd.apache.org/)** | What most PHP template docs assume. Fine. |
| **[Lighttpd](https://www.lighttpd.net/)** | Very light — good on a Pi Zero |
| **[Traefik](https://traefik.io/)** | Container-native reverse proxy with automatic discovery. Great with Docker Compose. |
| **[Nginx Proxy Manager](https://nginxproxymanager.com/)** | Web UI for reverse proxy + certs, if you'd rather click than edit config |
| **[Home Assistant OS add-ons](https://www.home-assistant.io/)** | If HA is already your hub, it can host the proxy too |

**Minimal Caddyfile for a WeeWX site:**
```caddyfile
weather.example.com {
    root * /var/www/weewx
    file_server
    encode zstd gzip
    header /*.json Cache-Control "public, max-age=30"
    header Strict-Transport-Security "max-age=31536000"
}
```

**Hardware to run it on:** a Raspberry Pi 4/5 or Zero 2 W is plenty. **Boot from USB SSD, not the SD
card** — see [backups](data-storage.md#backups). An old thin client (~€40 used) is quieter, faster
and more reliable than a Pi if you have mains power available.

---

## VPS & container hosts

| Provider | From | Notes |
|---|---|---|
| **[Hetzner](https://www.hetzner.com/cloud)** | ~€4/mo | Best price/performance in Europe. CX22 runs the whole stack comfortably. |
| **[OVH](https://www.ovhcloud.com/) / [Scaleway](https://www.scaleway.com/) / [Contabo](https://contabo.com/)** | €3–6/mo | European alternatives |
| **[DigitalOcean](https://www.digitalocean.com/) / [Linode](https://www.linode.com/) / [Vultr](https://www.vultr.com/)** | $5/mo | Excellent tutorials |
| **[Oracle Cloud Always Free](https://www.oracle.com/cloud/free/)** | €0 | 4 ARM cores + 24 GB RAM free forever. Genuinely generous; availability can be flaky. |
| **[Fly.io](https://fly.io/)** / **[Railway](https://railway.app/)** / **[Render](https://render.com/)** | Free–$5 | Container-first PaaS |
| **[PikaPods](https://www.pikapods.com/)** | ~€2/mo | One-click managed Grafana/InfluxDB/etc. |
| **Shared PHP hosting** (any cheap host) | €2–5/mo | Still the right answer for Saratoga/PWS Dashboard/Weather34 |

---

## Getting files from the Pi to the host

WeeWX and CumulusMX both have this built in — you rarely need to script it.

| Method | How |
|---|---|
| **WeeWX `[[FTP]]` / `[[RSYNC]]`** | Built into `weewx.conf`. rsync over SSH is the reliable choice. |
| **CumulusMX internet settings** | FTP/FTPS/SFTP, with per-file "realtime" upload intervals |
| **rsync over SSH** | `rsync -avz --delete /var/www/weewx/ user@host:/var/www/html/` in cron |
| **[lftp](https://lftp.yar.ru/)** | `mirror -R` for FTP hosts, robust and scriptable |
| **git push → Pages** | Commit the generated HTML, let GitHub/Cloudflare Pages deploy. Gives you a free version history of your site. |
| **[rclone](https://rclone.org/)** | Sync to S3/R2/B2/Drive/anything |
| **[Wrangler](https://developers.cloudflare.com/workers/wrangler/)** | `wrangler pages deploy ./public` from cron |
| **[Syncthing](https://syncthing.net/)** | Continuous two-way sync if a push model doesn't fit |

**Tip:** upload a small `realtime.json` every 10–30 s and the full site every 5 min. Don't re-upload
600 unchanged chart PNGs every cycle — use `--delete` + checksums, or your host will rate-limit you.

---

## Domains, DNS & TLS

- **Registrars:** [Cloudflare Registrar](https://www.cloudflare.com/products/registrar/) (at-cost, no markup — best value), [Porkbun](https://porkbun.com/), [Namecheap](https://www.namecheap.com/), [Gandi](https://www.gandi.net/)
- **Cheap TLDs that suit a weather site:** `.weather` doesn't exist, but `.wx.` subdomains, `.cloud`, `.rocks`, `.observer`, `.live`, `.eu` are all cheap
- **Free subdomains:** [DuckDNS](https://www.duckdns.org/), [FreeDNS](https://freedns.afraid.org/), [nip.io](https://nip.io/), [is-a.dev](https://www.is-a.dev/)
- **Dynamic DNS:** [DuckDNS](https://www.duckdns.org/), [ddclient](https://github.com/ddclient/ddclient), [Cloudflare DDNS scripts](https://github.com/K0p1-Git/cloudflare-ddns-updater), or just use a [tunnel](#tunnels-no-port-forwarding) and stop caring about your IP
- **TLS:** [Let's Encrypt](https://letsencrypt.org/) via [Certbot](https://certbot.eff.org/), [acme.sh](https://github.com/acmesh-official/acme.sh), or automatically via Caddy/Traefik/Cloudflare. There is no excuse for a plain-HTTP weather site in 2026.

---

## CDN, caching & performance

A weather site is mostly static assets and one small JSON that changes often. Cache accordingly:

| Asset | `Cache-Control` |
|---|---|
| `realtime.json` / live data | `public, max-age=10, stale-while-revalidate=60` |
| Chart images regenerated every 5 min | `public, max-age=120` |
| HTML pages | `public, max-age=60` |
| CSS/JS/fonts/icons (hashed filenames) | `public, max-age=31536000, immutable` |

- **[Cloudflare](https://www.cloudflare.com/)** free plan: CDN, caching, TLS, DDoS protection, analytics. Turn on **Brotli** and **Early Hints**.
- Optimise chart images: [sharp](https://sharp.pixelplumbing.com/), [squoosh](https://squoosh.app/), [oxipng](https://github.com/shssoichiro/oxipng), or just emit WebP/AVIF
- Prefer **SVG or client-side charts** over server-generated PNGs where you can — smaller, sharper, zoomable
- Test with [PageSpeed Insights](https://pagespeed.web.dev/), [WebPageTest](https://www.webpagetest.org/), [Lighthouse](https://developer.chrome.com/docs/lighthouse/)
- A weather dashboard should be **under 500 KB and interactive in under 2 s**. Most PWS sites are 5 MB of unoptimised PNGs — being the fast one is easy.

---

## Monitoring & uptime

Because a weather site that silently stops updating is the default failure mode.

| Tool | Notes |
|---|---|
| **[Uptime Kuma](https://github.com/louislam/uptime-kuma)** | Self-hosted, beautiful, free. Monitor the site *and* the data freshness (keyword check on your JSON timestamp). |
| **[Healthchecks.io](https://healthchecks.io/)** | Dead-man's-switch: your upload cron pings it; if the ping stops, you get alerted. **Exactly the right tool for this job.** |
| **[UptimeRobot](https://uptimerobot.com/)** / **[BetterStack](https://betterstack.com/)** / **[Gatus](https://github.com/TwiN/gatus)** | Alternatives |
| **[Grafana alerting](https://grafana.com/docs/grafana/latest/alerting/)** | Alert on "no new rows in 15 minutes" — the check that actually matters |
| **[Netdata](https://www.netdata.cloud/)** / **[Glances](https://nicolargo.github.io/glances/)** | Host health on the Pi |
| **[Watchtower](https://containrrr.dev/watchtower/)** | Keep Docker images updated |

**Monitor the data, not just the HTTP 200.** A cached page returning 200 with three-day-old readings
is the failure you'll actually experience. Alert on the *observation timestamp*.

---

## Security checklist

- [ ] Nothing on your LAN is port-forwarded — use a [tunnel](#tunnels-no-port-forwarding)
- [ ] Admin UIs (CumulusMX `:8998`, Grafana, Home Assistant, the Pi's SSH) are **not** publicly reachable
- [ ] MQTT exposed to browsers uses a **read-only user** on a **separate WSS listener**, publishing only public topics
- [ ] No API keys in client-side JavaScript — proxy them
- [ ] TLS everywhere, HSTS on
- [ ] SSH: keys only, `PasswordAuthentication no`, [fail2ban](https://github.com/fail2ban/fail2ban) or [CrowdSec](https://www.crowdsec.net/)
- [ ] Unattended security upgrades enabled on the Pi/VPS
- [ ] Backups tested by actually restoring one ([data-storage.md#backups](data-storage.md#backups))
- [ ] Think before publishing your **exact** coordinates — a rounded location on the public map is plenty, and networks let you offset it
- [ ] `robots.txt` + rate limiting if you expose a JSON API others might hammer

---

[← Networks](networks.md) · [Back to index](../README.md) · [Next: DIY →](diy.md)
