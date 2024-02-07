# production dockerfile
FROM --platform=linux/amd64 node:20.11.0

# Add init container - tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

WORKDIR /app

RUN npm i -g @nestjs/cli
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=yarn.lock,target=yarn.lock \
    --mount=type=cache,target=/root/.yarn \
    yarn install --production --frozen-lockfile

COPY --chown=node:node . .

ENV NODE_ENV=production

RUN yarn build

EXPOSE 3000

USER node

ENTRYPOINT ["/tini", "--"]
CMD ["node", "dist/main.js"]
