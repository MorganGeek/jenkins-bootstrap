import jenkins.model.Jenkins
import net.sf.json.JSONObject
import hudson.ProxyConfiguration

if(!binding.hasVariable('proxy_settings')) {
    proxy_settings = [:]
}

if(!(proxy_settings instanceof Map)) {
    throw new Exception('proxy_settings must be a Map.')
}

proxy_settings = proxy_settings as JSONObject

def proxy = Jenkins.instance.proxy

proxy.dump() 
Jenkins.instance.proxy.metaClass.methods.name.unique()

boolean save = false
String proxy_host = (proxy_settings.optString('host'))?:''
int proxy_port = (proxy_settings.optInt('port'))?:0
String proxy_username = (proxy_settings.optString('username'))?:''
String proxy_password = (proxy_settings.optString('password'))?:''
String no_proxy_hosts = (proxy_settings.optString('no_proxy_hosts'))?:''

if(proxy_host != proxy.name) {
    save = true
}
if(proxy_port != proxy.port) {
    save = true
}
if(proxy_username != proxy.userName) {
    save = true
}
if(proxy_password != proxy.password) {
    save = true
}
if(no_proxy_hosts != proxy.noProxyHost) {
    save = true
}
if(save) {
   proxy = new hudson.ProxyConfiguration(
        proxy_settings.optString('host'),
        proxy_settings.optInt('port'),
        proxy_settings.optString('username'),
        proxy_settings.optString('password'),
        proxy_settings.optString('no_proxy_hosts'))
   // proxy.save()
    Jenkins.instance.proxy = proxy
   // Jenkins.instance.save()
    println 'Proxy configured'
}
else {
    println 'Nothing changed. Proxy already configured'
}
