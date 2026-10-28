import stylex from "@stylexjs/unplugin";
import { defineConfig } from "astro/config";

export default defineConfig({
  output: "static",
  trailingSlash: "always",
  markdown: {
    shikiConfig: {
      theme: "github-light",
      wrap: false,
    },
  },
  vite: {
    plugins: [
      stylex.vite({
        dev: import.meta.env.DEV,
        runtimeInjection: false,
        useCSSLayers: true,
      }),
    ],
  },
});
