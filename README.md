# hubot-mail-notifier

hubot-mail-notifier adds an **IMAP** notifier plugin to hubot that reports
unread or incoming new emails (sender, subject, date, text message).

## Installation

Edit the `package.json` for your hubot and add the hubot-mail-notifier
dependency.

```javascript
"dependencies": {
  "hubot-mail-notifier": ">= 0.0.1",
  ...
}
```

## Configuration

The following variables are required to let the script work:

* `HUBOT_MAIL_NOTIFIER_ROOMS`, comma separated list of rooms where incoming
emails should be posted
* `HUBOT_MAIL_NOTIFIER_USERNAME`, username
* `HUBOT_MAIL_NOTIFIER_PASSWORD`, password
* `HUBOT_MAIL_NOTIFIER_HOST`, mail host

The following variables are optional:

* `HUBOT_MAIL_NOTIFIER_PORT`, mail host port, default to `993`
* `HUBOT_MAIL_NOTIFIER_SECURE`, whether to use secure connection, default to
`true`
* `HUBOT_MAIL_NOTIFIER_MAILBOX`, mail box to monitor, default to `INBOX`
* `HUBOT_MAIL_NOTIFIER_MARK_SEEN`, whether to mark seen email as read, default
to `true`
* `HUBOT_MAIL_NOTIFIER_FETCH_UNREAD`, whether to fetch unread emails on start,
default to `true`

## TODO

* Support for POP3
* Reporting of HTML content
* Reporting of attachments

## See Also

This work is heavily inspired by the
[mail-listener](https://github.com/circuithub/mail-listener) node module.
