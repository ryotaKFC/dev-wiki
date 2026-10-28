---
name: implementation
description: Implement or modify code in this repository while applying its confirmed project-specific development rules.
---

# Implement repository changes

Inspect nearby implementations and repository configuration before editing.
Keep changes scoped and verify the behavior affected by the change.

## Learned rules

**[MUST] Author application styles with StyleX**

- Reason: StyleX is the repository-standard styling system and produces typed, colocated atomic CSS through the Vite build.
- Finding: 2026-10-28, user correction: use StyleX for CSS.
- Scope: Frontend application and component styling; keep plain CSS limited to the StyleX CSS entrypoint required by the compiler.
- Verification: Use `*.stylex.ts` modules and confirm the production build emits StyleX-generated CSS without the former global stylesheet.

**[MUST] Organize frontend modules with Feature-Sliced Design**

- Reason: Layer boundaries and slice public APIs prevent route files and UI modules from coupling to internal implementations.
- Finding: 2026-10-28, user correction: introduce FSD in the frontend directory.
- Scope: Modules under `src/frontend`; keep Astro's required `src/pages` files as thin routing adapters.
- Verification: Organize modules under `app`, `pages`, `widgets`, `entities`, and `shared`; import slices and shared segments through public `index.ts` entry points, except direct `*.stylex.ts` theme imports required by the StyleX compiler.

**[MUST] Use pnpm for dependency management and OXC for linting and formatting**

- Reason: The repository standard is pnpm with Oxlint and Oxfmt; mixing npm or Prettier creates conflicting lockfiles and tooling behavior.
- Finding: 2026-10-28, user correction: use pnpm as the package manager and OXC for linting and formatting.
- Scope: Root dependency commands, lockfiles, package scripts, CI, and editor/tooling configuration.
- Verification: Keep only `pnpm-lock.yaml`, set the `packageManager` field to pnpm, and run `pnpm lint` plus `pnpm format:check`.

**[MUST] Keep TypeScript within the peer dependency range supported by `@astrojs/check`**

- Reason: Installing the newest TypeScript release can make the dependency tree unresolvable and prevent environment setup.
- Finding: 2026-10-28, resolved configuration failure: `@astrojs/check@0.9.12` accepts TypeScript 5 or 6, while `typescript@latest` resolved to 7.0.2.
- Scope: Changes to the root JavaScript and Astro development dependencies.
- Verification: Run `pnpm install --frozen-lockfile` without peer dependency overrides and confirm `pnpm check` succeeds.

**[MUST] Exclude the repository-managed `.agents` directory from formatting commands**

- Reason: Some managed skill files are read-only, so formatting the entire repository fails with `EPERM` before application checks can run.
- Finding: 2026-10-28, resolved configuration failure: a root-level formatter attempted to rewrite read-only files under `.agents/skills`.
- Scope: Root-level formatter and bulk file-processing configuration.
- Verification: Keep `.agents/**` and `AGENTS.md` in Oxfmt's `ignorePatterns` and confirm `pnpm format` exits successfully.

**[MUST] Link the StyleX dev stylesheet from the base layout in development**

- Reason: In `astro dev` the StyleX entry CSS stays `@layer stylex;` only, so every StyleX style is silently missing even though `pnpm build` output is correct.
- Finding: 2026-10-28, user feedback: the home page CSS appeared not to apply; `/src/frontend/app/styles/stylex-entry.css` served no rules in dev, while `/virtual:stylex.css` held them.
- Scope: `src/frontend/app/layouts/base-layout.astro` and any other document shell.
- Verification: Keep the `import.meta.env.DEV` link to `/virtual:stylex.css`, confirm it returns the rules under `pnpm dev`, and confirm `dist/index.html` has no `virtual:stylex` reference after `pnpm build`.

Add confirmed project-specific implementation rules here. Use the following
form:

```md
**[SHOULD] Follow a concrete implementation practice**

- Reason: Explain the defect, inconsistency, or maintenance cost this prevents.
- Finding: YYYY-MM-DD, user feedback: summarize what was pointed out.
- Scope: State where the practice applies.
- Verification: Explain how to verify the implementation follows it.
```
