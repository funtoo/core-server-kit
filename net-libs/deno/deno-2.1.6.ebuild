# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/4ee86d8d125c7b36570e87f0725eb82b6fe4a4b4 -> deno-2.1.6-4ee86d8.tar.gz
https://direct.funtoo.org/c4/5f/09/c45f0972011129177e3e92a56ae7a91c591432f2f5ef4984696ec02b13c3f4b881a856714d264f7f9e5799fd300e3bba5c254cfba44bd3ecac331a4024ddaad2 -> deno-2.1.6-funtoo-crates-bundle-2608dfe2e2bdfef9c5ad8f0d983ff6f5c595fde3e24a734d4b8e406932d583902a73b1d31cabdd0d71757778222de0dcfd4b46b0b8f8da08a316ccd7d95369c1.tar.gz"

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