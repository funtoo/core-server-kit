# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/7f9b1ff30f7d9880b7c825c2b5f2de3137343d76 -> deno-2.1.3-7f9b1ff.tar.gz
https://direct.funtoo.org/2d/49/80/2d4980f0a55eb91fe4bf3ae4abd3dc3dd0a12f5c9b8d4111c50270602ae43841ba0089013a2e98ac3b47b4288175ebcbeda4f142092f0e35cd783a7483204b9a -> deno-2.1.3-funtoo-crates-bundle-33f6d8df5db0fd072184853ce0909d70361a107b7a3e4880b44d053d7d2dfed7c326912dc0429fcf42f0998fd5f9a7d5f565e95d9625b8f41a974ad83e8bb572.tar.gz"

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