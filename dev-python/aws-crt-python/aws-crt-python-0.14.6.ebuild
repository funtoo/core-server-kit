# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/a61d5b99790e6a46295f8602eee2a1e97378e4c1 -> aws-crt-python-0.14.6-a61d5b9.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/e8360a65e0f3337d4ac827945e00c3b55a641a5f -> aws-c-auth-0.6.17-e8360a6.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/cc43764ddef1c23c6c5ae16badecbc989e4e45c8 -> aws-c-cal-0.5.19-cc43764.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/bd417541440e2660bbf9ba33565a24abaefe7a9a -> aws-c-common-0.8.1-bd41754.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/63e1ada3d1c1b2d337e9edc5ea977b1f17450ded -> aws-c-compression-0.2.15-63e1ada.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/381e4806042e067e808f80fe409ae5121084b467 -> aws-c-event-stream-0.2.14-381e480.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/f81ee942fa9b149711d90b4a3f3af5c946151d16 -> aws-c-http-0.6.20-f81ee94.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/442f9236db6f4c9b970fe0a08d9cda50bc444a81 -> aws-c-io-0.13.4-442f923.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/cea176e7f3ec32d1465788e95ae9c652014aa135 -> aws-c-mqtt-0.7.12-cea176e.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/3530a060bf71d9d9c2826a2558ad5164afd2f7c0 -> aws-c-s3-0.1.48-3530a06.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/2d9ef421f88ab9599f1a128fd4567c2ada64a6b8 -> aws-c-sdkutils-0.1.3-2d9ef42.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/48e7c0e01479232f225c8044d76c84e74192889d -> aws-checksums-0.1.13-48e7c0e.tar.gz
	https://github.com/awslabs/aws-lc/tarball/75a73bfabf1be384b49c7f92da6fdfd9d867069e -> aws-lc-1.3.0-75a73bf.tar.gz
	https://github.com/aws/s2n-tls/tarball/48880b452414ddcd2e4adffe63b48fb0feddea29 -> s2n-tls-1.3.22-48880b4.tar.gz
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