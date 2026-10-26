#!/bin/sh
# 把 index.html（頁面內容）包成完整網頁，輸出到 docs/ 給 GitHub Pages 使用
cd "$(dirname "$0")"
DESC="上傳照片，自動偵測直線並產生水平、垂直、完整三種拉直結果，可再微調後存回手機。"
mkdir -p docs
# 圖示網址加上版本號，換圖後手機才會重新抓
IV=$(md5 -q assets/apple-touch-icon.png | cut -c1-8)
{
  printf '<!doctype html>\n<html lang="zh-Hant">\n<head>\n<meta charset="utf-8">\n'
  printf '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
  printf '<meta name="description" content="%s">\n' "$DESC"
  printf '<meta name="theme-color" content="#1F5BD8">\n'
  # 加到主畫面後以全螢幕 App 的樣子開啟
  printf '<meta name="apple-mobile-web-app-capable" content="yes">\n'
  printf '<meta name="mobile-web-app-capable" content="yes">\n'
  printf '<meta name="apple-mobile-web-app-title" content="我最正直">\n'
  printf '<meta name="apple-mobile-web-app-status-bar-style" content="default">\n'
  printf '<link rel="icon" type="image/png" sizes="180x180" href="apple-touch-icon.png?v=%s">\n' "$IV"
  printf '<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png?v=%s">\n' "$IV"
  # Claude Artifact 發佈時會自動加上的基本樣式，獨立網頁要自己補
  printf '<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
  printf '</head>\n<body>\n'
  cat index.html
  printf '\n</body>\n</html>\n'
} > docs/index.html
cp assets/apple-touch-icon.png assets/sample.jpg docs/
