#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  publish-article.sh --source FILE --slug SLUG --title TITLE [options]

Required:
  --source FILE          Completed Japanese Markdown article.
  --slug SLUG            Lowercase kebab-case article slug.
  --title TITLE          Article title used in the default commit and PR title.

Options:
  --asset FILE           Copy an asset beside ja.md. May be repeated.
  --branch BRANCH        Branch name (default: docs/SLUG).
  --commit-message TEXT  Japanese commit subject.
  --pr-title TEXT        Japanese pull request title.
  --dry-run              Validate in an isolated worktree without commit, push,
                         or pull request creation.
  -h, --help             Show this help.
EOF
}

fail() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || fail "Required command not found: $1"
}

source_file=""
slug=""
title=""
branch=""
commit_message=""
pr_title=""
dry_run=false
assets=()

while (($# > 0)); do
  case "$1" in
    --source)
      (($# >= 2)) || fail "--source requires a value"
      source_file=$2
      shift 2
      ;;
    --slug)
      (($# >= 2)) || fail "--slug requires a value"
      slug=$2
      shift 2
      ;;
    --title)
      (($# >= 2)) || fail "--title requires a value"
      title=$2
      shift 2
      ;;
    --asset)
      (($# >= 2)) || fail "--asset requires a value"
      assets+=("$2")
      shift 2
      ;;
    --branch)
      (($# >= 2)) || fail "--branch requires a value"
      branch=$2
      shift 2
      ;;
    --commit-message)
      (($# >= 2)) || fail "--commit-message requires a value"
      commit_message=$2
      shift 2
      ;;
    --pr-title)
      (($# >= 2)) || fail "--pr-title requires a value"
      pr_title=$2
      shift 2
      ;;
    --dry-run)
      dry_run=true
      shift
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      fail "Unknown option: $1"
      ;;
  esac
done

[[ -n "$source_file" ]] || fail "--source is required"
[[ -n "$slug" ]] || fail "--slug is required"
[[ -n "$title" ]] || fail "--title is required"
[[ -f "$source_file" ]] || fail "Source file does not exist: $source_file"
[[ "$source_file" = /* ]] || fail "--source must be an absolute path"
[[ "$slug" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || fail "Slug must be lowercase kebab-case"

asset_names=()
set +u
for asset in "${assets[@]}"; do
  [[ -f "$asset" ]] || fail "Asset file does not exist: $asset"
  [[ "$asset" = /* ]] || fail "--asset must be an absolute path: $asset"

  asset_name=$(basename -- "$asset")
  [[ "$asset_name" != "ja.md" ]] || fail "Asset cannot be named ja.md"
  for existing_name in "${asset_names[@]}"; do
    [[ "$asset_name" != "$existing_name" ]] || fail "Duplicate asset filename: $asset_name"
  done
  asset_names+=("$asset_name")
done
set -u

branch=${branch:-"docs/$slug"}
commit_message=${commit_message:-"docs: ${title}の記事を追加"}
pr_title=${pr_title:-"docs: ${title}の記事を追加"}

[[ "$branch" =~ ^(feat|fix|style|refactor|docs|ci|chore)/[a-z0-9]+(-[a-z0-9]+)*$ ]] ||
  fail "Branch must match <type>/<kebab-case-topic>"
[[ "$commit_message" =~ ^(feat|fix|style|refactor|docs|ci|chore):[[:space:]].+ ]] ||
  fail "Commit message must start with an allowed type prefix"

require_command git
require_command pnpm
if [[ "$dry_run" == false ]]; then
  require_command gh
fi

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
repo_root=$(git -C "$script_dir" rev-parse --show-toplevel)
expected_remote='ryotaKFC/dev-wiki'
origin_url=$(git -C "$repo_root" remote get-url origin)

case "$origin_url" in
  git@github.com:ryotaKFC/dev-wiki.git | https://github.com/ryotaKFC/dev-wiki | https://github.com/ryotaKFC/dev-wiki.git)
    ;;
  *)
    fail "Unexpected origin remote: $origin_url (expected $expected_remote)"
    ;;
esac

if ! grep -Eq '^---[[:space:]]*$' "$source_file"; then
  fail "Source must contain YAML frontmatter"
fi

for field in title summary slug createdAt updatedAt verifiedAt verificationStatus; do
  grep -Eq "^${field}:" "$source_file" || fail "Missing frontmatter field: $field"
done

frontmatter_slug=$(sed -n 's/^slug:[[:space:]]*["'"'"']\{0,1\}\([^"'"'"']*\)["'"'"']\{0,1\}[[:space:]]*$/\1/p' "$source_file" | head -n 1)
[[ "$frontmatter_slug" == "$slug" ]] ||
  fail "Frontmatter slug '$frontmatter_slug' does not match --slug '$slug'"

if [[ "$dry_run" == false ]]; then
  gh auth status --hostname github.com >/dev/null
fi

printf 'Fetching latest origin/main...\n'
git -C "$repo_root" fetch origin main

article_dir="src/content/articles/$slug"
article_path="$article_dir/ja.md"
if git -C "$repo_root" cat-file -e "origin/main:$article_path" 2>/dev/null; then
  fail "Article already exists on origin/main: $article_path"
fi

if git -C "$repo_root" show-ref --verify --quiet "refs/heads/$branch"; then
  fail "Local branch already exists: $branch"
fi
if git -C "$repo_root" show-ref --verify --quiet "refs/remotes/origin/$branch"; then
  fail "Remote branch already exists: $branch"
fi

worktree_dir=$(mktemp -d "${TMPDIR:-/tmp}/dev-wiki-article.XXXXXX")
worktree_registered=false

cleanup() {
  if [[ "$worktree_registered" == true ]]; then
    git -C "$repo_root" worktree remove --force "$worktree_dir" >/dev/null 2>&1 || true
  else
    rmdir "$worktree_dir" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

if [[ "$dry_run" == true ]]; then
  git -C "$repo_root" worktree add --detach "$worktree_dir" origin/main
else
  git -C "$repo_root" worktree add -b "$branch" "$worktree_dir" origin/main
fi
worktree_registered=true

mkdir -p "$worktree_dir/src/content/articles/$slug"
cp "$source_file" "$worktree_dir/$article_path"
set +u
for index in "${!assets[@]}"; do
  cp "${assets[$index]}" "$worktree_dir/$article_dir/${asset_names[$index]}"
done
set -u
git -C "$worktree_dir" add --intent-to-add -- "$article_dir"

printf 'Installing dependencies and running repository checks...\n'
pnpm --dir "$worktree_dir" install --frozen-lockfile
pnpm --dir "$worktree_dir" format:check
pnpm --dir "$worktree_dir" lint
pnpm --dir "$worktree_dir" check
pnpm --dir "$worktree_dir" build
git -C "$worktree_dir" diff --check

printf '\nValidated diff:\n'
git -C "$worktree_dir" diff --stat
git -C "$worktree_dir" diff -- "$article_dir"

if [[ "$dry_run" == true ]]; then
  printf '\nDry run complete. No branch, commit, push, or pull request was created.\n'
  exit 0
fi

git -C "$worktree_dir" add -- "$article_dir"
git -C "$worktree_dir" commit -m "$commit_message"
git -C "$worktree_dir" push --set-upstream origin "$branch"

pr_body=$(mktemp "${TMPDIR:-/tmp}/dev-wiki-pr-body.XXXXXX")
trap 'rm -f "$pr_body"; cleanup' EXIT
cat >"$pr_body" <<EOF
## やったこと

- 「${title}」の記事を追加
- 記事のメタデータと出典を追加

## あえてやらないこと

- 既存記事の変更（新規記事の追加に限定）

## 影響範囲

- ${article_path}
- 記事一覧と /articles/${slug}/ の生成結果

## スクリーンショット / 動画

なし（UI変更なし）

## 確認方法

- [x] \`pnpm format:check\`
- [x] \`pnpm lint\`
- [x] \`pnpm check\`
- [x] \`pnpm build\`
EOF

pr_url=$(gh pr create \
  --repo "$expected_remote" \
  --base main \
  --head "$branch" \
  --title "$pr_title" \
  --body-file "$pr_body")

printf '\nPull request created: %s\n' "$pr_url"
