# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A fast and secure runtime for WebAssembly"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime https://docs.wasmtime.dev"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v26.0.0/wasmtime-v26.0.0-src.tar.gz -> wasmtime-v26.0.0-src.tar.gz
https://direct.funtoo.org/2f/ca/f7/2fcaf766b14e934c913b921ae00a094b613c9774c3655a891a9155c904d929075d2762e779ce3941f12e9392175d29e79bccec69e11222128e03fe641d3e93cd -> wasmtime-26.0.0-funtoo-crates-bundle-9dbc24f07007ce55b153193de436f7dea5e9851028b7c69abfd6713f7231fc08ea66c4e6c587494228fb4bd551f6083f73d3c4503820e831bf25d6cfcec808ff.tar.gz"

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