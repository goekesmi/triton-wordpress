# Prerequsites

The below instructions assume you have the triton command line tooling
in place, and have that working in addition to the packer tool from
packer.io

# Build the image
`packer build packer.json`

# Make a wordpress instance
`triton instance create -n wordpress triton-wordpress g4-highcpu-512M`


# Make a domain name point at your instance
`triton instance get wordpress | json primaryIp`
gives you the IP address of the instance once the instance is up and running

Fix DNS however is necessary to point your domain name at that IP.

# Install wordpress
Go to http://example.com and do the wordpress install.

# SSL
The image builds a unique and hilariously invalid self signed cert and
puts it in place on the haproxy front end.  Wordpress can't use this and
it can't be configured to use it until the inital configuration is done.

Run the following commands to use the utility script to configure tls in
wordpress.
```
triton ssh node@wordpress
./wp-add-tls-config.sh 
```

# Getting a real cert
Hilariously invalid cert is annoyingly useless.
Get a real one with.
```
triton ssh wordpress
export domain=example.com
acme-get-cert
svcadm restart haproxy
```

# Useful Bits

/opt/local/sbin/manta-backup will backup your wordpress instance to manta, 
assuming you have a manta environment variables setup.

/home/node/AutoUpdateWordpress.sh is setup to run daily to upgrade your 
wordpress install via crontab on the node user.  Strongly suggested.


