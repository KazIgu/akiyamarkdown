gulp = require 'gulp'
runSequence = require 'run-sequence'
requireDir = require 'require-dir'
dir = requireDir './gulp/task'

gulp.task 'default', (callback) ->
  return runSequence(
    'clean',
    ['jade', 'main', 'coffee', 'stylus', 'image', 'vendor'],
    callback
    )

gulp.task 'develop', ['default', 'watch']