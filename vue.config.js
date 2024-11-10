const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  publicPath: process.env.NODE_ENV === 'production' ? '/ai/' : '/',
  chainWebpack: config => {
    config.plugin('html')
      .tap(args => {
        args[0].title = 'ai'  // 您的網站標題
        return args
      })
  }
})