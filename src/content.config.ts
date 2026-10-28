import { defineCollection } from "astro:content";
import { glob } from "astro/loaders";

import { articleSchema } from "@entities/article";

const articles = defineCollection({
  loader: glob({
    base: "./src/content/articles",
    pattern: "**/ja.md",
  }),
  schema: articleSchema,
});

export const collections = { articles };
