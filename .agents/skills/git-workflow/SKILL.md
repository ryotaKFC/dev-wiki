---
name: git-workflow
description: Follow this repository's branch, commit, and pull request conventions. Use before creating a branch, committing, or opening a pull request.
---

# Git workflow

Apply these rules whenever you create a branch, commit, or open a pull request.

## Before starting work

**[MUST] Pull `main` and create a new branch before editing any file**

- Reason: Branching from a stale or unrelated branch causes merge conflicts and mixes unrelated changes into one pull request.
- Scope: Every task that changes files, including configuration and documentation.
- Verification: Run `git checkout main && git pull origin main && git checkout -b <type>/<topic>` first; never commit directly to `main`.

## Branch names

**[MUST] Name branches `<type>/<kebab-case-topic>`**

- Reason: A type prefix makes the purpose of a branch clear and keeps branch lists scannable.
- Scope: All branches pushed to the remote.
- Verification: Use one of the prefixes below; the topic is short, lowercase, and hyphen-separated.

| Prefix      | Use for                                        |
| ----------- | ---------------------------------------------- |
| `feat/`     | New features or visible behavior additions     |
| `fix/`      | Bug fixes                                      |
| `style/`    | Visual or formatting-only changes (CSS, layout)|
| `refactor/` | Restructuring without behavior change          |
| `docs/`     | Documentation and articles                     |
| `ci/`       | CI/CD workflows                                |
| `chore/`    | Tooling, dependencies, agent/editor config     |

## Commit messages

**[MUST] Write commit messages in Japanese with a type prefix**

- Reason: The repository's history is read in Japanese; a consistent prefix makes it searchable.
- Scope: All commits.
- Verification: Format the subject as `<type>: <日本語の要約>` using the same types as branch prefixes. Explain why in the body when it is not obvious. Keep one logical change per commit.

## Pull requests

**[MUST] Write the pull request title and body in Japanese using the template**

- Reason: Reviewers need to know what was done, what was intentionally left out, and what is affected without reading the whole diff.
- Scope: Every pull request. The template lives at `.github/pull_request_template.md`.
- Verification: The body contains all of these sections:
  - **やったこと**: what changed.
  - **あえてやらないこと**: what was deliberately left out and why.
  - **影響範囲**: affected pages, modules, build, or CI.
  - **スクリーンショット / 動画**: required for UI changes (before/after when possible); write `なし（UI変更なし）` otherwise.
  - **確認方法**: commands run, such as `pnpm format:check`, `pnpm lint`, `pnpm check`, `pnpm build`.

**[SHOULD] Keep pull requests small and focused on one purpose**

- Reason: Small pull requests are reviewed faster and are easier to revert.
- Scope: All pull requests.
- Verification: Split unrelated changes into separate branches.
