import { defineCollection, z } from "astro:content";
import { file } from "astro/loaders";

const iconsArticles = defineCollection({
	loader: file("src/data/iconsArticles.json", { parser: (text) => JSON.parse(text) }),
	schema: z.object({
		images: z.object({
			topImage: z.object({
				src: z.string(),
				alt: z.string(),
			}),
			bottomImage: z.object({
				src: z.string(),
				alt: z.string(),
			}),
		}),
		content: z.object({
			header: z.object({
				tags: z.array(z.string()),
				title: z.string(),
				subtext: z.string(),
				author: z.string(),
				postDate: z.string(),
			}),
			introduction: z.array(z.string()),
			body: z.array(
				z.object({
					title: z.string(),
					paragraphs: z.array(z.string()),
				})
			),
			conclusion: z.object({
				title: z.string(),
				paragraphs: z.array(z.string()),
			}),
		}),
	}),
});

export const collections = {
	iconsArticles: iconsArticles,
};
