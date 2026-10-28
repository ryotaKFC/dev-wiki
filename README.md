# dev-wiki

<!-- 画像/gif: トップページから記事を検索し、記事本文と目次を表示する様子 -->

## Overview

Codexとの会話で学んだ内容を、後から単独で読み返せる記事として残す個人用Wikiです。

## Requirement

- Node.js 22.12.0以上、25未満（動作確認: 24.14.1）
- pnpm 10.34.5
- Astro
- Cloudflare Workers

## Usage

依存関係をインストールし、開発サーバーを起動します。

```sh
pnpm install
pnpm dev
```

品質チェックと本番ビルドは次のコマンドで実行します。

```sh
pnpm format:check
pnpm lint
pnpm check
pnpm build
```

Cloudflare Workersに接続済みの環境では、次のコマンドでローカルプレビューとデプロイを実行できます。

```sh
pnpm preview
pnpm deploy
```

## Features

- Astro Content CollectionsによるMarkdown記事とメタデータの型検証
- Feature-Sliced Designによるフロントエンドのレイヤー分割と公開API管理
- StyleXによる型安全なコンポーネントスタイルとデザイントークン
- `/articles/{slug}/` 形式の記事ページ生成
- 記事見出しからの目次生成
- 未検証記事への警告表示と `noindex` 設定
- Cloudflare Workers Static Assets向けのビルド・デプロイ構成
- OxlintとOxfmtによる高速なLint・フォーマット
- スマートフォンでも読める最小限のレスポンシブレイアウト

## Reference

- [要件定義](documents/要件定義.md)
- [Astro Documentation](https://docs.astro.build/)
- [Astro on Cloudflare Workers](https://developers.cloudflare.com/workers/framework-guides/web-apps/astro/)

## Author

- [ryotaKFC](https://github.com/ryotaKFC)

## Licence

ライセンスは未設定です。
