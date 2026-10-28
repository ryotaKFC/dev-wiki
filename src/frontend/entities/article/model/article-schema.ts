import { z } from "astro/zod";

export const articleSchema = z.object({
  title: z.string().min(1),
  summary: z.string().min(1),
  slug: z.string().regex(/^[a-z0-9]+(?:-[a-z0-9]+)*$/),
  createdAt: z.coerce.date(),
  updatedAt: z.coerce.date(),
  verifiedAt: z.coerce.date().nullable(),
  verificationStatus: z.enum(["verified", "unverified"]),
  targetVersion: z.string().min(1).optional(),
});
