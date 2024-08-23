# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/de11ff8c556c6922f832f639f54e5f7a6a3096b9 -> deno-1.46.1-de11ff8.tar.gz
https://direct.funtoo.org/cf/ee/bd/cfeebd62b2779d69c01247fdbec264d9ae8d6c99832ee4164c2887fa2770b031bec506fd2669795c7c99e5e8b81788fb53a0bf691506e9b477cb830d8bdaa6bf -> deno-1.46.1-funtoo-crates-bundle-ab5b9672c19ff90c34fd74bd67f3a9bacfa69101525adaca199d10f6bb4e8c09f53c352a1ffb22d5657701a0e06df2ca5264d6281075a1ea5edd3936fc548735.tar.gz"

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