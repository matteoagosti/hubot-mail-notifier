MailListener = require "mail-listener"
moment = require "moment"

config =
  rooms: (process.env.HUBOT_MAIL_NOTIFIER_ROOMS or "").split(",")
  username: process.env.HUBOT_MAIL_NOTIFIER_USERNAME
  password: process.env.HUBOT_MAIL_NOTIFIER_PASSWORD
  host: process.env.HUBOT_MAIL_NOTIFIER_HOST
  port: process.env.HUBOT_MAIL_NOTIFIER_PORT
  secure: process.env.HUBOT_MAIL_NOTIFIER_SECURE
  mailbox: process.env.HUBOT_MAIL_NOTIFIER_MAILBOX
  markSeen: process.env.HUBOT_MAIL_NOTIFIER_MARK_SEEN
  fetchUnreadOnStart: process.env.HUBOT_MAIL_NOTIFIER_FETCH_UNREAD

module.exports = (robot) ->
  unless config.rooms[0].length > 0
    robot.logger.error "Please set the HUBOT_MAIL_NOTIFIER_ROOMS environment variable."
    return

  unless config.username
    robot.logger.error "Please set the HUBOT_MAIL_NOTIFIER_USERNAME environment variable."
    return

  unless config.password
    robot.logger.error "Please set the HUBOT_MAIL_NOTIFIER_PASSWORD environment variable."
    return

  unless config.host
    robot.logger.error "Please set the HUBOT_MAIL_NOTIFIER_HOST environment variable."
    return

  unless config.port
    config.port = 993

  unless config.secure
    config.secure = true

  unless config.mailbox
    config.mailbox = "INBOX"

  unless config.markSeen
    config.markSeen = true

  unless config.fetchUnread
    config.fetchUnreadOnStart = true

  mailListener = new MailListener config
  mailListener.start()

  mailListener.on "server:connected", ->
    robot.logger.info "hubot-mail-notifier connected as #{config.username} to #{config.host}:#{config.port}"

  mailListener.on "error", (err) ->
    robot.logger.error "hubot-mail-notifier error", err

  mailListener.on "mail:parsed", (mail) ->
    from = []
    for sender in mail.from
      from.push "#{sender.name} <#{sender.address}>"

    date = moment mail.headers.date

    message = """
                New email from: #{from.join ","}
                Date: #{date.fromNow()} <#{date.format "LLLL"}>
                Subject: #{mail.subject}

                #{mail.text}
              """

    for room in config.rooms
      robot.messageRoom room, message
