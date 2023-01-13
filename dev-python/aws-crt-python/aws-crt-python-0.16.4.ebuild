# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/10d3900c2e88dfb491c9b93b75d47024685f9f66 -> aws-crt-python-0.16.4-10d3900.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/bad1066f0a93f3a7df86c94cc03076fa6b901bd2 -> aws-c-auth-0.6.22-bad1066.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/ac4216b78d5323b5b8ce95a3dd4a8fc0f95e2d33 -> aws-c-cal-0.5.20-ac4216b.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/a9a3c552dc036a5fb7996c6aab47157c006d3b6f -> aws-c-common-0.8.8-a9a3c55.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/b517b7decd0dac30be2162f5186c250221c53aff -> aws-c-compression-0.2.16-b517b7d.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/2f9b60c42f90840ec11822acda3d8cdfa97a773d -> aws-c-event-stream-0.2.18-2f9b60c.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/dd34461987947672444d0bc872c5a733dfdb9711 -> aws-c-http-0.7.3-dd34461.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c7d756af12a20b94364b10805e2120c1d2ef0b96 -> aws-c-io-0.13.13-c7d756a.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/5cbde90916a1f9945e2a1ef36f3db58e1c976167 -> aws-c-mqtt-0.8.4-5cbde90.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/71de4107368580f23e7bb30ac33fd80d062c08d7 -> aws-c-s3-0.2.2-71de410.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/208a701fa01e99c7c8cc3dcebc8317da71362972 -> aws-c-sdkutils-0.1.7-208a701.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/ad53be196a25bbefa3700a01187fdce573a7d2d0 -> aws-checksums-0.1.14-ad53be1.tar.gz
	https://github.com/awslabs/aws-lc/tarball/75a73bfabf1be384b49c7f92da6fdfd9d867069e -> aws-lc-1.3.0-75a73bf.tar.gz
	https://github.com/aws/s2n-tls/tarball/2663f20bdc801f0d94657db3e6cec4c4fed0db94 -> s2n-tls-1.3.32-2663f20.tar.gz
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