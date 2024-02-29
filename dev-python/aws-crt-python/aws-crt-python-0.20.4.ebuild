# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/258a8c8d23fbb7742cffc95ae7087a26e451e761 -> aws-crt-python-0.20.4-258a8c8.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/0d2aa00ae70c699fcb14d0338c1b07a58b9eb24b -> aws-c-auth-0.7.16-0d2aa00.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/56f0a79ceb10f2efcf92f525ace717f84d8c8a11 -> aws-c-cal-0.6.10-56f0a79.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/15a25349d59852e2655c0920835644f2eb948d77 -> aws-c-common-0.9.13-15a2534.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/ea1d421a421ad83a540309a94c38d50b6a5d836b -> aws-c-compression-0.2.18-ea1d421.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/1a70c50f78a6e706f1f91a4ed138478271b6d9d3 -> aws-c-event-stream-0.4.2-1a70c50.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/98ec73ad0c18b78ba08d40b4e60d97abf794f24d -> aws-c-http-0.8.1-98ec73a.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/5b89f50a813271d68b8efe58f0515b480b1356c7 -> aws-c-io-0.14.5-5b89f50.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/d4346e0e68a727a53dc52b285fe1c2f64fd65414 -> aws-c-mqtt-0.10.2-d4346e0.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/59569e317a4ef84506c39b798875f4f169a796fe -> aws-c-s3-0.5.2-59569e3.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/638fdd6548df85c599f82db7ea70fd9e44917ef5 -> aws-c-sdkutils-0.1.15-638fdd6.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/aac442a2dbbb5e72d0a3eca8313cf65e7e1cac2f -> aws-checksums-0.1.18-aac442a.tar.gz
	https://github.com/awslabs/aws-lc/tarball/19d9ace40f6770e062b1e9ec1d46935b300b948e -> aws-lc-1.21.0-19d9ace.tar.gz
	https://github.com/aws/s2n-tls/tarball/80a691335f6ec4846634952cb1a9bf1327e4b953 -> s2n-tls-1.4.5-80a6913.tar.gz
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