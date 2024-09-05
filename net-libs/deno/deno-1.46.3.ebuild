# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/a98e146a55b209458160bcd148497310a9e14441 -> deno-1.46.3-a98e146.tar.gz
https://direct.funtoo.org/0f/b1/71/0fb171a4a274ce2bacff6dfbec7d8e4f0fc700aa3f04e8b3f838cdfecb7798af16f3b7833fc9b77f5a7da52876eff045b6878055780d379f6bcb8917add8a5d1 -> deno-1.46.3-funtoo-crates-bundle-354f70c6ab35b5031770fe183d2ab06b81f0d926d9f3bf99dd08e1c59b9a9aa74f1c4ad60cec28e44a7be4950a5404c39b2f1e02a7c02fbae064dd3772e922d8.tar.gz"

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