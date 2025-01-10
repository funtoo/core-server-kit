# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/d15a95e28b0ec015c2f2a88cca3882ba96d5da98 -> deno-2.1.5-d15a95e.tar.gz
https://direct.funtoo.org/09/ed/de/09edde9d0ab206a90238db800684f296404a1cb6f9f51393fbf038c35d972cd34ecc5be888b8e791be1d1276d1347bb7b1d81dd5fbb7baeadb8689f72080327f -> deno-2.1.5-funtoo-crates-bundle-8948899cd5f998437e87659ef8c4120230e8edfcebfaba4db282313406e5c129d4dacbea799e5e9b93f9f5562119d30618f90374d0284c535e1b9c3265de0e21.tar.gz"

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