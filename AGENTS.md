# Repository instructions

## Git workflow

Before creating a branch, committing, or opening a pull request, read and
follow `.agents/skills/git-workflow/SKILL.md`. In short:

- Pull `main` and create a new branch before editing any file.
- Name branches `<type>/<topic>` (`feat/`, `fix/`, `style/`, `refactor/`,
  `docs/`, `ci/`, `chore/`).
- Write commit messages and pull requests in Japanese.
- Fill in every section of `.github/pull_request_template.md`: what was done,
  what was deliberately not done, affected scope, and screenshots or video
  for UI changes.

## Project learning

When a user correction, review finding, failed task, or resolved configuration
problem reveals reusable project-specific guidance, read and follow
`.agents/skills/capture-learning/SKILL.md` before completing the task.

## Article pull requests

When creating a new article and opening its pull request, read and follow
`.agents/skills/article-pr/SKILL.md`. Use its helper script so the workflow can
run from any session without changing the branch or files in the caller's
current worktree.
