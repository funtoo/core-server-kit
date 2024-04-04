# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/9797a2fb077370340c202689ad3aed967116e8cb -> aws-crt-python-0.20.6-9797a2f.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/0de6b271bdfb447853d1af0eced39faed7f746f3 -> aws-c-auth-0.7.17-0de6b27.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/314fc555846ac7bf2cc68a117c99a6af26f7043e -> aws-c-cal-0.6.11-314fc55.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/ae7b067d9274d2d3faa1d3ae42d489a6986661f7 -> aws-c-common-0.9.15-ae7b067.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/ea1d421a421ad83a540309a94c38d50b6a5d836b -> aws-c-compression-0.2.18-ea1d421.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/1a70c50f78a6e706f1f91a4ed138478271b6d9d3 -> aws-c-event-stream-0.4.2-1a70c50.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/98ec73ad0c18b78ba08d40b4e60d97abf794f24d -> aws-c-http-0.8.1-98ec73a.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/bf2d72230727f02eddb5b16c4e6c5ac5a3f203a7 -> aws-c-io-0.14.7-bf2d722.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/74da9cadfa9dfd2179479fdc445617f5da3261ba -> aws-c-mqtt-0.10.3-74da9ca.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/0ce756ec29b251cd81f6937ccf856a3878c5edd3 -> aws-c-s3-0.5.5-0ce756e.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/638fdd6548df85c599f82db7ea70fd9e44917ef5 -> aws-c-sdkutils-0.1.15-638fdd6.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/aac442a2dbbb5e72d0a3eca8313cf65e7e1cac2f -> aws-checksums-0.1.18-aac442a.tar.gz
	https://github.com/awslabs/aws-lc/tarball/4e690737e0a386f8c5eb9a0a88becc7985b5d24e -> aws-lc-1.23.0-4e69073.tar.gz
	https://github.com/aws/s2n-tls/tarball/38d769c9cd079b4bbe250032acdc7fdafbfaab51 -> s2n-tls-1.4.9-38d769c.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="dev-util/cmake"
RDEPEND=""
BDEPEND=""

AWS_C_MODULES=( 
	aws-c-auth
	aws-c-cal
	aws-c-common
	aws-c-compression
	aws-c-event-stream
	aws-c-http
	aws-c-io
	aws-c-mqtt
	aws-c-s3
	aws-c-sdkutils
	aws-checksums
	aws-lc
	s2n
)


post_src_unpack() {
	if [ ! -d "${S}" ] ; then
		mv "${WORKDIR}"/awslabs-aws-crt-python-* "${S}" || die
	fi

	for module in "${AWS_C_MODULES[@]}"; do
		rmdir ${S}/crt/${module} || die
		einfo "Moving ${module} into source tree"
		mv ${WORKDIR}/*${module}* ${S}/crt/${module} || die
	done
}