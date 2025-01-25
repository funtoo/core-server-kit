# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/379079d9049499af660b70423aa7cc3aca0d5e52 -> deno-2.1.7-379079d.tar.gz
https://direct.funtoo.org/7e/61/0d/7e610dbb14e3a761b4c6f2b496f6a91f00d5552f7d0a405df3a5af84f6f438085be6110e20a9f2a5ab2823cad1e3902c0378f728848b55e7e2598376704a1c91 -> deno-2.1.7-funtoo-crates-bundle-97703341465cd29579ceb0d887ef57bb0c45d9a72f4fd0d54b20492f315b110600e346abf480bbd6e8710b92a75933047cf66e3dd043a4e0b1f75cc6ceba9947.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

BDEPEND="
	sys-devel/llvm:*
	sys-devel/clang:*
	sys-devel/lld:*
	dev-util/gn
	virtual/rust
"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/denoland-deno-* ${S} || die
}

src_compile() {
	# Don't try to fetch prebuilt V8, build it instead
	export V8_FROM_SOURCE=1

	# Resolves to /usr/lib64/llvm/<version>
	export CLANG_BASE_PATH="$(readlink -f -- "$(dirname -- $(clang --print-prog-name=clang))/..")"

	cargo_src_compile
}

src_install() {
	# Install the binary directly, cargo install doesn't work on workspaces
	dobin target/release/deno

	dodoc -r docs
}