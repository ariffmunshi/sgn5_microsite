// @ts-check
import { defineConfig } from 'astro/config';
import lottie from "astro-integration-lottie";
// https://astro.build/config
export default defineConfig({
  site: 'https://example.com',
  integrations: [
    lottie(),
  ],
  vite: { // Add this vite configuration block for wsl2 support
    server: {
      watch: {
        usePolling: true, // This enables polling for file changes
      },
      fs: {
        allow: ['..'], // Allow serving files from parent directory (includes node_modules)
      },
    },
  },
});
