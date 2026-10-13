# Stage 1: install dependencies and build the app
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: minimal runtime image
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

# Run as an unprivileged user, never root
RUN addgroup -S app && adduser -S app -G app

# The standalone bundle contains server.js and only the needed node_modules
COPY --from=builder /app/.next/standalone ./
# Static assets and public files are NOT in the standalone folder; copy them separately
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

USER app
EXPOSE 3000

CMD ["node", "server.js"]
