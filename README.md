# triton-wordpress
## What is this?
Triton is a very nice container platform run by Joyent.  Lots of people
want to run wordpress.  I've made an image to make running wordpress
easier.

## Shared Image
I maintain a built version of this image on the Joyent Public Cloud.
I can't mark it as public, but I can add you as a user of the image.
If you would like to be added, please send jeff+triton-wordpress@goekesmi.com
an email with your JPC account uuid.

You can get your account uuid from the triton command line tools with
`triton account get -j | json id` .  You can also get it from your invoices
which can be found at https://my.joyent.com/main/#!/account .

## I want to build my own image
### Prerequsites
The below instructions assume you have the triton command line tooling
in place, and have that working in addition to the packer tool from
packer.io

### Build the image
`packer build packer.json`

## Using the Image
### Make a wordpress instance
`triton instance create -n wordpress triton-wordpress g4-highcpu-512M`

#### Package Selection
So, how small of a machine can you run this image on.  The memory footprint of
the image is about 500M.  I can get the image to start on a 256M instance, but
it is very, very slow, because half of the memory is swapped out to disk.  
Perhaps you don't mind the performance being measured in seconds.  I do. Use
images with at least 512M of memory.  You'll probably want that for the disk
space for your media anyway if you are on JPC.

### Make a domain name point at your instance
`triton instance get wordpress | json primaryIp`
gives you the IP address of the instance once the instance is up and running

Fix DNS however is necessary to point your domain name at that IP.

### Install wordpress
Go to http://example.com and do the wordpress install.

### SSL
The image builds a unique and hilariously invalid self signed cert and
puts it in place on the haproxy front end.  Wordpress can't use this and
it can't be configured to use it until the inital configuration is done.

Run the following commands to use the utility script to configure tls in
wordpress.
```
triton ssh node@wordpress
./wp-add-tls-config.sh 
```

###  Getting a real cert
Hilariously invalid cert is annoyingly useless.
Get a real one with.
```
triton ssh wordpress
export domain=example.com
acme-get-cert
svcadm restart haproxy
```

###  Useful Bits

/opt/local/sbin/manta-backup will backup your wordpress instance to manta, 
assuming you have a manta environment variables setup.

/home/node/AutoUpdateWordpress.sh is setup to run daily to upgrade your 
wordpress install via crontab on the node user.  Strongly suggested.


