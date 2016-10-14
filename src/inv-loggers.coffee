chalk = require 'chalk'

log = (obj, label, color = 'cyan')->
  if typeof obj is 'string' and not label?
    console.log chalk[color](obj)
    return obj

  else
    # converting arguments object to array bor readablilty
    if isArguments obj then obj = toArray obj
    if label?
      console.log chalk.grey('****** ') + chalk[color](label.toString()) + chalk.grey(' ******')
    else
      console.log chalk[color]('******************************')
    console.log obj
    console.log chalk.grey('-----')
    return obj

isArguments = (obj)-> obj?.toString() is '[object Arguments]'
toArray = (obj)-> [].slice.call obj

logs_ =
  log: log
  error: (err, label)->
    log (err.stack or err), label, 'red'
    return
  success: (obj, label)-> log obj, label, 'green'
  info: (obj, label)-> log obj, label, 'blue'
  warn: (obj, label)->
    log obj, label, 'yellow'
    return

logs_.errorRethrow = (err, label)->
  logs_.error err, label
  throw err

# Exposing partialLogger to ease the creation of other loggers
logs_.partialLogger = partialLogger = (logger)-> (label)-> (obj)-> logger obj, label

logs_.Log = partialLogger logs_.log
logs_.Error = partialLogger logs_.error
logs_.Warn = partialLogger logs_.warn
logs_.Info = partialLogger logs_.info
logs_.Success = partialLogger logs_.success
logs_.ErrorRethrow = partialLogger logs_.errorRethrow

module.exports = logs_
