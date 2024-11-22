# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A modern runtime for JavaScript and TypeScript."
HOMEPAGE="https://github.com/denoland/deno"
SRC_URI="https://github.com/denoland/deno/tarball/5d71b461530f7c374c08701cef5678a5a4ac5484 -> deno-2.1.1-5d71b46.tar.gz
https://direct.funtoo.org/be/28/2f/be282f9e4e4326b6f24e6ac755e0ad6b9e430950b8649e959ae35ceb8f08b743e1e25cc3b4a20faae88f8770e9d3bbea968c227a035b146af2df7f16b2540fb6 -> deno-2.1.1-funtoo-crates-bundle-edec6e52fcb18488b8a97331b2193de0dcba5b381ffec9c2e3a659526486b6f2c99975c11d668e564b2cd08906a660db6e827f9eb16202444bca6bfaac647192.tar.gz"

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