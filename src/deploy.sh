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

# 部署到 github.io
git push -f https://github.com/<USERNAME>/<REPO>.git master:gh-pages
# 範例：git push -f https://github.com/hsiangfeng/shopping-cart.git master:gh-pages

cd -