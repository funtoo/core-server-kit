# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Python bindings for the AWS Common Runtime"
HOMEPAGE="https://github.com/awslabs/aws-crt-python"
SRC_URI="
	https://github.com/awslabs/aws-crt-python/tarball/fcb1b2d526127c46cb0621671d91732432941ba8 -> aws-crt-python-0.13.14-fcb1b2d.tar.gz
	https://github.com/awslabs/aws-c-auth/tarball/5755fc110b6d7e3ac4225fd50415b518e061dd8c -> aws-c-auth-0.6.13-5755fc1.tar.gz
	https://github.com/awslabs/aws-c-cal/tarball/7eb1d7360ea205ff275d2acc6cce2682063b643f -> aws-c-cal-0.5.17-7eb1d73.tar.gz
	https://github.com/awslabs/aws-c-common/tarball/ab0a44ad9bf2c83f9ff9037a0e7235eb97e1c856 -> aws-c-common-0.7.4-ab0a44a.tar.gz
	https://github.com/awslabs/aws-c-compression/tarball/5fab8bc5ab5321d86f6d153b06062419080820ec -> aws-c-compression-0.2.14-5fab8bc.tar.gz
	https://github.com/awslabs/aws-c-event-stream/tarball/158d8e9c0c4684a218c0309ffe80f7ff765c3f1e -> aws-c-event-stream-0.2.12-158d8e9.tar.gz
	https://github.com/awslabs/aws-c-http/tarball/aadc57a3829cb057acdd6d57ed0991ff61a71192 -> aws-c-http-0.6.17-aadc57a.tar.gz
	https://github.com/awslabs/aws-c-io/tarball/c1c97db6cfab078271796583c43db7e0bd6a4c43 -> aws-c-io-0.12.0-c1c97db.tar.gz
	https://github.com/awslabs/aws-c-mqtt/tarball/936b788b477fc7f3227bef2d86037bbfa462316a -> aws-c-mqtt-0.7.11-936b788.tar.gz
	https://github.com/awslabs/aws-c-s3/tarball/4d82a49c9893d67c5a97d00185bbd6fd9e9a1ea4 -> aws-c-s3-0.1.43-4d82a49.tar.gz
	https://github.com/awslabs/aws-c-sdkutils/tarball/e3c23f4aca31d9e66df25827645f72cbcbfb657a -> aws-c-sdkutils-0.1.2-e3c23f4.tar.gz
	https://github.com/awslabs/aws-checksums/tarball/41df3031b92120b6d8127b7b7122391d5ac6f33f -> aws-checksums-0.1.12-41df303.tar.gz
	https://github.com/awslabs/aws-lc/tarball/e7413d237bb60bf639e78aa43ff3c1b1783f0712 -> aws-lc-1.1.0-e7413d2.tar.gz
	https://github.com/aws/s2n-tls/tarball/aa8f7fbb5e8afb649230f70917dd6bbe31702019 -> s2n-tls-1.3.16-aa8f7fb.tar.gz
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