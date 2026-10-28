---
name: article-pr
description: Create a new dev-wiki article and publish it through a dedicated branch, commit, push, and GitHub pull request. Use for end-to-end new-article PR requests; do not use for silently updating, merging, or deleting an existing article.
---

# Create a dev-wiki article pull request

Create a complete Japanese article, then use the bundled publisher to perform
the Git and GitHub workflow without modifying the caller's current worktree.

## Before drafting

1. Inspect `src/content/articles` for the same or a substantially similar
   topic. If one exists, stop before editing and show the proposed update and
   affected sections for user approval.
2. Read `src/frontend/entities/article/model/article-schema.ts` and a recent
   article before relying on their shape. Treat the repository as the source
   of truth when it differs from this skill.
3. Confirm the intended topic and scope from the request. Ask only when a
   missing choice would materially change the article.

## Article requirements

- Write the Japanese source as `ja.md`; the publisher places it at
  `src/content/articles/<slug>/ja.md`.
- Use a lowercase kebab-case slug. The folder and frontmatter `slug` must
  match.
- Include `title`, `summary`, `slug`, `createdAt`, `updatedAt`, `verifiedAt`,
  and `verificationStatus`. Include `targetVersion` when the subject has a
  meaningful version.
- Use `verified` only after checking important claims against reliable
  sources. Otherwise use `unverified` and set `verifiedAt: null`.
- Prefer official specifications and documentation. Add numbered inline
  source references for important technical, numerical, or version-dependent
  claims and a matching `## 出典` section.
- Keep the page title in frontmatter. Start body headings at `##`.
- Add diagrams or screenshots only when they materially improve
  understanding. Give images useful alternative text.

Draft the file outside the repository, such as in a task-specific temporary
directory. This prevents an unfinished article from entering the caller's
worktree.

## Publish

Run `scripts/publish-article.sh` from this skill directory. The script resolves
the dev-wiki repository from its own location, so the caller's current
directory does not matter.

First run the real validation path without external writes:

```sh
scripts/publish-article.sh \
  --source /absolute/path/to/ja.md \
  --slug example-topic \
  --title '記事タイトル' \
  --dry-run
```

Review the generated diff and validation result. Then run the same command
without `--dry-run` only when the user has authorized branch creation, commit,
push, and pull request creation:

```sh
scripts/publish-article.sh \
  --source /absolute/path/to/ja.md \
  --asset /absolute/path/to/image.png \
  --slug example-topic \
  --title '記事タイトル'
```

The live command creates `docs/<slug>` from the latest `origin/main`, uses the
Japanese commit and pull request title `docs: <title>の記事を追加`, fills every
pull request template section, and runs the repository's install, formatter,
lint, type, and build checks. Repeat `--asset` for images that belong beside
`ja.md`; omit it when the article has no assets. Override the branch or
messages only when the request requires it; see `--help` for supported options.

If authentication, push, checks, or pull request creation fails, report the
exact completed stage and stop. Do not retry a push or create a second pull
request blindly. Do not merge or enable auto-merge unless the user separately
requests it.
