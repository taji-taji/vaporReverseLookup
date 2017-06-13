- updated:2017/06/12
- author: taji-taji

# Vaporプロジェクトの作成

Vaporプロジェクトを作成するには、`vapor new`コマンドを使用します。  

```
vapor new <Your Project Name>
```

プロジェクトを作成すると、次のようなAAが表示されるので、作成されたプロジェクトディレクトリに移動して開発を始めましょう。
aa

![new project](/images/contents/01_03_001.png)

## ● テンプレートの指定

`--template`オプションを指定することで、テンプレートを含んだ状態でプロジェクトを作ることができます。  

<table>
  <thead>
    <tr>
      <th>指定方法</th>
      <th>説明</th>
      <th>使用されるリポジトリ</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>--template=api</td>
      <td>JSONベースのAPIを作成するテンプレートです</td>
      <td>https://github.com/vapor/api-template</td>
    </tr>
    <tr>
      <td>--template=web</td>
      <td>HTMLテンプレートエンジンLeafを用いたWebサイト作成用のテンプレートです</td>
      <td>https://github.com/vapor/web-template</td>
    </tr>
    <tr>
      <td>--template=user/repo</td>
      <td>Githubのリポジトリに上がっているテンプレートを指定します</td>
      <td>http://github.com/user/repo</td>
    </tr>
    <tr>
      <td>--template=http://example.com/repo-path</td>
      <td>テンプレートとして使用するリポジトリのフルパスを指定します</td>
      <td>http://example.com/repo-path</td>
    </tr>
  </tbody>
</taåble>
