path = require 'path'
vows = require 'vows'
assert = require 'assert'
coffeelint = require path.join('..', 'lib', 'coffeelint')

vows.describe('trailing').addBatch({

    'Trailing whitespace' :

        topic : () ->
            "x = 1234      \ny = 1"

        'can be forbidden' : (source) ->
            config = {trailing: false}
            errors = coffeelint.lint(source, config)
            assert.equal(errors.length, 1)
            error = errors[0]
            assert.isObject(error)
            assert.equal(error.line, 0)
            assert.equal(error.character, 14)
            assert.equal(error.reason, "Contains trailing whitespace")
            assert.equal(error.evidence, "x = 1234      ")

        'can be permitted' : (source) ->
            config = {trailing: true}
            errors = coffeelint.lint(source, config)
            assert.equal(errors.length, 0)

        'is forbidden by default' : (source) ->
            config = {}
            errors = coffeelint.lint(source, config)
            assert.equal(errors.length, 1)

    'Trailing tabs' :

        topic : () ->
            "x = 1234\t"

        'are forbidden as well' : (source) ->
            errors = coffeelint.lint(source, {})
            assert.equal(errors.length, 1)

}).export(module)

