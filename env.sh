#sane defaults
export JENKINS_WAR="${JENKINS_WAR:-jenkins.war}"

export JENKINS_HOME="${JENKINS_HOME:-/var/lib/jenkins}"
export JENKINS_START="${JENKINS_START:-java -Xms4g -Xmx4g -XX:MaxPermSize=512M -jar ${JENKINS_WAR}}"
export JENKINS_WEB="${JENKINS_WEB:-http://localhost:8080}"

export SCRIPT_LIBRARY_PATH="${SCRIPT_LIBRARY_PATH:-./scripts}"
