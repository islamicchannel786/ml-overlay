# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit jbuilder

DESCRIPTION="Execute code blocks inside markdown files"
HOMEPAGE="https://github.com/realworldocaml/mdx"
SRC_URI="https://github.com/realworldocaml/mdx/releases/download/${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-ml/fmt:=
	dev-ml/astring:=
	dev-ml/logs:=
	dev-ml/cmdliner:=
	dev-ml/re:=
	dev-ml/result:=
	dev-ml/ocaml-migrate-parsetree:=
"
DEPEND="${RDEPEND}
	test? ( dev-ml/lwt app-text/pandoc )
"
BDEPEND="dev-ml/cppo"

src_prepare() {
	default
	has_version '>=dev-lang/ocaml-4.09' && eapply "${FILESDIR}/oc409.patch"
}
