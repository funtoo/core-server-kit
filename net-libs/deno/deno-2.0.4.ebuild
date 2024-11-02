# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/b7c282d2f80b12b0b2a435780fb0ea2b236ab224 -> deno-2.0.4-b7c282d.tar.gz
https://direct.funtoo.org/77/ce/c9/77cec9cff6a1ebb56c8f81bc4dd07a25bcf0cf74d41d0350a77c728f1a41a63f8d42b74862c88c193dfeb700d1188903ff48fb4189222ba2a67cbf2221a23806 -> deno-2.0.4-funtoo-crates-bundle-def3506aa2280e97eb5437f3cfbf1b49f82fd1d3ced11a1cf4fe665d9133107587f0cf997f57b7f7338a4522e072428eeeadfcb199c4c5df595ddabeb35a810e.tar.gz"

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