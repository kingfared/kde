# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=5.15.5
inherit ecm frameworks.kde.org xdg-utils

DESCRIPTION="Framework for solving common problems such as caching, randomisation, and more"

LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="dbus fam"

DEPEND="
	>=dev-qt/qtcore-${QTMIN}:5[icu]
	virtual/libudev:=
	dbus? ( >=dev-qt/qtdbus-${QTMIN}:5 )
	fam? ( virtual/fam )
"
RDEPEND="${DEPEND}
	>=dev-qt/qttranslations-${QTMIN}:5
"
BDEPEND=">=dev-qt/linguist-tools-${QTMIN}:5"

src_configure() {
	local mycmakeargs=(
		-D_KDE4_DEFAULT_HOME_POSTFIX=4
		$(cmake_use_find_package fam FAM)
		$(cmake_use_find_package dbus Qt5DBus)
	)

	ecm_src_configure
}

src_test() {
	# bugs: 619656, 632398, 647414, 665682
	local myctestargs=(
		-j1
		-E "(kautosavefiletest|kdirwatch_qfswatch_unittest|kdirwatch_stat_unittest|kformattest)"
	)

	ecm_src_test
}

pkg_postinst() {
	ecm_pkg_postinst
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	ecm_pkg_postrm
	xdg_mimeinfo_database_update
}
