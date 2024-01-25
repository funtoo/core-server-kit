# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/2981db9551dd4fe6b518aa8ba569a4200effa92b -> aws-crt-python-0.20.2-2981db9.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/119403930667b8f99f7873af5fb0ca5b0cdbe5ab -> aws-c-auth-0.7.14-1194039.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/b52d9e8ee7af8155e6928c977ec5fde25a507ba0 -> aws-c-cal-0.6.9-b52d9e8.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/8eaa0986ad3cfd46c87432a2e4c8ab81a786085f -> aws-c-common-0.9.12-8eaa098.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/b7a96fd2dc43f4625d784ea51106e1fac4255f7a -> aws-c-event-stream-0.4.1-b7a96fd.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/6a1c157c20640a607102738909e89561a41e91e9 -> aws-c-http-0.8.0-6a1c157.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/0b03c30949a2d6327557f25fd02ea1d148e1900b -> aws-c-io-0.14.2-0b03c30.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/17ee24a2177fc64cf9773d430a24e6fa06a89dd0 -> aws-c-mqtt-0.10.1-17ee24a.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/73d3c869ae27db266a7de2e5d2e89181a25c5330 -> aws-c-s3-0.4.10-73d3c86.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/6c7764eed43a528b6577906a993e47018b06095f -> aws-c-sdkutils-0.1.14-6c7764e.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/321b805559c8e911be5bddba13fcbd222a3e2d3a -> aws-checksums-0.1.17-321b805.tar.gz
	https://github.com/awslabs/aws-lc/tarball/19d9ace40f6770e062b1e9ec1d46935b300b948e -> aws-lc-1.21.0-19d9ace.tar.gz
	https://github.com/aws/s2n-tls/tarball/54fbc3c3d4530badaa2c0be518b745bb6e1ebf41 -> s2n-tls-1.4.2-54fbc3c.tar.gz
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