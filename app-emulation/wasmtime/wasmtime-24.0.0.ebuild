# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A fast and secure runtime for WebAssembly"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime https://docs.wasmtime.dev"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v24.0.0/wasmtime-v24.0.0-src.tar.gz -> wasmtime-v24.0.0-src.tar.gz
https://direct.funtoo.org/5b/d3/76/5bd37613de359a3a9b4e72628147bfca3e083489beb7eba99ea0fcf4d0358f62f9ffb1484a3059bee4b174e6cbea9fc218b4105ff6b45d3d8976b61a2741dde7 -> wasmtime-24.0.0-funtoo-crates-bundle-723f9d48cc8e5fa0e25dfa28debc00d3830782a83ba33ca618f62cac09af3e0f124b96ba324855f82dce2f2c317d907f779859b970c834846a45f228afa6bdc1.tar.gz"

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