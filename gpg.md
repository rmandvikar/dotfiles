# gpg

## prep

#### gen a key pair

Follow the prompts to gen a key. Specify your full name (`Jane Doe`), and email (`jane.doe@hack.none`).

```
# RSA 4096, for example
$ gpg --full-generate-key
Please select what kind of key you want:
   (1) RSA and RSA
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
   (9) ECC (sign and encrypt) *default*
  (10) ECC (sign only)
  (14) Existing key from card
Your selection? 1

RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096

Requested keysize is 4096 bits

Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 0

Key does not expire at all
Is this correct? (y/N) y

GnuPG needs to construct a user ID to identify your key.

Real name: Jane Doe
Email address: jane.doe@hack.none
Comment:
You selected this USER-ID:
    "Jane Doe <jane.doe@hack.none>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o

We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.

gpg: revocation certificate stored as '<HOME_DIR>/.gnupg/openpgp-revocs.d/99A9456293FD4C44F5386D4B6513258D66EA7E35.rev'
public and secret key created and signed.

pub   rsa4096 2026-01-23 [SC]
      99A9456293FD4C44F5386D4B6513258D66EA7E35
uid                      Jane Doe <jane.doe@hack.none>
sub   rsa4096 2026-01-23 [E]
```

#### trust your key

```
$ gpg --edit-key 99A9456293FD4C44F5386D4B6513258D66EA7E35
Secret key is available.

sec  rsa4096/6513258D66EA7E35
     created: 2026-01-23  expires: never       usage: SC
     trust: unknown       validity: unknown
ssb  rsa4096/616E3C63CF752959
     created: 2026-01-23  expires: never       usage: E
[ unknown] (1). Jane Doe <jane.doe@hack.none>

gpg> trust
Please decide how far you trust this user to correctly verify other users' keys
(by looking at passports, checking fingerprints from different sources, etc.)

  1 = I don't know or won't say
  2 = I do NOT trust
  3 = I trust marginally
  4 = I trust fully
  5 = I trust ultimately
  m = back to the main menu

Your decision? 5
Do you really want to set this key to ultimate trust? (y/N) y

sec  rsa4096/6513258D66EA7E35
     created: 2026-01-23  expires: never       usage: SC
     trust: ultimate      validity: unknown
ssb  rsa4096/616E3C63CF752959
     created: 2026-01-23  expires: never       usage: E
[ unknown] (1). Jane Doe <jane.doe@hack.none>
Please note that the shown key validity is not necessarily correct
unless you restart the program.

gpg> quit
```

#### edit key

```
$ gpg --edit-key 99A9456293FD4C44F5386D4B6513258D66EA7E35
Secret key is available.

sec  rsa4096/6513258D66EA7E35
     created: 2026-01-23  expires: never       usage: SC
     trust: ultimate      validity: ultimate
ssb  rsa4096/616E3C63CF752959
     created: 2026-01-23  expires: never       usage: E
[ultimate] (1). Jane Doe <jane.doe@hack.none>

gpg> expire
Changing expiration time for the primary key.
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 1y
Key expires at Sat Jan 23 13:33:37 2027 PST
Is this correct? (y/N) y

sec  rsa4096/6513258D66EA7E35
     created: 2026-01-23  expires: 2027-01-24  usage: SC
     trust: ultimate      validity: ultimate
ssb  rsa4096/616E3C63CF752959
     created: 2026-01-23  expires: never       usage: E
[ultimate] (1). Jane Doe <jane.doe@hack.none>

gpg> q
Save changes? (y/N) y

$ gpg --list-key 99A9456293FD4C44F5386D4B6513258D66EA7E35
pub   rsa4096 2026-01-23 [SC] [expires: 2027-01-24]
      99A9456293FD4C44F5386D4B6513258D66EA7E35
uid           [ultimate] Jane Doe <jane.doe@hack.none>
sub   rsa4096 2026-01-23 [E]
```

#### list keys

```
# -k for --list-keys
$ gpg --list-keys
pub   rsa4096 2026-01-23 [SC]
      99A9456293FD4C44F5386D4B6513258D66EA7E35
uid           [ultimate] Jane Doe <jane.doe@hack.none>
sub   rsa4096 2026-01-23 [E]
```

and,

```
$ gpg --list-keys --keyid-format=long
pub   rsa4096/6513258D66EA7E35 2026-01-23 [SC]
      99A9456293FD4C44F5386D4B6513258D66EA7E35
uid                 [ultimate] Jane Doe <jane.doe@hack.none>
sub   rsa4096/616E3C63CF752959 2026-01-23 [E]
```

#### list secret keys

```
# -K for --list-secret-keys
$ gpg --list-secret-keys
(sensitive)
```

and,

```
$ gpg --list-secret-keys --keyid-format=long
(sensitive)
```

#### delete key, secret key

```
$ gpg --delete-secret-keys 99A9456293FD4C44F5386D4B6513258D66EA7E35
$ gpg --delete-keys 99A9456293FD4C44F5386D4B6513258D66EA7E35
```

#### export public key

```
$ gpg --export --recipient "Jane Doe" --armor > janedoe.key.pub.asc
```

#### export private key

```
$ gpg --export-secret-keys --recipient "Jane Doe" --armor > janedoe.key.asc
```

#### import someone's public key

```
$ gpg --show-keys janedoe.key.pub.asc
pub   rsa4096 2026-01-23 [SC]
      99A9456293FD4C44F5386D4B6513258D66EA7E35
uid                      Jane Doe <jane.doe@hack.none>
sub   rsa4096 2026-01-23 [E]

$ gpg --import janedoe.key.pub.asc
gpg: key 6513258D66EA7E35: public key "Jane Doe <jane.doe@hack.none>" imported
gpg: Total number processed: 1
gpg:               imported: 1
```

## encrypt

```
$ echo "bananas!" > data
```

The file `data` has secret text to encrypt. Send the `data.encrypted` file to the recipient.

```
# -e for --encrypt, -a for --armor, -r for recipient, -o for --output
$ gpg --encrypt --armor --recipient Jane --output data.encrypted --yes data
```

## encrypt, sign

```
# -e for --encrypt, -s for --sign, -a for --armor, -r for recipient, -o for --output
$ gpg --encrypt --sign --armor --recipient Jane --output data.encrypted --yes data
```

If required, see details of `data.encrypted` file.

```
$ gpg --list-packets data.encrypted
gpg: encrypted with rsa4096 key, ID 616E3C63CF752959, created 2026-01-23
      "Jane Doe <jane.doe@hack.none>"
```

## decrypt

The file `data.encrypted` has encrypted text sent by the sender. Decrypt it into file `data.decrypted`.

```
# -d for --decrypt, -r for recipient, -o for --output
$ gpg --decrypt --output data.decrypted --yes data.encrypted
gpg: encrypted with rsa4096 key, ID 616E3C63CF752959, created 2026-01-23
      "Jane Doe <jane.doe@hack.none>"
```

#### roundtrip compare

```
$ cat data data.decrypted
bananas!
bananas!
```
