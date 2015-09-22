gulp = require 'gulp'
browserSync = require 'browser-sync'
paths = require('../config').paths

gulp.task 'server', () ->
  browserSync
    notify: false
    server:
      baseDir: 'public'

  gulp.watch 'public/**/*', browserSync.reload
