# crttools

A coolection of helper tools to deal with certificates.

## unpack-ca-file.sh

A script to extract individual certificates from a root CA file or really, any
file containing multiple certificates in PEM format.

Usage:

```sh
$ unpack-ca-file.sh /etc/ssl/certs/ca-certificates.crt
```

For N being numbers between N and the number of certificates in the input file
it will create the `N.pem` and `N.txt` files containing the pem and text
printout of each certificate in the CA file.

The script creates output files in the CWD. It checks if there is already any
file with a conflicting name so it will not overwrite any data, but better run
it in an empty directory to avoid mess.
