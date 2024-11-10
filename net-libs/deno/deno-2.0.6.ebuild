# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/8f59d18202e94e5c54ad7e5a79ec1383159e4a20 -> deno-2.0.6-8f59d18.tar.gz
https://direct.funtoo.org/e6/0f/78/e60f78e4a11687283572c4e150add4eaa31d07a401f044cfedd21481538dab246b5e3048c7692536f1d10082c421265b74e1a7dc76ef24f3c3dca92ad76cf5be -> deno-2.0.6-funtoo-crates-bundle-a64d8d118da473bd51152454ea39f6150aaea7c59f33c9b4e132fb6c8eca0a985966158e0c26b8850d0817fc0757c0ccab8ce3d8a4e81eb2036133847039b3bc.tar.gz"

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