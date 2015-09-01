# Description:
#   Welcome new people when they enter your IRC channel.
#
# Configuration:
#   HUBOT_WELCOME_MESSAGE: The message to send to new users.
#   Defaults to "Hey {nick}, welcome to our channel!"
#   Use a placeholder of {nick} to add the user's nick to the message.
#
# Notes:
#   * A persistent brain store like hubot-redis-brain is highly recommended.
#
# Author:
#   Bob Silverberg <bob.silverberg@gmail.com>


module.exports = (robot) ->

  welcomeMsg = process.env.HUBOT_WELCOME_MESSAGE or "Hey {nick}, welcome to our channel!"

  add_nicks = (nicks) ->
    robot.brain.data.nicks ||= []
    nicks = [nicks] unless Array.isArray nicks
    for nick in nicks
      unless nick in robot.brain.data.nicks
        robot.brain.data.nicks.push nick
        robot.logger.debug "Added nick: #{nick}"

  robot.brain.on 'loaded', =>
    robot.brain.data.nicks ||= []

  if robot.adapter.bot?.addListener?
    robot.adapter.bot.addListener 'nick', (old_nick, new_nick, channels, message) ->
      add_nick new_nick

    robot.adapter.bot.addListener 'names', (room, nicks) ->
      add_nicks Object.keys nicks

  robot.enter (res) ->
    if Array.isArray robot.brain.data.nicks
      user = res.message.user
      if user.name in robot.brain.data.nicks
        robot.logger.debug "Already know #{user.name}"
        return
      add_nick user.name
      res.send welcomeMsg.replace "{nick}", user.name
