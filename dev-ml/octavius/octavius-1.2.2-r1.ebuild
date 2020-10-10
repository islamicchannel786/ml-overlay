# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit jbuilder

DESCRIPTION="ocamldoc comment syntax parser"
HOMEPAGE="https://github.com/ocaml-doc/octavius"
SRC_URI="https://github.com/ocaml-doc/octavius/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${DEPEND}"
