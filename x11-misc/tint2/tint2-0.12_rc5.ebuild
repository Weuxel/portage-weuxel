# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ 

EAPI="5"

inherit cmake-utils eutils git-r3

DESCRIPTION="A lightweight panel/taskbar"
HOMEPAGE="https://gitlab.com/o9000/tint2"
EGIT_REPO_URI="https://gitlab.com/o9000/tint2.git"
EGIT_COMMIT="cc826cbcb5d0170a48ff1f69d31c73449bab829f"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="battery examples tint2conf"

COMMON_DEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango[X]
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXdamage
	x11-libs/libXcomposite
	x11-libs/libXrender
	x11-libs/libXrandr
	media-libs/imlib2[X]"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	x11-proto/xineramaproto"
RDEPEND="${COMMON_DEPEND}
	tint2conf? ( x11-misc/tintwizard )"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable battery BATTERY)
		$(cmake-utils_use_enable examples EXAMPLES)
		$(cmake-utils_use_enable tint2conf TINT2CONF)

		# bug 296890
		"-DDOCDIR=/usr/share/doc/${PF}"
	)

	cmake-utils_src_configure
}

src_install() {
	export SANDBOX_ON=0
	cmake-utils_src_install
	rm -f "${D}/usr/bin/tintwizard.py"
}
