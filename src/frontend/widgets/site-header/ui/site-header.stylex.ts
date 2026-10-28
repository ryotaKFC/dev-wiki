import * as stylex from "@stylexjs/stylex";

import { colors } from "../../../shared/config/theme/theme.stylex";

export const styles = stylex.create({
  root: {
    borderBottomColor: colors.border,
    borderBottomStyle: "solid",
    borderBottomWidth: 1,
    paddingBlock: "0.75rem",
    paddingInline: "max(1.25rem, calc((100% - 72rem) / 2))",
  },
  title: {
    color: colors.text,
    fontWeight: 700,
    outline: {
      default: "none",
      ":focus-visible": `3px solid ${colors.focus}`,
    },
    outlineOffset: 3,
    textDecoration: "none",
  },
});
