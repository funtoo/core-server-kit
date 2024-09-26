# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A fast and secure runtime for WebAssembly"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime https://docs.wasmtime.dev"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v25.0.1/wasmtime-v25.0.1-src.tar.gz -> wasmtime-v25.0.1-src.tar.gz
https://direct.funtoo.org/3b/b0/c0/3bb0c001f61761712f082a00f0d0a8341f25c2c281f32b51b80e43035d5ba127f6b810b55c60dca5fecd48474a4e2ddb021e9c7bdaaa9f697ac57b914c180271 -> wasmtime-25.0.1-funtoo-crates-bundle-eed1ba41907e09ebf84c56d34e282b45d32a1f20af045f9573df9c05198a34e4f83b356bbf56e462130336a6c58078d03ea6081b21d5b703da83b711702cc72d.tar.gz"

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