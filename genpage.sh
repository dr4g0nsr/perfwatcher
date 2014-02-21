#/bin/bash

pages="
    collectd_patches.html
    compatibility_matrix.html
    developpement.html
    download.html
    faq.html
    installation_agent.html
    installation_frontend.html
    installation.html
    installation_server.html
    maintain_a_release_branch.html
    screenshots.html
    index.html
    "

vars=$(cat << EOF
COLLECTDPW_VERSION=5.4.0.20140219
COLLECTDPW_PACKAGE=collectd-5.4.0.20140219.tar.gz
PERFWATCHER_VERSION=2.0
PERFWATCHER_PACKAGE=perfwatcher-2.0.20140221.tar.gz
EOF
)

substitute_cmd=$(
echo "sed "
for kv in $vars; do
	k=$(echo "$kv" | cut -d= -f 1)
	v=$(echo "$kv" | cut -d= -f 2- | sed -e 's/\//\\\//g')
	echo "-e s/@$k@/$v/g"
done
)

for page in $pages
do
	(
		cat tpl/header.html
		cat tpl/$page | $substitute_cmd
		cat tpl/footer.html
		) > $page
done
