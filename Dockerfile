# production dockerfile
FROM --platform=linux/amd64 node:20.11.0

# Add init container - tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

WORKDIR /app

COPY --chown=node:node . .

ENV NODE_ENV=production

RUN npm i -g @nestjs/cli
RUN yarn --frozen-lockfile --production
RUN yarn build

EXPOSE 3000

USER node

ENTRYPOINT ["/tini", "--"]
CMD ["node", "dist/main.js"]
