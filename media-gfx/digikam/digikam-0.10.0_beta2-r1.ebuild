# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre3"

NEED_KDE="4.1"
KDE_LINGUAS="ar be bg ca da de el es et eu fa fi fr ga gl he hi is ja km ko lt
lv lb nds ne nl nn pa pl pt pt_BR ro ru se sk sv th tr uk vi zh_CN"

inherit kde4-base

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tar.bz2"

LICENSE="GPL-2"
RDEPEND="${DEPEND}"
SLOT="4.1"
IUSE="debug"

S="${WORKDIR}/${P/_/-}"

KEYWORDS="~amd64"

# it have dynamic search for deps, so if they are in system it
# uses them otherwise does not, so any iuse are useless
DEPEND="
	dev-db/sqlite:3
	kde-base/kdebase-data:${SLOT}
	kde-base/libkdcraw:${SLOT}
	kde-base/libkexiv2:${SLOT}
	kde-base/libkipi:${SLOT}
	kde-base/marble:${SLOT}[kde]
	kde-base/solid:${SLOT}
	!kdeprefix? ( !media-gfx/digikam:0 )
	>=media-libs/jasper-1.701.0
	media-libs/jpeg
	>=media-libs/lcms-1.17
	>=media-libs/libgphoto2-2.4.1-r1
	>=media-libs/libpng-1.2.26-r1
	>=media-libs/tiff-3.8.2-r3
	sys-devel/gettext
	x11-libs/qt-core[qt3support]
	x11-libs/qt-sql[sqlite]"
#liblensfun when added should be also dep.
RDEPEND="${DEPEND}"

# we want to install into kdedir so we can keep kde3 and kde4 version along
PREFIX="${KDEDIR}"

src_unpack() {
	local lang

	unpack ${A}
	cd "${S}"
	# fix files collision, use icon from kdebase-data rather that digikam ones
	sed -i \
		-e "s:add_subdirectory:#add_subdirectory:g" \
		data/icons/CMakeLists.txt || die "Failed to remove icon install"
	enable_selected_linguas
}
