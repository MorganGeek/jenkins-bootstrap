#!/usr/bin/env bash

#A script which bootstraps a Jenkins installation and configuration
#scripts

function cleanup_on() {
  #clean up jenkins headers file
  [ -n "${JENKINS_HEADERS_FILE}" -a -f "${JENKINS_HEADERS_FILE}" ] && rm -f "${JENKINS_HEADERS_FILE}"
  if [ "$1" = '0' ]; then
    echo "Jenkins is ready.  Visit ${JENKINS_WEB}/"
    echo "User: ${JENKINS_USER}"
    [ ! "$JENKINS_USER" = 'admin' ] || echo "Password: ${JENKINS_PASSWORD}"
  fi
}
trap 'cleanup_on $?' EXIT

source env.sh
#set password if using vagrant
export JENKINS_HEADERS_FILE="$(mktemp)"
export JENKINS_USER="${JENKINS_USER:-admin}"

set -e

if [ -e "${SCRIPT_LIBRARY_PATH}/common.sh" ]; then
  source "${SCRIPT_LIBRARY_PATH}/common.sh"
else
  echo "ERROR could not find ${SCRIPT_LIBRARY_PATH}/common.sh"
  echo "Perhaps environment variable SCRIPT_LIBRARY_PATH is not set correctly."
  exit 1
fi

#persist credentials
export JENKINS_PASSWORD="${JENKINS_PASSWORD:-$(<"${JENKINS_HOME}"/secrets/initialAdminPassword)}"
"${SCRIPT_LIBRARY_PATH}"/jenkins-call-url -a -m HEAD -o /dev/null "${JENKINS_WEB}"

jenkins_console --script "${SCRIPT_LIBRARY_PATH}/console-skip-2.0-wizard.groovy"
jenkins_console --script ./settings.groovy --script "${SCRIPT_LIBRARY_PATH}"/configure-jenkins-settings.groovy
jenkins_console --script ./settings.groovy --script "${SCRIPT_LIBRARY_PATH}"/configure-proxy-settings.groovy
jenkins_console --script ./settings.groovy --script "${SCRIPT_LIBRARY_PATH}"/configure-jenkins-plugins.groovy
