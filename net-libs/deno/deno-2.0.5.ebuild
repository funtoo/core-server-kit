# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/78a799b4947461eb5c6092295cbcdabfe94053f7 -> deno-2.0.5-78a799b.tar.gz
https://direct.funtoo.org/50/5e/d9/505ed90449053969d68e8d1df7f0321c92d5e091186eacdbacdcdc8c3b1ada5455b6fbe90da05cf8d36a5dee95437643118327363b39629e2423469e1eb4b538 -> deno-2.0.5-funtoo-crates-bundle-f49867e09c8df710ab779a0a5bab08a47fcf1aa4ab74572998dd9fb7f61ca39f9ed7f77c18e9bc0ca012b9507e889f5222e553a86529fc98b9034177b3d67592.tar.gz"

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