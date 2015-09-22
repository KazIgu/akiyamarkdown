gulp = require 'gulp'
coffee = require 'gulp-coffee'

gulp.task "main", ->
  gulp.src "./src/main.coffee"
    .pipe coffee
      bare: true
    .pipe gulp.dest "./dest"
