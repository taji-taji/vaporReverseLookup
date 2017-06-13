- updated:2017/06/13
- author: taji-taji

# MarkdownProviderを使う

## ● MarkdownProviderとは？

- [SwiftMarkdownパッケージ](https://github.com/vapor-community/markdown)のVaporProviderです
- MarkdownProviderでは、SwiftMarkdownをProviderとしてVaporプロジェクトで使用できるようにしてくれるパッケージです
- HTMLテンプレートエンジン`Leaf`にて、マークダウン文字列を展開してくれる`markdown`タグを使えるようになります

### → SwiftMarkdownパッケージ

- マークダウン文字列をHTML文字列に変換してくれるライブラリです
- 実装は[cmark](https://github.com/github/cmark)のSwiftラッパーです

## ● 使い方

### Package.swiftにパッケージを追加

```
dependencies: [
  ...,
  .Package(url: "https://github.com/vapor-community/markdown-provider", majorVersion: 1)
]
```

### Leafに`markdown`タグを追加する

#### ▼ Providerとして`Config`に追加する場合

以下のように設定することでLeafにて`markdown`タグが使えるようになります

<script src="https://gist.github.com/taji-taji/d32212cdab04f6096bc6100f6161f078.js"></script>

#### ▼ LeafRendererに直接追加する場合

`main.swift`などで、LeafRendererに直接登録することでも`markdown`タグが使えるようになります

<script src="https://gist.github.com/taji-taji/4a4f2e0179425a997e63bcf322b6f08d.js"></script>

### マークダウン文字列をHTML文字列に変換する

<script src="https://gist.github.com/taji-taji/8046b47f85522805f8243f034a7628ae.js"></script>

###  View(Leaf)にマークダウンを渡す
