## exchange

### encrypt, decrypt

```shell
# encrypt
$ name="rmandvikar"
$ openssl pkeyutl -encrypt -pubin -inkey "$name".key.pub -in data -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -pkeyopt rsa_mgf1_md:sha256 -out encrypted.data

$ cat encrypted.data | base64 -w 64 > encrypted.data.b64
$ cat encrypted.data.b64 | base64 -d > encrypted.data

# decrypt
$ name="rmandvikar"
$ openssl pkeyutl -decrypt -inkey "$name".key -in encrypted.data -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -pkeyopt rsa_mgf1_md:sha256 -out decrypted.data

$ cat decrypted.data
```

For large file,

```shell
# encrypt
# symmetric.key
$ openssl rand -base64 32 > "$name".symmetric.key
$ openssl aes-256-cbc -a -pbkdf2 -salt -in data -out encrypted.data -kfile "$name".symmetric.key

# encrypt symmetric.key
$ openssl pkeyutl -encrypt -pubin -inkey "$name".key.pub -in "$name".symmetric.key -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -pkeyopt rsa_mgf1_md:sha256 -out "$name".encrypted.symmetric.key

$ cat "$name".encrypted.symmetric.key | base64 -w 64 > "$name".encrypted.symmetric.key.b64
$ cat "$name".encrypted.symmetric.key.b64 | base64 -d > "$name".encrypted.symmetric.key

$ cat encrypted.data
$ cat "$name".encrypted.symmetric.key

# decrypt
# decrypt symmetric.key
$ openssl pkeyutl -decrypt -inkey "$name".key -in "$name".encrypted.symmetric.key -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -pkeyopt rsa_mgf1_md:sha256 -out "$name".decrypted.symmetric.key
# decrypt
$ openssl aes-256-cbc -d -a -pbkdf2 -in encrypted.data -out decrypted.data -kfile "$name".decrypted.symmetric.key

$ cat decrypted.data
```

### gen key

```shell
# private key
$ openssl genrsa -out "$name".key 4096
# public key
$ openssl rsa -in "$name".key -outform PEM -pubout -out "$name".key.pub
```

For large file,

```shell
$ openssl rand -base64 32 > "$name".symmetric.key
```
