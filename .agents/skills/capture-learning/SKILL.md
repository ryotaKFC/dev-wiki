---
name: capture-learning
description: Maintain repository skills after a confirmed correction, review finding, or resolved project-specific problem reveals reusable guidance.
---

# Capture project learning

Record reusable project-specific learning in the skill that can prevent the
same problem at the earliest stage.

## What to record

- Record confirmed rules that affect future decisions in this repository.
- Use `[MUST]` for correctness, security, explicit requirements, and other
  rules that may not be violated.
- Use `[SHOULD]` for expected practices that may be skipped only for a concrete
  reason.
- Do not record nits, one-off mistakes, raw conversation logs, or speculation.

## Where to record it

- Put implementation guidance in `../implementation/SKILL.md`.
- Put review-only checks in `../code-review/SKILL.md`.
- Prefer updating an existing rule over adding a duplicate.
- Create another narrowly scoped skill only after a distinct recurring
  workflow appears.

## Entry format

Add each rule under the target skill's `## Learned rules` heading.

```md
**[MUST] State the rule as a concrete action or prohibition**

- Reason: Explain the concrete failure or risk this prevents.
- Finding: Record the date, source, and substance of the confirmed correction.
- Scope: State where the rule applies.
- Verification: State how Codex can verify compliance.
```

Keep entries concise. Preserve the substance of the finding without copying a
full review comment or conversation.

