


# Make a wordpress instance
 triton instance create -N campus -n nonaka-80 -m siteurl=https://nonaka-80.matrix.msu.edu/ wordpress g4-highcpu-1G
## learn the admin user's password
triton instance get nonaka-80 | json metadata.wordpress-pw
