---
layout: post
date: 2018-09-24
title: Cloud VPS Providers
---

Not too long ago, if you needed to run something on the web, you had only one option: rent a server at a server hosting company. This was usuall

## What's the deal?

Usually it doesn't make sense to run just one thing per server. Servers are big, and costly. It's important to utilize them well.

At some point, virtualization technology on x86 became good enough to be actually used in production. People realized this and saw opportunity. What if, instead of having one physical server for one task, we just use virtual servers that we can float between machines to utilize them most efficiently?

Back then, that was groundbreaking. And it had multiple advantages over the previous form of computing.

*   **Isolation**. Virtualized servers are isolated from other virtualized servers on the same machine. That adds security, and it means that you can run different virtual servers from different customers on the same hardware without either of them having to worry about the security of their data[^clouddata].
*   **Flexibility**. It's easier and faster to deploy virtual servers than physical servers.

So, obviously companies started offering <abbr title="Virtual Private Server">VPS</abbr>s. With 


## Providers

There are a lot of providers out there, but I want to limit myself to just a couple of them. 

<div class="icon-grid">
{% icon_grid_item
  name="AWS"
  title="Amazon Web Services"
  url="https://aws.amazon.com"
  icon="https://a0.awsstatic.com/main/images/site/touch-icon-ipad-144-precomposed.png"
%}
{% icon_grid_item
  name="DigitalOcean"
  title="DigitalOcean"
  url=""
  icon="https://www.digitalocean.com/apple-touch-icon.png"
%}
{% icon_grid_item
  name="Vultr"
  title="Vultr"
  url="https://www.vultr.com"
  icon="https://www.vultr.com/dist/img/favicon/favicon-180.png"
%}
{% icon_grid_item
  name="Hetzner Cloud"
  title="Hetzner Cloud"
  url="https://www.hetzner.de/cloud"
  icon="https://www.hetzner.de/themes/hetzner/images/favicons/apple-touch-icon.png"
%}
</div>



### Vultr

Vultr used to be my go-to provider anytime I needed a quick <abbr>VPS</abbr> to test something or host something temporarily. I like their website, it's super well designed. They are really fast, it takes a PayPal account or a credit card and 5 minutes to have a working server. They have locations in a lot of countries {% include flag.html country="nl" %} {% include flag.html country="de" %} {% include flag.html country="fr" %} {% include flag.html country="gb" %} {% include flag.html country="us" %} {% include flag.html country="jp" %} {% include flag.html country="sg" %} {% include flag.html country="au" %}.

| Server | Cores | <abbr title="Random Access Memory">RAM</abbr> | Disk (<abbr title="Solid State Disk">SSD</abbr>) | Price ($/hour) | Price ($/month) |
| --- | --- | --- | --- | --- | --- |
| 20 GB SSD | 1 | 512<abbr>MB</abbr> | 20<abbr>GB</abbr> | 0.005 | 3.50 |
| 25 GB SSD | 1 | 1<abbr>GB</abbr> | 25<abbr>GB</abbr> | 0.007 | 5 |
| 40 GB SSD | 1 | 2<abbr>GB</abbr> | 40<abbr>GB</abbr> | 0.015 | 10 |
| 60 GB SSD | 2 | 4<abbr>GB</abbr> | 60<abbr>GB</abbr> | 0.03 | 20 |
| 100 GB SSD | 4 | 8<abbr>GB</abbr> | 100<abbr>GB</abbr> | 0.06 | 40 |
| 200 GB SSD | 6 | 16<abbr>GB</abbr> | 200<abbr>GB</abbr> | 0.119 | 80 |
| 300 GB SSD | 8 | 32<abbr>GB</abbr> | 300<abbr>GB</abbr> | 0.238 | 160 |
| 400 GB SSD | 16 | 64<abbr>GB</abbr> | 400<abbr>GB</abbr> | 0.476 | 320 |
| 800 GB SSD | 24 | 96<abbr>GB</abbr> | 800<abbr>GB</abbr> | 0.962 | 640 |



![Hetzner Cloud prices](/assets/images/hetzner-cloud-prices.png)




![Vultr prices](/assets/images/vultr-prices.png)




[^clouddata]: In theory, anyways. There are multiple attacks that can potentially leak data across virtual machines.
