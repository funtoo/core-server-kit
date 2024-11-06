# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A fast and secure runtime for WebAssembly"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime https://docs.wasmtime.dev"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v26.0.1/wasmtime-v26.0.1-src.tar.gz -> wasmtime-v26.0.1-src.tar.gz
https://direct.funtoo.org/46/15/50/4615501a9610ed81d335d44a43af8fd95598d9685163358d224a08590419a45f890ce7f06a27e15e49db895dee4a4c1b9ca89c2796b31a3f5d67d122ca9de04a -> wasmtime-26.0.1-funtoo-crates-bundle-979ef3cf8162e487db9c6306a82cb4f9c4244f5dc57c8ca9af26a9eb96ea24b1690036cfc333d11c88a1eaa0939c4cf488688baa7bafdb729a321fa1703f9084.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="*"

DOCS=( ADOPTERS.md README.md RELEASES.md )

QA_FLAGS_IGNORED="/usr/bin/wasmtime"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/wasmtime-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}