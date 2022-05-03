# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/555e2b802f295ea93eab6e5d8d19a91744b7e72c -> aws-crt-python-0.13.11-555e2b8.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/5755fc110b6d7e3ac4225fd50415b518e061dd8c -> aws-c-auth-0.6.13-5755fc1.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/7eb1d7360ea205ff275d2acc6cce2682063b643f -> aws-c-cal-0.5.17-7eb1d73.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/ee859bf31f2d840c25a1b7cb7d4624aa31b77905 -> aws-c-common-0.7.1-ee859bf.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/5fab8bc5ab5321d86f6d153b06062419080820ec -> aws-c-compression-0.2.14-5fab8bc.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/e87537be561d753ec82e783bc0929b1979c585f8 -> aws-c-event-stream-0.2.7-e87537b.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/b76ebf2207c989e1d8e1c5e1a9ab1b0c32de3483 -> aws-c-http-0.6.15-b76ebf2.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/8f4508f5ec7d2949d5545e2b1ddcd1beb47a76a8 -> aws-c-io-0.11.0-8f4508f.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/6168e32bf9f745dec40df633b78baa03420b7f83 -> aws-c-mqtt-0.7.10-6168e32.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/2f6fa845e76e010abec7a44b1288dda096d1814c -> aws-c-s3-0.1.39-2f6fa84.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/e3c23f4aca31d9e66df25827645f72cbcbfb657a -> aws-c-sdkutils-0.1.2-e3c23f4.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/41df3031b92120b6d8127b7b7122391d5ac6f33f -> aws-checksums-0.1.12-41df303.tar.gz
	https://github.com/awslabs/aws-lc/tarball/11b50d39cf2378703a4ca6b6fee9d76a2e9852d1 -> aws-lc-1.0.2-11b50d3.tar.gz
	https://github.com/aws/s2n-tls/tarball/8314a96de0c33a426ae877856a8a1a431d354e0d -> s2n-tls-1.3.12-8314a96.tar.gz
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