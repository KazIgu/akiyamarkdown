'use strict'
app = require 'app'
BrowserWindow = require 'browser-window'
Menu = require 'menu'
require('crash-reporter').start()

mainWindow = null

app.on 'window-all-closed', () ->
  if process.platform != 'darwin'
    app.quit()

app.on 'ready', () ->
  mainWindow = new BrowserWindow
    width: 1024
    height: 768
  mainWindow.loadUrl "file://#{__dirname}/index.html"

  mainWindow.on 'closed', () ->
    mainWindow = null
    return
