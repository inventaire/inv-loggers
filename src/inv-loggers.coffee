require 'colors'

log = (obj, label, color = 'cyan')->
  if typeof obj is 'string' and not label?
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

partialLogger = (logger)-> (label)-> (obj)-> logger obj, label

logs_.Log = partialLogger logs_.log
logs_.Error = partialLogger logs_.error
logs_.Warn = partialLogger logs_.warn
logs_.Info = partialLogger logs_.info
logs_.Success = partialLogger logs_.success
logs_.ErrorRethrow = partialLogger logs_.errorRethrow

module.exports = logs_
