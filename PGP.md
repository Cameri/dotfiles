# PGP

**Warning:** Create keys only on trusted machines.

## Creating a key pair

### Dependencies
- Keybase
- GnuPG2

```sh
$ brew install gpg
$ brew cask install keybase
```

### List existing secret keys
`$ gpg -K`
or, alternatively:
`$ gpg --list-secret-keys`

### GPG key pair creation

You will need to provide a passphrase for your key. A secure passphrase can be generated using:

`$ gpg --gen-random -a 0 24`


#### With Keybase

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



The newly created secret key 

**Note:** A master key with signing (S) and certificate (C) creation capabilities is created.
A secret sub-key belonging to the former master key is also created with encryption (E) capabilities.
A secret sub-key with authentication capability is NOT created in this step.



#### Without keybase:
*TODO*

