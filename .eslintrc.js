module.exports = {
  root: true,
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