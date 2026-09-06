[https://wilw.dev/notes/aerc](https://wilw.dev/notes/aerc)

### 1. Gmail web settings 
Go to `(Settings -> Forwarding and POP/IMAP)`
```
- Enable IMAP access
    - "Auto-Expunge": ON
```

### 2. Create app password
Go to `https://myaccount.google.com/u/0/apppasswords`

### 3. Setup configurations:
`agenix -e secrets/file.age`

### `goimapnotify.age` example:
```yml
configurations:
  - host: imap.gmail.com
    alias: gmail
    port: 993
    tls: true
    tlsOptions:
      rejectUnauthorized: true
    username: MAIL_ADDRESS
    password: "PASSWORD"
    # or passwordCMD: "pass show email/gmail"
    boxes:
      - mailbox: INBOX
        onNewMail: "mbsync gmail:INBOX && notmuch new"
        onNewMailPost: SKIP
        onChangedMail: "mbsync gmail:INBOX && notmuch new"
        onChangedMailPost: SKIP
        onDeletedMail: "mbsync gmail:INBOX && notmuch new"
        onDeletedMailPost: SKIP
      - mailbox: "[Gmail]/Starred"
        onNewMail: "mbsync gmail:INBOX && notmuch new"
        onNewMailPost: SKIP
        onChangedMail: "mbsync gmail:INBOX && notmuch new"
        onChangedMailPost: SKIP
        onDeletedMail: "mbsync gmail:INBOX && notmuch new"
        onDeletedMailPost: SKIP
```


### `aerc-accounts.age` example:
```ini
[Gmail]
outgoing      = smtp://MAIL_ADDRESS:PASSWORD@smtp.gmail.com:587
from          = LAST_NAME NAME <MAIL_ADDRESS>

source                = notmuch://~/.local/share/mail
maildir-store         = ~/.local/share/mail/
maildir-account-path  = gmail
folders-sort          = All,Inbox
default               = Inbox
copy-to               = Sent

check-mail-cmd        = mbsync gmail && notmuch new
check-mail-timeout    = 1m
check-mail            = 1m
```

### `isync.age` example:
```ini
IMAPAccount gmail
Host imap.gmail.com
User MAIL_ADDRESS
Pass "PASSWORD"
# or PassCmd "pass show email/gmail"
TLSType IMAPS
CertificateFile /etc/ssl/certs/ca-certificates.crt

IMAPStore gmail-remote
Account gmail

MaildirStore gmail-local
Path ~/.local/share/mail/gmail/
Inbox ~/.local/share/mail/gmail/Inbox
SubFolders Verbatim

Channel gmail
Far :gmail-remote:
Near :gmail-local:
# Exclude everything under the internal [Gmail] folder, except the interesting folders
Patterns * ![Gmail]* "[Gmail]/Sent Mail" "[Gmail]/Starred" "[Gmail]/Trash"
# Automatically create missing mailboxes, both locally and on the server
Create Both
# Sync the movement of messages between folders and deletions, add after making sure the sync works
Expunge Both
# Save the synchronization state files in the relevant directory
SyncState *
```

### `notmuch.age` example:
```ini
[database]
path=.local/share/mail/

[user]
name=LAST_NAME NAME
primary_email=MAIL_ADDRESS

[new]

[search]
exclude_tags=deleted;spam;

[maildir]
synchronize_flags=true
```
