# How to contribute

Community contributions are heavily welcome in Turris project. We value every
contribution and every contributor. As Turris OS is quite complex, here are few
hints how to contribute and where.

Turris OS spans over multiple repositories. Base one is
[turris-os](https://github.com/CZ-NIC/turris-os). This is fork of OpenWRT base
repo with some modifications by us and some cherry-picked from LEDE. Upstream
changes in LEDE will be merged here slowly, but it might take quite some time
for changes to get into it from upstream. Whenever you want to contribute
something to this repository, try to contribute it to LEDE as well. This way
your change wouldn't get lost on next rebase.

Then we use various upstream OpenWRT feeds like
[packages](https://github.com/openwrt/packages). If you want something changed
there, send your contribution to upstream and we will pick it up on next
update. We are updating feeds quite often. In particular if you would like new
package included in Turris OS, please send it to
[packages](https://github.com/openwrt/packages).

Last repo is our own packages repo
[turris-os-packages](https://github.com/CZ-NIC/turris-os-packages/) that we
maintain ourselves. This contain packages that are either Turris specific or
diverged too much from upstream and thus it makes more sense to maintain them
locally.

In our repositories all development happens in `test` branch. So if your
contribution should go into one of our repositories, send a pull request
against `test` branch. You can use basic GitHub fork/pull-request workflow.

## Technicalities

All our GitHub repositories are mirrors of our development repositories hosted
at our [gitlab](https://gitlab.labs.nic.cz/turris) but they are always in sync
so for all purposes, they are the same. Alternatively you can also send us
patches via issue or even via mail to packaging [at] turris.cz.
