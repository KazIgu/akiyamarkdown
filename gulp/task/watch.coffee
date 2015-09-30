gulp = require 'gulp'
watch = require 'gulp-watch'
path = require('../config').path

gulp.task 'watch', () ->

  watch ["#{path.src.jade}/**/*.jade"], () ->
    gulp.start 'jade'

  watch ["#{path.src.stylus}/**/*.styl"], () ->
    gulp.start 'stylus'

  watch ["#{path.src.coffee}/**/*.coffee"], () ->
    gulp.start 'coffee'

  watch ["#{path.src.vendor}/**/*"], () ->
    gulp.start 'vendor'

  watch ["#{path.src.data}/**/*.json"], () ->
    gulp.start 'mock'

  watch ["./src/main.coffee"], () ->
    gulp.start 'main'
