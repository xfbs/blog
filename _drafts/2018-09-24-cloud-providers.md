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
  name="Hetzner Cloud"
  title="Hetzner Cloud"
  url="https://www.hetzner.de/cloud"
  icon="https://www.hetzner.de/themes/hetzner/images/favicons/apple-touch-icon.png"
%}
{% icon_grid_item
  name="Vultr"
  title="Vultr"
  url="https://www.vultr.com"
  icon="https://www.vultr.com/dist/img/favicon/favicon-180.png"
%}
{% icon_grid_item
  name="DigitalOcean"
  title="DigitalOcean"
  url=""
  icon="https://www.digitalocean.com/apple-touch-icon.png"
%}
{% icon_grid_item
  name="AWS"
  title="Amazon Web Services"
  url="https://aws.amazon.com"
  icon="https://a0.awsstatic.com/main/images/site/touch-icon-ipad-144-precomposed.png"
%}
</div>

### Vultr

Vultr used to be my go-to provider anytime I needed a quick <abbr>VPS</abbr> to test something or host something temporarily. I like their website, it's super well designed. They are really fast, it takes just a PayPal account or a credit card and 5 minutes to have a working server. They have locations in a lot of countries: {% include flag.html country="nl" %} {% include flag.html country="de" %} {% include flag.html country="fr" %} {% include flag.html country="gb" %} {% include flag.html country="us" %} {% include flag.html country="jp" %} {% include flag.html country="sg" %} {% include flag.html country="au" %}.

![Vultr prices](/assets/images/vultr-prices.png)

The prices are also quite reasonable. The cheapst VPS costs just $3.50 per month, or 0.3&cent; per hour. However, they also have beefier options. If you've ever wanted to play with a beast of a machine that has 100<abbr>GB</abbr> of <abbr>RAM</abbr>, this is where you can get that. And it'll only cost you $1 per hour.

| Server | Cores | <abbr title="Random Access Memory">RAM</abbr> | Disk (<abbr title="Solid State Disk">SSD</abbr>) | Price ($/hour) | Price ($/month) |
| --- | --- | --- | --- | --- | --- |
| 20 GB SSD | 1 | 512 | 20 | 0.005 | 3.50 |
| 25 GB SSD | 1 | 1 | 25 | 0.007 | 5 |
| 40 GB SSD | 1 | 2 | 40 | 0.015 | 10 |
| 60 GB SSD | 2 | 4 | 60 | 0.03 | 20 |
| 100 GB SSD | 4 | 8 | 100 | 0.06 | 40 |
| 200 GB SSD | 6 | 16 | 200 | 0.119 | 80 |
| 300 GB SSD | 8 | 32 | 300 | 0.238 | 160 |
| 400 GB SSD | 16 | 64 | 400 | 0.476 | 320 |
| 800 GB SSD | 24 | 96 | 800 | 0.962 | 640 |

And of course they also have an [<abbr>API</abbr>][Vultr API]! So check them out if you like. I've had had good experiences there.

### Hetzner Cloud

Hetzner Cloud is the new kid on the block. It was only launched this year, but it's already looking promising, mostly because it's the most affordable out of all the providers as far as I can tell. 

Hetzner has a long history of renting out cheap servers. They are based in Germany, which means that you get decent data protection guaranteed by law, unlike some of the other providers. They have locations in only two countries at this moment, however: {% include flag.html country="de" %} {% include flag.html country="fi" %}. 

![Hetzner Cloud prices](/assets/images/hetzner-cloud-prices.png)

As I mentioned before, they are really affordable. That is actually the reason why I switched over the them from Vultr. Their cheapest <abbr>VPS</abbr> has four times the amount of memory compared to Vultr, for example. As you can see, you do get a lot more bang for your buck. 

| Server | Cores | <abbr>RAM</abbr> (<abbr>GB</abbr>) | Disk (<abbr>GB</abbr>) | Price (€/hour) | Price (€/month) |
| --- | --- | --- | --- | --- | --- |
| <abbr>CX11</abbr> | 1 | 2 | 20 | 0.004 | 2.49 |
| <abbr>CX21</abbr> | 2 | 4 | 40 | 0.008 | 4.90 |
| <abbr>CX31</abbr> | 2 | 8 | 80 | 0.014 | 8.90 |
| <abbr>CX41</abbr> | 4 | 16 | 160 | 0.026 | 15.90 |
| <abbr>CX51</abbr> | 8 | 32 | 240 | 0.050 | 28.90 |

Of course they also provide an [<abbr>API</abbr>][Hetzner Cloud API] that you can use to integrate their services into your project.

### Digital Ocean

This is one provider that I haven't actually used myself, but I have heard of it. It's a little bit fancy and brings its own lingo: they offer *droplets* instead of <abbr>VPS</abbr>. They have a wide variety of options when it comes to these, you can get up to 4<abbr>TB</abbr> storage and 200<abbr>GB</abbr> memory. 

![Digital Ocean pricing](/assets/images/digitalocean-pricing.png)

Again, the pricing they offer is quite reasonable. I would probably have used them if Vultr didn't have such a nice convenient website. 

| <abbr>RAM</abbr> | Cores | Storage (<abbr>GB</abbr>) | Transfer (<abbr>TB</abbr>) | Price ($/month) | Price ($/hour) |
| --- | --- | --- | --- | --- | --- |
| 1 | 1 | 25 | 1 | 5 | 0.007 |
| 2 | 1 | 50 | 2 | 10 | 0.015 |
| 3 | 1 | 60 | 3 | 15 | 0.022 |
| 2 | 2 | 60 | 3 | 15 | 0.022 |
| 1 | 3 | 60 | 3 | 15 | 0.022 |
| 4 | 2 | 80 | 4 | 20 | 0.030 |
| 8 | 4 | 160 | 5 | 40 | 0.060 |
| 16 | 6 | 320 | 6 | 80 | 0.119 |
| 32 | 8 | 640 | 7 | 160 | 0.238 |
| 48 | 12 | 960 | 8 | 240 | 0.357 |
| 64 | 16 | 1,280 | 9 | 320 | 0.476 |
| 96 | 20 | 1,920 | 10 | 480 | 0.714 |
| 128 | 24 | 2,560 | 11 | 640 | 0.952 |
| 192 | 32 | 3,840 | 12 | 960 | 1.429 |

I don't think I have to mention this, but of course they also have an <abbr>API</abbr>. 

### AWS

An article about cloud computing wouldn't be complete without a reference to <abbr>AWS</abbr>. 


[Hetzner Cloud API]: https://docs.hetzner.cloud
[Vultr Affiliate]: https://www.vultr.com/?ref=7285485
[Vultr]: https://www.vultr.com/
[Vultr API]: https://www.vultr.com/api/
[^clouddata]: In theory, anyways. There are multiple attacks that can potentially leak data across virtual machines.
