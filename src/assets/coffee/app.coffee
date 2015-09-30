remote = require 'remote'
dialog = remote.require 'dialog'
browserWindow = remote.require 'browser-window'
Menu = remote.require 'menu'
MenuItem = remote.require 'menu-item'
app = remote.require 'app'

fs = require 'fs'
Path = require 'path'
$ = require 'jquery'
require 'ace-min-noconflict'
require 'ace-min-noconflict/theme-monokai'
require './assets/javascripts/syntax'

# -------------------------
# Menu
# -------------------------
menu = Menu.buildFromTemplate require './assets/javascripts/menu'
Menu.setApplicationMenu menu


# -------------------------
# Editor
# -------------------------
ID = '0'
Editors = []
FontSize = parseInt $('#editor').css "font-size"

# ----------
# Save
# ----------
saveFile = () ->
  id = ID
  editor = ace.edit("editor#{id}")
  CurrentPath = $("#tab#{id}").attr 'data-path'
  if CurrentPath == ""
    saveNewFile()
    return

  win = browserWindow.getFocusedWindow()

  dialog.showMessageBox win,
      title: '上書きするぜー'
      type: 'info'
      buttons: ['OK', 'Cancel']
      detail: """
        #{CurrentPath}を上書いちゃうぜー
      """
    , (respnse) ->
      if respnse == 0
        data = editor.getValue()
        writeFile CurrentPath, data

writeFile = (path, data) ->
  fs.writeFile path, data, (error) ->
    if error != null
      alert "error : #{error}"

saveNewFile = () ->
  id = ID
  editor = ace.edit("editor#{id}")
  win = browserWindow.getFocusedWindow()
  dialog.showSaveDialog win,
    properties: ['openFile']
    filters: [
      name: 'Documents'
      extensions: ['amd']
    ]
  , (fileName) ->
    if fileName
      data = editor.getValue()
      writeFile fileName, data

# ----------
# Close
# ----------
closeFile = () ->
  # Editorがなければ終了
  if Editors.length == 0
    return

  id = ID
  editor = ace.edit("editor#{id}")

  $tab = $("#tab#{id}")
  $editor = $("#editor#{id}")

  $tab.remove()
  $editor.remove()

  index = Editors.indexOf id
  Editors.splice index, 1

  # Editorがなければ終了
  if Editors.length == 0
    return

  if index > 0
    changeTab Editors[index - 1]
  else
    changeTab Editors[0]


# ----------
# Open
# ----------
openLoadFile = () ->
  win = browserWindow.getFocusedWindow()
  dialog.showOpenDialog win,
    properties: ['openFile']
    filters: [
      name: 'Documents'
      extensions: ['amd']
    ]
  , (filenames) ->
    if (filenames)
      createEditor filenames[0]

createEditor = (path) ->
  id = Date.now()

  $editor = $('#editor')
  $tabs = $('#header').find('.tabs')
  $tab = $("<div id='tab#{id}' class='tab'><span id='close#{id}' class='close'>×</span></div>")
  $content = $("<div id='editor#{id}' class='editor'></div>")

  $tabs.find('.is-active').removeClass 'is-active'
  $tab.addClass 'is-active'

  $tab.on 'click', (e) ->
    changeTab(id)

  $tabs.append $tab
  $tab.find('.close').on 'click', (e) ->
    closeFile()

  $editor.find('.is-active').removeClass 'is-active'
  $content.addClass 'is-active'

  $editor.append $content

  editor = ace.edit("editor#{id}")

  Editors.push id.toString()

  editor.setTheme("ace/theme/monokai")
  editor.getSession().setMode("ace/mode/amd")
  editor.getSession().setOptions
   useSoftTabs: false
  editor.getSession().setTabSize(2)
  editor.getSession().on 'change', (e) ->
    if e.data.text == "\n"
      range = e.data.range
      beforeText = editor.getSession().getLine range.start.row

  editor.commands.addCommand
    name: 'child'
    bindKey:
      mac: 'Shift-Enter'
    exec: (editor) ->
      cursor = editor.selection.getCursor()
      text = editor.getSession().getLine cursor.row
      indent = text.match /(　)*/g
      indent = indent[0].length
      indentText = ""
      for i in [0...indent]
        indentText += "　"
      target = 
        row: cursor.row
        column:  text.length

      # title
      if text.match /【(.*?)】/
        editor.session.insert target, "\n#{indentText}■"

      # subtitle
      if text.match /■(.*)/
        editor.session.insert target, "\n#{indentText}　・"

      # smalltitle
      if text.match /・(.*)/
        editor.session.insert target, "\n#{indentText}　→"

      # smalltitle
      if text.match /→(.*)/
        editor.session.insert target, "\n#{indentText}→"

  if path
    # load
    fs.readFile path, (error, text) ->
      if error != null
        alert "error : #{error}"
        return
      $('title').text Path.basename path
      $tab.attr 'data-title', Path.basename path
      $tab.attr 'data-path', path
      editor.setValue text.toString(), -1
  else
    # new
    $('title').text 'untitled'
    $tab.attr 'data-title', 'untitled'
    $tab.attr 'data-path', ''

  changeTab(id)
  editor.focus()



# ----------
# View
# ----------
changeTab = (id) ->
  ID = id.toString()
  $editors = $('.editor')
  $tabs = $('.tab')
  $editor = $("#editor#{id}")
  $tab = $("#tab#{id}")
  editor = ace.edit("editor#{id}")

  $tabs.removeClass 'is-active'
  $editors.removeClass 'is-active'

  $tab.addClass 'is-active'
  $editor.addClass 'is-active'

  $('title').text Path.basename $tab.attr 'data-title'

  editor.focus()

nextTab = () ->
  if Editors.length == 0
    return

  id = ID
  editor = ace.edit("editor#{id}")

  $tab = $("#tab#{id}")
  $editor = $("#editor#{id}")

  index = Editors.indexOf id

  if index >= Editors.length - 1
    changeTab Editors[0]
  else
    changeTab Editors[index + 1]
  return

prevTab = () ->
  if Editors.length == 0
    return

  id = ID
  editor = ace.edit("editor#{id}")

  $tab = $("#tab#{id}")
  $editor = $("#editor#{id}")

  index = Editors.indexOf id

  if index == 0
    changeTab Editors[Editors.length - 1]
  else
    changeTab Editors[index - 1]
  return


changeFontSize = (type) ->
  if type == "up"
    FontSize++
  else if type == "down"
    FontSize--

  $('#editor').css
    "font-size": "#{FontSize}px"





