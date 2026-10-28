import * as stylex from "@stylexjs/stylex";

import { colors, typography } from "../../shared/config/theme/theme.stylex";

export const styles = stylex.create({
  document: {
    backgroundColor: colors.background,
    color: colors.text,
    fontFamily: typography.body,
    fontSynthesis: "none",
  },
  body: {
    lineHeight: 1.75,
    margin: 0,
  },
  main: {
    marginInline: "auto",
    paddingBlock: {
      default: "3rem 5rem",
      "@media (max-width: 40rem)": "2rem 4rem",
    },
    width: {
      default: "min(100% - 2.5rem, 72rem)",
      "@media (max-width: 40rem)": "min(100% - 2rem, 72rem)",
    },
  },
});
