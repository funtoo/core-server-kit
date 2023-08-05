# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/348f79dfdb5fd5cc05c632f48baf4eaf9f485fe7 -> aws-crt-python-0.17.0-348f79d.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/840047a24e16304fd9fd88512e29f8cb48ff3c60 -> aws-c-auth-0.7.2-840047a.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/29578cdcb3c046efc6680f6baea572dec9bdbc2e -> aws-c-cal-0.6.1-29578cd.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/5c736d5c39a7e7ce8b5feb88d051084b41a8c7ea -> aws-c-common-0.9.0-5c736d5.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/99ec79ee2970f1a045d4ced1501b97ee521f2f85 -> aws-c-compression-0.2.17-99ec79e.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/ec1716c726babd1381560aa8d28941fffc987394 -> aws-c-event-stream-0.3.1-ec1716c.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/f800427e2e2878cf8b36f602583758769a7b3b4a -> aws-c-http-0.7.11-f800427.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/a3555c86bd10149a1ab0c1b2810756ec54cfbe3a -> aws-c-io-0.13.31-a3555c8.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/b777be4aa52d233391781256d40006d353e848b9 -> aws-c-mqtt-0.9.2-b777be4.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/231188147a8c08c9ed709100a2380be42bad6350 -> aws-c-s3-0.3.14-2311881.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/a6fd80cf7c163062d31abb28f309e47330fbfc17 -> aws-c-sdkutils-0.1.12-a6fd80c.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/321b805559c8e911be5bddba13fcbd222a3e2d3a -> aws-checksums-0.1.17-321b805.tar.gz
	https://github.com/awslabs/aws-lc/tarball/05fc080291bd694c51394dea0cff62ad5d260832 -> aws-lc-1.13.0-05fc080.tar.gz
	https://github.com/aws/s2n-tls/tarball/65e74ca7c116ca40f81732c0906f6419e8c7bfa5 -> s2n-tls-1.3.48-65e74ca.tar.gz
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