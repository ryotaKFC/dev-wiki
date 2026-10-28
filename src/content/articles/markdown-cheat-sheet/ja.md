---
title: Markdown チートシート
summary: 見出し、リスト、リンク、コードブロックなど、Markdownでよく使う記法をコピペできる例と一緒に確認します。
slug: markdown-cheat-sheet
createdAt: 2026-10-28
updatedAt: 2026-10-28
verifiedAt: 2026-10-28
verificationStatus: verified
targetVersion: CommonMark 0.31.2 / GFM 0.29-gfm
---

Markdownは、記号を使って文章の構造や装飾を表す記法です。README、GitHubのIssueやPull Request、技術ドキュメントなどで使われます。

この記事では、よく使う記法をコピペできる例と一緒にまとめます。基本はCommonMark 0.31.2、GitHub固有の機能はGitHub Flavored Markdown（GFM）0.29-gfmを基準にしています。［[1](#source-1)］［[2](#source-2)］

## 見出しを作る

行頭に付ける`#`の数で、見出しの階層を指定します。`#`の後ろには半角スペースを入れます。

```md
# 見出し1

## 見出し2

### 見出し3

#### 見出し4
```

通常、文書内の`# 見出し1`はタイトルにだけ使い、本文は`## 見出し2`以下で構成すると階層が分かりやすくなります。

## 文字を強調する

```md
**太字**

_斜体_

~~取り消し線~~

_**太字 + 斜体**_
```

表示結果は次のとおりです。

**太字**

_斜体_

~~取り消し線~~

**_太字 + 斜体_**

取り消し線はGFMの拡張記法です。［[2](#source-2)］

## リストを作る

### 箇条書き

`-`、`*`、`+`のいずれかを行頭に置きます。同じリストでは記号を統一すると読みやすくなります。

```md
- JavaScript
- TypeScript
- React
  - Next.js
  - React Router
```

- JavaScript
- TypeScript
- React
  - Next.js
  - React Router

### 番号付きリスト

```md
1. 要件定義
2. 設計
3. 実装
4. テスト
```

1. 要件定義
2. 設計
3. 実装
4. テスト

### チェックリスト

チェックリストはGFMの拡張記法です。`[x]`は完了、`[ ]`は未完了を表します。［[2](#source-2)］

```md
- [x] 環境構築
- [x] ログイン画面
- [ ] API実装
- [ ] テスト
```

- [x] 環境構築
- [x] ログイン画面
- [ ] API実装
- [ ] テスト

## リンクと画像を入れる

リンクは`[表示する文字](URL)`で作ります。

```md
[GitHub](https://github.com/)
```

[GitHub](https://github.com/)

画像はリンクの先頭に`!`を付けます。角括弧の中には、画像を見られない場合でも内容が伝わる代替テキストを書きます。

```md
![画像の説明](./image.png)
```

## 引用する

行頭に`>`を付けます。複数行の引用では、各行に`>`を付けます。

```md
> これは引用文です。
>
> 引用の中に複数の段落も書けます。
```

> これは引用文です。
>
> 引用の中に複数の段落も書けます。

## コードを書く

### 文中にコードを入れる

短いコードやファイル名は、バッククォート1つで囲みます。

```md
`useState`を使用します。
```

`useState`を使用します。

### コードブロックを作る

複数行のコードは、バッククォート3つで囲みます。開始側のバッククォートに言語名を続けると、対応した環境でシンタックスハイライトが適用されます。

````md
```ts
const message: string = "Hello World";

console.log(message);
```
````

表示結果は次のとおりです。

```ts
const message: string = "Hello World";

console.log(message);
```

よく使う言語名には、`js`、`ts`、`tsx`、`jsx`、`html`、`css`、`json`、`sh`、`sql`、`python`などがあります。

## 水平線を引く

ハイフンを3つ以上並べます。本文と区切るため、前後に空行を入れます。

```md
***
```

---

## テーブルを作る

テーブルはGFMの拡張記法です。1行目に列名、2行目にハイフンを記述します。［[2](#source-2)］

```md
| 名前       | 用途                |
| ---------- | ------------------- |
| React      | UIライブラリ        |
| Next.js    | Reactフレームワーク |
| TypeScript | 型付きJavaScript    |
```

| 名前       | 用途                |
| ---------- | ------------------- |
| React      | UIライブラリ        |
| Next.js    | Reactフレームワーク |
| TypeScript | 型付きJavaScript    |

コロンの位置で、列ごとの文字揃えを指定できます。

```md
| 左揃え | 中央揃え | 右揃え |
| :----- | :------: | -----: |
| A      |    B     |      C |
```

## 段落と改行を使い分ける

空行を1行入れると、段落が分かれます。

```md
1つ目の段落。

2つ目の段落。
```

同じ段落内で強制的に改行する場合は、行末に半角スペースを2つ入れるか、行末にバックスラッシュを置きます。［[1](#source-1)］

```md
1行目の末尾にバックスラッシュを置く。\
2行目。
```

エディターによっては行末のスペースを自動削除するため、意図が伝わりやすい段落分けを優先するのが安全です。

## Markdown記号をそのまま表示する

Markdownとして解釈される記号の前にバックスラッシュを置くと、記号を文字として表示できます。

```md
\# 見出しではありません

\*斜体になりません\*
```

## HTMLを直接書く

MarkdownではHTMLを直接書ける場合があります。［[1](#source-1)］

```html
<details>
  <summary>詳細を見る</summary>

  ここに詳細を書く
</details>
```

ただし、HTMLを許可する範囲やタグの扱いは環境によって異なります。表示先の仕様を確認して使います。

## GitHubで便利な記法を使う

GitHubでは、基本的なMarkdownに加えて、参照やメンションが使えます。［[3](#source-3)］

```md
#123

@username

a1b2c3d
```

- `#123`: 同じリポジトリのIssueまたはPull Requestを参照する
- `@username`: ユーザーをメンションする
- `a1b2c3d`: コミットを参照する

どれもGitHub上の文脈でリンクとして処理される記法です。ほかのMarkdown環境では、通常の文字列として表示される場合があります。

## よく使う記法をまとめてコピーする

````md
# タイトル

## 見出し

**太字**

_斜体_

~~取り消し線~~

- 箇条書き
- 箇条書き

1. 番号付き
2. リスト

- [x] 完了
- [ ] 未完了

[リンク](https://example.com/)

![画像の説明](./image.png)

> 引用

`インラインコード`

```ts
const hello = "Hello";
```

---

| 項目 | 内容 |
| ---- | ---- |
| A    | B    |
````

## 環境ごとの違いに注意する

Markdownには複数の実装があり、利用できる機能や細かな解釈が環境によって異なります。CommonMarkは曖昧さを減らすための仕様で、GFMはCommonMarkにテーブル、チェックリスト、取り消し線などを追加した拡張です。［[1](#source-1)］［[2](#source-2)］

特に次の記法は、表示先が対応しているか確認します。

- チェックリスト
- テーブル
- HTMLタグ
- 数式
- Mermaid
- 脚注
- GitHub固有の参照やメンション

GitHubで使うMarkdownなら、GFMとGitHub Docsを基準にすると迷いにくくなります。

## 出典

1. <span id="source-1"></span>[CommonMark Spec 0.31.2](https://spec.commonmark.org/0.31.2/)（2026年10月28日確認）
2. <span id="source-2"></span>[GitHub Flavored Markdown Spec 0.29-gfm](https://github.github.com/gfm/)（2026年10月28日確認）
3. <span id="source-3"></span>[基本的な書き込みと書式設定の構文 - GitHub Docs](https://docs.github.com/ja/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)（2026年10月28日確認）
