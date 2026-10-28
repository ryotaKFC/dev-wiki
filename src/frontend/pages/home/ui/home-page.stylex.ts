import * as stylex from "@stylexjs/stylex";

import { colors } from "../../../shared/config/theme/theme.stylex";

export const styles = stylex.create({
  heading: { maxWidth: "48rem" },
  title: {
    fontSize: "clamp(2rem, 5vw, 3rem)",
    lineHeight: 1.3,
  },
  sectionHeading: {
    borderBottomColor: colors.borderSubtle,
    borderBottomStyle: "solid",
    borderBottomWidth: 1,
    lineHeight: 1.3,
    marginTop: "2.5rem",
    paddingBottom: "0.35rem",
  },
  emptyState: { color: colors.mutedText },
  articleList: {
    listStyle: "none",
    margin: 0,
    padding: 0,
  },
  articleItem: {
    borderBottomColor: colors.borderSubtle,
    borderBottomStyle: "solid",
    borderBottomWidth: 1,
    paddingBlock: "1.25rem",
  },
  articleLink: {
    color: colors.text,
    fontSize: "1.125rem",
    fontWeight: 700,
    textDecorationThickness: {
      default: "0.08em",
      ":hover": "0.14em",
    },
    textUnderlineOffset: "0.18em",
  },
  summary: { marginBlock: "0.35rem" },
  updatedAt: {
    color: colors.mutedText,
    fontSize: "0.875rem",
  },
});
