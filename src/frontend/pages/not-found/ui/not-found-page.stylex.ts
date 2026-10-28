import * as stylex from "@stylexjs/stylex";

import { colors } from "../../../shared/config/theme/theme.stylex";

export const styles = stylex.create({
  root: { maxWidth: "48rem" },
  title: {
    fontSize: "clamp(2rem, 5vw, 3rem)",
    lineHeight: 1.3,
  },
  link: {
    color: colors.text,
    textDecorationThickness: "0.08em",
    textUnderlineOffset: "0.18em",
  },
});
