set HTTP_PROXY_HOST=proxy
set HTTP_PROXY_PORT=8080
set HTTPS_PROXY_HOST=proxy
set HTTPS_PROXY_PORT=8080
set HTTP_NON_PROXY_HOSTS="localhost|*.sap.corp|nexus"
call \_neo\neo-sdk-2.0.5\tools\neo.bat deploy --java-version 7 -b hanabendrot -a p1671404376trial -u P1671404376 -s target\abendrot-web.war -h https://nwtrial.ondemand.com -S binding.json 