module.exports = {
  root: true,
  env: {
    node: true,    // 添加 node 環境
    browser: true  // 添加瀏覽器環境
  },
  extends: [
    'plugin:vue/vue3-essential',
    'eslint:recommended',
    '@vue/prettier'
  ],
  rules: {
    'prettier/prettier': 'off',
    'vue/multi-word-component-names': 'off'
  }
}