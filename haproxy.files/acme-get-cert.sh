/root/.acme.sh/acme.sh --issue --standalone -d $domain --httpport 8888 --reloadcmd "cat \$CERT_KEY_PATH \$CERT_FULLCHAIN_PATH > /opt/local/etc/certs/"$domain
