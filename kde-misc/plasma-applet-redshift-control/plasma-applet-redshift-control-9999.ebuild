# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KMNAME="plasma-redshift-control"
inherit kde5

DESCRIPTION="Plasma 5 applet for controlling redshift"
HOMEPAGE="https://store.kde.org/p/998916/"

LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="$(add_frameworks_dep plasma)"
RDEPEND="${DEPEND}
	x11-misc/redshift
"
