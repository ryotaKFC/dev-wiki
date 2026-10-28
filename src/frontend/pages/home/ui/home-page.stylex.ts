import * as stylex from "@stylexjs/stylex";

import { colors } from "../../../shared/config/theme/theme.stylex";

const narrow = "@media (max-width: 40rem)";

export const styles = stylex.create({
  hero: {
    backgroundColor: colors.surface,
    borderColor: colors.borderSubtle,
    borderRadius: "0.75rem",
    borderStyle: "solid",
    borderWidth: 1,
    paddingBlock: {
      default: "2.5rem",
      [narrow]: "1.75rem",
    },
    paddingInline: {
      default: "2rem",
      [narrow]: "1.25rem",
    },
  },
  title: {
    fontSize: "clamp(2rem, 5vw, 3rem)",
    lineHeight: 1.3,
    marginBlock: "0 0.5rem",
  },
  lead: {
    color: colors.mutedText,
    marginBlock: 0,
    maxWidth: "40rem",
  },
  stats: {
    display: "flex",
    flexWrap: "wrap",
    gap: "0.5rem 1.5rem",
    listStyle: "none",
    margin: 0,
    marginTop: "1.25rem",
    padding: 0,
  },
  statValue: {
    fontSize: "1.25rem",
    fontWeight: 700,
    marginInlineEnd: "0.35rem",
  },
  statLabel: {
    color: colors.mutedText,
    fontSize: "0.875rem",
  },
  sectionHeading: {
    fontSize: "1.25rem",
    lineHeight: 1.3,
    marginBlock: "2.5rem 1rem",
  },
  emptyState: {
    borderColor: colors.border,
    borderRadius: "0.75rem",
    borderStyle: "dashed",
    borderWidth: 1,
    color: colors.mutedText,
    marginBlock: 0,
    padding: "2rem",
    textAlign: "center",
  },
  articleList: {
    display: "grid",
    gap: "1rem",
    gridTemplateColumns: "repeat(auto-fill, minmax(min(100%, 20rem), 1fr))",
    listStyle: "none",
    margin: 0,
    padding: 0,
  },
  articleItem: {
    backgroundColor: colors.background,
    borderColor: {
      default: colors.borderSubtle,
      ":hover": colors.accent,
      ":focus-within": colors.accent,
    },
    borderRadius: "0.75rem",
    borderStyle: "solid",
    borderWidth: 1,
    display: "flex",
    flexDirection: "column",
    gap: "0.35rem",
    padding: "1.25rem",
  },
  articleLink: {
    color: colors.text,
    fontSize: "1.125rem",
    fontWeight: 700,
    outline: {
      default: "none",
      ":focus-visible": `3px solid ${colors.focus}`,
    },
    outlineOffset: 3,
    textDecoration: {
      default: "none",
      ":hover": "underline",
    },
    textUnderlineOffset: "0.18em",
  },
  summary: {
    color: colors.mutedText,
    flexGrow: 1,
    marginBlock: 0,
  },
  updatedAt: {
    color: colors.mutedText,
    fontSize: "0.875rem",
  },
});
