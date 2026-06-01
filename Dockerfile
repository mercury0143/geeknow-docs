ARG NODE_IMAGE=node:24.13.0-bookworm-slim
FROM ${NODE_IMAGE}

WORKDIR /app

ENV NODE_ENV=development
ENV NPM_CONFIG_UPDATE_NOTIFIER=false
ENV HOME=/mintlify-home

COPY package*.json ./
ARG NPM_REGISTRY
RUN if [ -n "$NPM_REGISTRY" ]; then npm config set registry "$NPM_REGISTRY"; fi \
    && npm ci

EXPOSE 3000

CMD ["sh", "-c", "npx mintlify dev --no-open --port ${MINTLIFY_INTERNAL_PORT:-3000}"]
