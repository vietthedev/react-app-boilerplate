module.exports = {
  root: true,
  env: { browser: true, es2020: true },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:react/jsx-runtime',
    'plugin:react-hooks/recommended',
    'plugin:@typescript-eslint/strict-type-checked',
    'plugin:@typescript-eslint/stylistic-type-checked',
    'prettier'
  ],
  ignorePatterns: [
    'dist',
    '.eslintrc.cjs',
    'postcss.config.js',
    'tailwind.config.js',
    'vite.config.ts',
    'vitest.setup.ts'
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
    project: ['./tsconfig.json', './tsconfig.node.json'],
    tsconfigRootDir: __dirname
  },
  plugins: ['react-refresh', 'simple-import-sort'],
  rules: {
    'react-refresh/only-export-components': [
      'warn',
      { allowConstantExport: true }
    ],
    'simple-import-sort/imports': 'error',
    'simple-import-sort/exports': 'error'
  },
  settings: {
    react: {
      version: 'detect'
    }
  }
}
