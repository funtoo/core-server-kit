# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd user

MY_PN="${PN%-bin}"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Analytics and search dashboard for Elasticsearch"
HOMEPAGE="https://www.elastic.co/products/kibana"
SRC_URI="
	amd64? ( https://artifacts.elastic.co/downloads/kibana/kibana-7.17.2-linux-x86_64.tar.gz )
	arm64? ( https://artifacts.elastic.co/downloads/kibana/kibana-7.17.2-linux-aarch64.tar.gz )
"

# source: LICENSE.txt and NOTICE.txt
LICENSE="Apache-2.0 Artistic-2 BSD BSD-2 CC-BY-3.0 CC-BY-4.0 Elastic-2.0 icu ISC MIT MPL-2.0 OFL-1.1 openssl public-domain Unlicense WTFPL-2 ZLIB"
SLOT="0"
KEYWORDS="-* amd64 arm64"

RDEPEND="
	>=net-libs/nodejs-16.14.2
	=net-libs/nodejs-16*
	dev-libs/nss
	
"

# Do not complain about CFLAGS etc since we don't use them
QA_FLAGS_IGNORED='.*'
QA_PRESTRIPPED="
	opt/kibana/x-pack/plugins/reporting/chromium/headless_shell-linux_x64/headless_shell
	opt/kibana/x-pack/plugins/reporting/chromium/headless_shell-linux_x64/swiftshader/libEGL.so
	opt/kibana/x-pack/plugins/reporting/chromium/headless_shell-linux_x64/swiftshader/libGLESv2.so
	opt/kibana/node_modules/re2/build/Release/re2.node
"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewuser kibana
	enewgroup kibana
}

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv ${MY_P}* "${S}" || die
	fi
}

src_prepare() {
	default

	# remove unused directory
	rm -r data || die

	# remove bundled nodejs
	rm -r node || die
	sed -i 's@\(^NODE="\).*@\1/usr/bin/node"@g' \
		bin/kibana || die
	# move plugins to /var/lib/kibana
	rm -r plugins || die
	
	# handle node.js version with RDEPEND
	sed -i /node_version_validator/d \
		src/setup_node_env/no_transpilation_dist.js || die
}

src_install() {
	insinto /etc/${MY_PN}
	doins -r config/.
	rm -r config || die

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${MY_PN}.logrotate ${MY_PN}

	newconfd "${FILESDIR}"/${MY_PN}.confd ${MY_PN}
	newinitd "${FILESDIR}"/${MY_PN}.initd-r1 ${MY_PN}
	systemd_dounit "${FILESDIR}"/${MY_PN}.service

	insinto /opt/${MY_PN}
	doins -r .

	fperms -R +x /opt/${MY_PN}/bin

	diropts -m 0750 -o ${MY_PN} -g ${MY_PN}
	
	keepdir /var/lib/${MY_PN}/plugins
	keepdir /var/log/${MY_PN}

	
	dosym ../../var/lib/kibana/plugins /opt/kibana/plugins
}

pkg_postinst() {

	elog "This version of Kibana is compatible with Elasticsearch $(ver_cut 1-2) and"
	elog "Node.js 16. Some plugins may fail with other versions of Node.js"
	elog
	elog "To set a customized Elasticsearch instance:"
	elog "  OpenRC: set ES_INSTANCE in /etc/conf.d/${MY_PN}"
	elog "  systemd: set elasticsearch.url in /etc/${MY_PN}/kibana.yml"
	elog
	elog "Elasticsearch can run local or remote."
}