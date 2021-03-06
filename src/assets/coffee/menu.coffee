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
        label: '新規作成'
        accelerator: 'Command+N'
        click: () ->
          createEditor()
      }
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
      {
        label: '閉じる'
        accelerator: 'Command+W'
        click: () ->
          closeFile()
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
        label: '切り取り'
        accelerator: 'Command+X'
        click: () ->
          cut()
      }
      {
        label: 'コピー'
        accelerator: 'Command+C'
        click: () ->
          copy()
      }
      {
        label: '貼り付け'
        accelerator: 'Command+V'
        click: () ->
          paste()
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
      {
        label: '次のタブ'
        accelerator: 'Command+]'
        click: () ->
          nextTab()
      }
      {
        label: '前のタブ'
        accelerator: 'Command+['
        click: () ->
          prevTab()
      }
      {
        label: 'マークダウンに変換'
        accelerator: 'Command+M'
        click: () ->
          convertAmd2Md()
      }
      {
        label: 'マークダウンに変換'
        accelerator: 'Command+Shift+M'
        click: () ->
          convertMd2Amd()
      }
      {
        label: 'フローチャートに変換'
        accelerator: 'Command+Shift+T'
        click: () ->
          convertAmd2Tree()
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
