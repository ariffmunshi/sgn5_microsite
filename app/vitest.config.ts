/// <reference types="vitest" />
import { getViteConfig } from "astro/config";

export default getViteConfig({
  test: {
    /* for example, use global to avoid globals imports (describe, test, expect): */
    // globals: true,
	coverage: {
		all: true,
		include: ["src/**/*.js"],
		exclude: ["src/constants.js", "src/env.d.js", "src/data/**/*.js"],
		reporter: ["text", "lcov"],
	},
  },
});
