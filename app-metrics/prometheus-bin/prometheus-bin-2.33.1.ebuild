# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit user

MY_PN=${PN/-bin/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Prometheus monitoring system and time series database for real-time metrics"
HOMEPAGE="https://github.com/prometheus/prometheus"
SRC_URI="https://github.com/prometheus/prometheus/releases/download/v2.33.1/prometheus-2.33.1.linux-amd64.tar.gz -> prometheus-2.33.1.linux-amd64.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PROMETHEUS_USER="${MY_PN}"
PROMETHEUS_HOME="/var/lib/${MY_PN}"

pkg_setup() {
	enewgroup ${PROMETHEUS_USER}
	enewuser ${PROMETHEUS_USER} -1 -1 "${PROMETHEUS_HOME}" ${PROMETHEUS_USER}
}

post_src_unpack() {
	if [ ! -d "${S}" ] ; then
		mv "${WORKDIR}"/${MY_PN}-* "${S}" || die
	fi
}

src_install() {
	dobin ${MY_PN} promtool
	insinto /etc/"${MY_PN}"
	doins ${MY_PN}.yml
	newconfd "${FILESDIR}"/"${MY_PN}".confd ${MY_PN}
	newinitd "${FILESDIR}"/"${MY_PN}".initd ${MY_PN}
	keepdir /var/{lib,log}/"${MY_PN}"
	fowners ${PROMETHEUS_USER}:${PROMETHEUS_USER} /var/{lib,log}/"${MY_PN}"
	fperms 0750 /var/{lib,log}/"${MY_PN}"
}