require 'colors'
_ =
  extend: require 'lodash.assign'
  partialRight: require 'lodash.partialright'

module.exports = ->
  log = (obj, label, color = 'cyan')->
    if typeof obj is 'string' and !label?
      console.log obj[color]
      return obj

    else
      if label?
        console.log "****** ".grey + label.toString()[color] + " ******".grey
      else
        console.log "******************************"[color]
      console.log obj
      console.log "-----".grey
      return obj

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

  partialLogger = (logger)-> (label)-> _.partialRight logger, label

  partialLoggers =
    Log: partialLogger logs_.log
    Error: partialLogger logs_.error
    Warn: partialLogger logs_.warn
    Info: partialLogger logs_.info
    Success: partialLogger logs_.success
    ErrorRethrow: partialLogger logs_.errorRethrow

  return _.extend logs_, partialLoggers
