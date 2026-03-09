# Contact Manager（コンタクトフォーム管理アプリ）

コンタクトフォームの送信を管理するためのモダンな Web アプリケーションです。Next.js と Supabase を活用し、フォーム送信と管理ダッシュボードを提供します。

## 目次

- [機能概要](#機能概要)
- [技術スタック](#技術スタック)
- [プロジェクト構成](#プロジェクト構成)
- [セットアップ](#セットアップ)
- [環境変数](#環境変数)
- [開発](#開発)
- [デプロイ](#デプロイ)
- [データベース](#データベース)
- [セキュリティ](#セキュリティ)

---

## 機能概要

### ホームページ (`/`)
- アプリの概要とナビゲーション
- コンタクトフォーム・管理ダッシュボードへのリンク
- レスポンシブでモダンな UI

### コンタクトフォーム (`/form`)
- **入力項目**
  - 名前（必須）
  - メールアドレス（必須）
  - 会社名（任意）
  - 電話番号（任意）
  - メッセージ（必須）
- バリデーション（必須項目チェック）
- 送信時のローディング表示
- 成功・エラー時のトースト通知
- Supabase へのリアルタイムデータ保存

### 管理ダッシュボード (`/admin`)
- **サマリーカード**
  - 総コンタクト数
  - 検索結果数
  - 現在のページ表示
- **検索機能**: 名前・メール・会社・電話・メッセージで全文検索
- **ソート機能**: 名前・メール・会社・日付で昇順/降順ソート
- **ページネーション**: 10 件ずつ表示
- **テーブル表示**: 全コンタクト情報の一覧

---

## 技術スタック

| カテゴリ | 技術 |
|---------|------|
| フレームワーク | Next.js 13.5 (App Router) |
| 言語 | TypeScript |
| UI | React 18, Tailwind CSS, shadcn/ui (Radix UI) |
| バックエンド | Supabase (PostgreSQL) |
| フォーム | React Hook Form, Zod（バリデーション用） |
| 通知 | Sonner (トースト) |
| デプロイ | Netlify |

---

## プロジェクト構成

```
demo_enter_form_web_app/
├── app/
│   ├── layout.tsx          # ルートレイアウト・メタデータ
│   ├── page.tsx            # ホームページ
│   ├── form/
│   │   └── page.tsx        # コンタクトフォーム
│   └── admin/
│       └── page.tsx        # 管理ダッシュボード
├── components/
│   └── ui/                 # shadcn/ui コンポーネント
├── lib/
│   ├── supabase.ts         # Supabase クライアント・型定義
│   └── utils.ts            # ユーティリティ
├── hooks/
│   └── use-toast.ts        # トーストフック
├── supabase/
│   └── migrations/         # DB マイグレーション
├── netlify.toml            # Netlify 設定
├── package.json
└── README.md
```

---

## セットアップ

### 前提条件

- Node.js 18.x 以上
- npm または yarn
- Supabase アカウント

### 1. リポジトリのクローン

```bash
git clone <repository-url>
cd demo_enter_form_web_app
```

### 2. 依存関係のインストール

```bash
npm install
```

### 3. 環境変数の設定

プロジェクトルートに `.env.local` を作成し、[環境変数](#環境変数) を設定します。

### 4. Supabase のセットアップ

1. [Supabase](https://supabase.com) でプロジェクトを作成
2. SQL Editor で `supabase/migrations/20260309201134_create_contacts_table.sql` の内容を実行
3. プロジェクト設定から URL と anon key を取得し、環境変数に設定

---

## 環境変数

| 変数名 | 説明 | 必須 |
|--------|------|------|
| `NEXT_PUBLIC_SUPABASE_URL` | Supabase プロジェクトの URL | ✅ |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Supabase の匿名（公開）キー | ✅ |

`.env.local` の例:

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

---

## 開発

### 開発サーバーの起動

```bash
npm run dev
```

ブラウザで [http://localhost:3000](http://localhost:3000) を開きます。

### 利用可能なスクリプト

| コマンド | 説明 |
|----------|------|
| `npm run dev` | 開発サーバー起動（ホットリロード） |
| `npm run build` | 本番用ビルド |
| `npm run start` | 本番サーバー起動 |
| `npm run lint` | ESLint 実行 |
| `npm run typecheck` | TypeScript 型チェック |

---

## デプロイ

### Netlify でのデプロイ

1. Netlify にリポジトリを接続
2. ビルド設定（`netlify.toml` により自動設定）:
   - Build command: `npx next build`
   - Publish directory: `.next`
3. 環境変数 `NEXT_PUBLIC_SUPABASE_URL` と `NEXT_PUBLIC_SUPABASE_ANON_KEY` を Netlify の環境変数に設定
4. デプロイを実行

---

## データベース

### `contacts` テーブル

| カラム | 型 | 説明 |
|--------|-----|------|
| `id` | uuid | 主キー（自動生成） |
| `name` | text | 名前（必須） |
| `email` | text | メールアドレス（必須） |
| `company` | text | 会社名（任意） |
| `phone` | text | 電話番号（任意） |
| `message` | text | メッセージ（必須） |
| `created_at` | timestamptz | 作成日時（自動） |

### マイグレーションの適用

Supabase ダッシュボードの SQL Editor で以下を実行:

```sql
-- supabase/migrations/20260309201134_create_contacts_table.sql の内容
```

---

## セキュリティ

- **Row Level Security (RLS)** が有効
- **匿名ユーザー**: コンタクトフォームの送信（INSERT）のみ許可
- **認証ユーザー**: 全コンタクトの閲覧（SELECT）が可能
- 管理ダッシュボードは現状認証なしでアクセス可能。本番環境では Supabase Auth 等で保護することを推奨します。

---

## ライセンス

このプロジェクトはデモ目的で作成されています。
