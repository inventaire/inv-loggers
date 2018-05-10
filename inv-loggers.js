const chalk = require('chalk')
const { grey } = chalk
const { inspect } = require('util')

const log = function (obj, label, color = 'cyan') {
  if ((typeof obj === 'string') && (label == null)) {
    console.log(chalk[color](obj))
    return obj
  } else {
    // converting arguments object to array bor readablilty
    if (isArguments(obj)) obj = toArray(obj)
    if (label != null) {
      console.log(grey('****** ') + chalk[color](label.toString()) + grey(' ******'))
    } else {
      console.log(chalk[color]('******************************'))
    }
    let objCopy = obj
    let context
    if (obj && obj.context) {
      context = obj.context
      objCopy = Object.assign({}, obj)
      delete objCopy.context
    }
    console.log(objCopy)
    if (context != null) {
      console.log('Context: ', inspect(context, { depth: 10 }))
    }
    console.log(grey('-----'))
    return obj
  }
}

const isArguments = obj => obj && obj.toString() === '[object Arguments]'
const toArray = obj => [].slice.call(obj)

const logs_ = {
  log,
  success: (obj, label) => log(obj, label, 'green'),
  info: (obj, label) => log(obj, label, 'blue'),
  // warn and error do not return the result
  warn: (obj, label) => { log(obj, label, 'yellow') },
  error: (err, label) => { log((err.stack || err), label, 'red') },
  errorRethrow: (err, label) => {
    logs_.error(err, label)
    throw err
  }
}

const partialLogger = logger => label => obj => logger(obj, label)

logs_.Log = partialLogger(logs_.log)
logs_.Error = partialLogger(logs_.error)
logs_.Warn = partialLogger(logs_.warn)
logs_.Info = partialLogger(logs_.info)
logs_.Success = partialLogger(logs_.success)
logs_.ErrorRethrow = partialLogger(logs_.errorRethrow)
// Exposing partialLogger to ease the creation of other loggers
logs_.partialLogger = partialLogger

module.exports = logs_