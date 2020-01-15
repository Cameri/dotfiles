# PGP

## Set the home for your GPG configuration
Add `export GNUPGHOME=$HOME/.gnupg` to your `.bashrc` or `.zshrc` file.

## Harden your local GPG configuration

Backup `~/.gnupg/gpg.conf` first if you have one.

`$ cp ~/.gnupg/gpg.conf ~/.gnupg/gpg.backup.conf`

Edit `~/.gnupg/gpg.conf` and ensure it has the following contents:

```sh
$ tee $HOME/.gnupg/gpg.conf <<<EOF > /dev/null
personal-cipher-preferences AES256 AES192 AES
personal-digest-preferences SHA512 SHA384 SHA256
personal-compress-preferences ZLIB BZIP2 ZIP Uncompressed
default-preference-list SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed
cert-digest-algo SHA512
s2k-digest-algo SHA512
s2k-cipher-algo AES256
charset utf-8
fixed-list-mode
no-comments
no-emit-version
keyid-format LONG
list-options show-uid-validity
verify-options show-uid-validity
with-fingerprint
require-cross-certification
no-symkey-cache
throw-keyids
use-agent
EOF
```

## Creating a PGP key pair with Keybase

### PGP key pair creation

You will need to provide a passphrase for your key. A secure passphrase can be generated using:

`$ gpg --gen-random --armor 0 24`

This passphrase will need to be provided in the future when using the key. You should store this securely in a convenient place (e.g. password manager).

#### With Keybase

Create an account on Keybase.

Ensure you are logged in. Execute the following and follow the prompts:

`$ keybase login`

Generate a new master key. Execute the following and follow the prompts:

`$ keybase pgp gen --multi`

```
Enter your real name, which will be publicly visible in your new key: John Doe
Enter a public email address for your key: john.doe@contoso.com
Enter another email address (or <enter> when done):
Push an encrypted copy of your new secret key to the Keybase.io server? [Y/n] Y
When exporting to the GnuPG keychain, encrypt private keys with a passphrase? [Y/n] Y
▶ INFO PGP User ID: John Doe <john.doe@contoso.com> [primary]
▶ INFO Generating primary key (4096 bits)
▶ INFO Generating encryption subkey (4096 bits)
▶ INFO Generated new PGP key:
▶ INFO   user: John Doe <john.doe@contoso.com>
▶ INFO   4096-bit RSA key, ID 13C4248EDC4E2AE6, created 2019-12-19
▶ INFO Exported new key to the local GPG keychain
```

A master key (with ID 13C4248EDC4E2AE6) with signing (S) and certificate (C) creation capabilities has been created.
A secret sub-key (with ID 9BD6D3AC729A5E99, not shown above) belonging to the former master key is also created with encryption (E) capabilities.
The master key and subkeys do not have authentication capability. An authentication subkey should be created for each secure device, which we will do at a later step. Do not reuse authentication subkeys between devices.

Verify that the PGP key is active on Keybase:

`$ keybase pgp list`

```
Keybase Key ID:  01017b15cebdd61be6e6e1d9337c15df89bd55817e4e5c2405013740d2a138dd2ecc0a
PGP Fingerprint: b41efc96f041800732483b5613c4248edc4e2ae6
PGP Identities:
   John Doe <john.doe@contoso.com>
```

Verify that the secret key is in your local GPG keychain:

`$ gpg --list-secret-keys`
or, alternatively:
`$ gpg -K`

```
/Users/youruser/.gnupg/pubring.kbx
---------------------------------------
sec   rsa4096/13C4248EDC4E2AE6 2019-12-19 [SC] [expires: 2035-12-15]
      B41EFC96F041800732483B5613C4248EDC4E2AE6
uid                 [ unknown] John Doe <john.doe@contoso.com>
ssb   rsa4096/9BD6D3AC729A5E99 2019-12-19 [E] [expires: 2035-12-15]
```

Disable expiration on the master secret key (optional):

`$ gpg --edit-key 13C4248EDC4E2AE6`

