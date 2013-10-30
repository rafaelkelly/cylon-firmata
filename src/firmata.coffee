###
 * Cylonjs Firmata adaptor
 * http://cylonjs.com
 *
 * Copyright (c) 2013 The Hybrid Group
 * Licensed under the Apache 2.0 license.
###

'use strict';

LibFirmata = require('firmata')
namespace = require 'node-namespace'

namespace "Cylon.Adaptor", ->
  class @Firmata extends Cylon.Basestar
    constructor: (opts) ->
      super
      @connection = opts.connection
      @name = opts.name
      @board = ""

    commands: ->
      ['pins', 'pinMode', 'digitalRead', 'digitalWrite', 'analogRead', 'analogWrite']
      #'servoWrite', 'sendI2CConfig', 'sendI2CWriteRequest', 'sendI2CReadRequest']

    connect: (callback) ->
      Logger.debug "Connecting to board '#{@name}'..."
      @board = new LibFirmata.Board @connection.port.toString(), =>
        @connection.emit 'connect'
        (callback)(null)

      @proxyMethods @commands, @board, Firmata

    disconnect: ->
      Logger.debug "Disconnecting from board '#{@name}'..."
      @board.close

    digitalRead: (pin, callback) ->
      @board.pinMode pin, @board.MODES.INPUT
      @board.digitalRead pin, callback

    digitalWrite: (pin, value) ->
      @board.pinMode pin, @board.MODES.OUTPUT
      @board.digitalWrite pin, value

    analogRead: (pin, callback) ->
      @board.analogRead(pin, callback)

    analogWrite: (pin, value) ->
      @board.pinMode pin, @board.MODES.ANALOG
      @board.analogWrite @board.analogPins[pin], value