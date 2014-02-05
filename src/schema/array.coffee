_ = require 'lodash'

AnySchema = require './any'

module.exports = class ArraySchema extends AnySchema

StringSchema = require './string'

ArraySchema
  # Sanitization
  .action 'slice', (args...) ->
    @next (@value.slice args...)

  .action 'join', StringSchema, (args...) ->
    @next (@value.join args...)

  # Validation
  .action 'includes', (values...) ->
    for value in values
      unless (_.contains @value, value)
        return @fail()

    @next()

  .action 'excludes', (values...) ->
    for value in values
      if (_.contains @value, value)
        return @fail()

    @next()

  .action 'minLen', (min) ->
    if @value.length >= min then @next() else @fail()

  .action 'maxLen', (max) ->
    if @value.length <= max then @next() else @fail()

  .action 'len', (len) ->
    if @value.length is len then @next() else @fail()