```
gpg (GnuPG/MacGPG2) 2.2.17; Copyright (C) 2019 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Secret key is available.

sec  rsa4096/13C4248EDC4E2AE6
     created: 2019-12-19  expires: never       usage: SC
     trust: unknown       validity: unknown
ssb  rsa4096/9BD6D3AC729A5E99
     created: 2019-12-19  expires: 2035-12-15  usage: E
[ unknown] (1). John Doe <john.doe@contoso.com>

gpg> expire
Changing expiration time for the primary key.
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 0
Key does not expire at all
Is this correct? (y/N) y

sec  rsa4096/13C4248EDC4E2AE6
     created: 2019-12-19  expires: never       usage: SC
     trust: unknown       validity: unknown
ssb  rsa4096/9BD6D3AC729A5E99
     created: 2019-12-19  expires: 2035-12-15  usage: E
[ unknown] (1). John Doe <john.doe@contoso.com>

gpg> save
```

#### Without keybase:
*TODO*

### Importing PGP key in another host

#### With Keybase

Ensure you are logged into keybase on the other host. Run the following and follow the prompts:

`$ keybase login`

List all the keys stored on your Keybase account:

`$ keybase pgp list`

```
Keybase Key ID:  01017b15cebdd61be6e6e1d9337c15df89bd55817e4e5c2405013740d2a138dd2ecc0a
PGP Fingerprint: b41efc96f041800732483b5613c4248edc4e2ae6
PGP Identities:
   John Doe <john.doe@contoso.com>
```

Store the Keybase key ID for the next commands:

```sh
KEYBASE_KEY_ID=01017b15cebdd61be6e6e1d9337c15df89bd55817e4e5c2405013740d2a138dd2ecc0a
```

Import the public key into your GPG keychain:

`$ keybase pgp export -q $KEYBASE_KEY_ID | gpg --import`

```
gpg: key 13C4248EDC4E2AE6: "John Doe <john.doe@contoso.com>" imported
gpg: Total number processed: 1
```

Import the private key into your GPG keychain:

`$ keybase pgp export -q $KEYBASE_KEY_ID --secret | gpg --import --allow-secret-key-import`

```
gpg: key 13C4248EDC4E2AE6: "John Doe <john.doe@contoso.com>" 1 new signature
gpg: key 13C4248EDC4E2AE6: secret key imported
gpg: Total number processed: 1
gpg:         new signatures: 1
gpg:       secret keys read: 1
```

Verify that the private key was imported:

`$ gpg --list-secret-keys`

## Using a Yubikey for SSH authentication

You must add an authentication subkey for each Yubikey you plan to use.

#### WARNING
```
This is a destructive operation.
Transfering your GPG keys to the CCD module of your Yubikey, or any other smartcard,
will convert the GPG key stored on your GPG keychain to a stub which won't allow you
to transfer the key to any more Yubikeys or smartcards.
```

List your secret keys:

`$ gpg --list-secret-keys`

```
/Users/youruser/.gnupg/pubring.kbx
---------------------------------------
sec   rsa4096/13C4248EDC4E2AE6 2019-12-19 [SC]
      Key fingerprint = B41E FC96 F041 8007 3248  3B56 13C4 248E DC4E 2AE6
uid                 [ unknown] John Doe <john.doe@contoso.com>
ssb   rsa4096/9BD6D3AC729A5E99 2019-12-19 [E] [expires: 2035-12-15]
```

Open your key for editing:

`$ gpg --expert --edit-key 13C4248EDC4E2AE6`

```
gpg (GnuPG/MacGPG2) 2.2.17; Copyright (C) 2019 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Secret key is available.

sec  rsa4096/13C4248EDC4E2AE6
     created: 2019-12-19  expires: never       usage: SC
     trust: unknown       validity: unknown
ssb  rsa4096/9BD6D3AC729A5E99
     created: 2019-12-19  expires: 2035-12-15  usage: E
[ unknown] (1). John Doe <john.doe@contoso.com>

gpg>
```

No secret subkeys with authentication capability are present in the previous example. Secret subkeys end with `usage: A`. The `A` means Authentication. We must add one.

### Adding an authentication subkey to your GPG keypair

TODO
