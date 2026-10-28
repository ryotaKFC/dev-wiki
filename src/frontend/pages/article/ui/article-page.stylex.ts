import * as stylex from "@stylexjs/stylex";

import { colors } from "../../../shared/config/theme/theme.stylex";

export const styles = stylex.create({
  root: { maxWidth: "48rem" },
  title: { fontSize: "clamp(2rem, 5vw, 3rem)", lineHeight: 1.3 },
  metadata: {
    color: colors.mutedText,
    display: { default: "flex", "@media (max-width: 40rem)": "grid" },
    flexWrap: "wrap",
    fontSize: "0.875rem",
    gap: "0.5rem 1.5rem",
  },
  metadataRow: { display: "flex", gap: "0.5rem" },
  metadataValue: { margin: 0 },
  warning: {
    backgroundColor: colors.warningBackground,
    borderLeftColor: colors.warningAccent,
    borderLeftStyle: "solid",
    borderLeftWidth: 4,
    padding: "0.75rem 1rem",
  },
  tableOfContents: {
    borderBlockColor: colors.borderSubtle,
    borderBlockStyle: "solid",
    borderBlockWidth: 1,
    marginBlock: "2rem",
    paddingBlock: "1rem",
  },
  tableOfContentsHeading: { fontSize: "1rem", lineHeight: 1.3, margin: 0 },
  tableOfContentsList: { marginBottom: 0 },
  nestedItem: { marginLeft: "1.25rem" },
  link: {
    color: colors.text,
    textDecorationThickness: "0.08em",
    textUnderlineOffset: "0.18em",
  },
  body: { maxWidth: "48rem" },
});
