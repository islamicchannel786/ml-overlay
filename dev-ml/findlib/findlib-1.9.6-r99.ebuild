# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib

DESCRIPTION="OCaml tool to find/use non-standard packages"
HOMEPAGE="http://projects.camlcity.org/projects/findlib.html"
SRC_URI="http://download.camlcity.org/download/${P}.tar.gz"
IUSE="doc +ocamlopt tk"

LICENSE="MIT"

SLOT="0/${PV}"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos"

DEPEND=">=dev-lang/ocaml-4.08.1-r1:=[ocamlopt?]
	tk? ( dev-ml/labltk:= )"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply "${FILESDIR}/metas.patch"
	export ocamlfind_destdir="${EPREFIX}/usr/$(get_libdir)/ocaml"
	export stublibs="${ocamlfind_destdir}/stublibs"
	default
}

src_configure() {
	local myconf
	use tk && myconf="-with-toolbox"
	./configure -bindir "${EPREFIX}"/usr/bin -mandir "${EPREFIX}"/usr/share/man \
		-sitelib ${ocamlfind_destdir} \
		-config ${ocamlfind_destdir}/findlib/findlib.conf \
		-no-custom \
		${myconf} || die "configure failed"
}

src_compile() {
	emake -j1 all
	if use ocamlopt; then
		emake -j1 opt # optimized code
	fi
}

src_install() {
	emake prefix="${D}" install

	dodir "${stublibs#${EPREFIX}}"

	cd "${S}/doc"
	dodoc QUICKSTART README DOCINFO
	use doc && dohtml -r ref-html guide-html
}

check_stublibs() {
	local ocaml_stdlib=`ocamlc -where`
	local ldconf="${ocaml_stdlib}/ld.conf"

	if [ ! -e ${ldconf} ]
	then
		echo "${ocaml_stdlib}" > ${ldconf}
		echo "${ocaml_stdlib}/stublibs" >> ${ldconf}
	fi

	if [ -z `grep -e ${stublibs} ${ldconf}` ]
	then
		echo ${stublibs} >> ${ldconf}
	fi
}

pkg_postinst() {
	check_stublibs
}
