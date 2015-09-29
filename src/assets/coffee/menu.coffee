remote = require 'remote'
dialog = remote.require 'dialog'
browserWindow = remote.require 'browser-window'
app = remote.require 'app'
$ = require 'jquery'
module.exports = [
  {
    label: 'Akiyamarkdown'
    submenu: [
      {
        label: 'About'
      }
      {
        label: '終了'
        accelerator: 'Command+Q'
        click: () ->
          app.quit()
      }
    ]
  },
  {
    label: 'ファイル'
    submenu: [
      {
        label: '開く'
        accelerator: 'Command+O'
        click: () ->
          openLoadFile()
      }
      {
        label: '保存'
        accelerator: 'Command+S'
        click: () ->
          saveFile()
      }
      {
        label: '名前を付けて保存'
        accelerator: 'Command+Shift+S'
        click: () ->
          saveNewFile()
      }
    ]
  },
  {
    label: '編集'
    submenu: [
      {
        label: '戻る'
        accelerator: 'Command+Z'
        role: 'undo'
      }
      {
        label: 'Redo'
        accelerator: 'Shift+Command+Z'
        role: 'redo'
      }
      {
        label: 'コピー'
        accelerator: 'Command+C'
        role: 'copy'
      }
      {
        label: '貼り付け'
        accelerator: 'Command+V'
        role: 'paste'
      }
    ]
  }
  {
    label: '表示'
    submenu: [
      {
        label: 'テキストを大きく'
        accelerator: 'Command+Shift+;'
        click: () ->
          changeFontSize 'up'
      }
      {
        label: 'テキストを小さく'
        accelerator: 'Command+-'
        click: () ->
          changeFontSize 'down'
      }
    ]
  }

  # {
  #   label: '開発'
  #   submenu: [
  #     {
  #       label: 'リロード'
  #       accelerator: 'Command+R'
  #       click: () ->
  #         win = browserWindow.getFocusedWindow()
  #         win.restart()
  #     }
  #     {
  #       label: 'Developer Tools'
  #       accelerator: 'Shift+Command+C'
  #       click: () ->
  #         win = browserWindow.getFocusedWindow()
  #         win.toggleDevTools()
  #     }
  #   ]
  # }
]



CurrentPath = ""
FontSize = parseInt $('#editor').css "font-size"

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
      loadFile filenames[0]

loadFile = (path) ->
  CurrentPath = path
  fs.readFile path, (error, text) ->
    if error != null
      alert "error : #{error}"
      return
    $('title').text CurrentPath
    editor.setValue text.toString(), -1




saveFile = () ->
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
  win = browserWindow.getFocusedWindow()
  dialog.showSaveDialog win,
      properties: ['openFile']
      filters: [
          name: 'Documents'
          extensions: ['txt', 'text', 'html', 'js']
      ]
    , (fileName) ->
      if fileName
        data = editor.getValue()
        currentPath = fileName
        writeFile currentPath, data


changeFontSize = (type) ->
  if type == "up"
    FontSize++
  else if type == "down"
    FontSize--

  $('#editor').css
    "font-size": "#{FontSize}px"

