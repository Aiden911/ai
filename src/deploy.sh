#!/usr/bin/env sh

# 當發生錯誤時終止腳本運行
set -e

# 打包
npm run build

# 移動至到打包後的dist目錄 
cd dist

# 因為dist資料夾預設是被ignore的，因此在進入dist資料夾後初始化git
git init 
git add -A
git commit -m 'deploy'

# 部署到 github pages
git push -f https://github.com/aiden911/ai.git master:gh-pages
# 例如：git push -f https://github.com/Appy/ai.git master:gh-pages

cd -