FROM node:current-slim

RUN apt-get update \
    && apt-get install -y \
        ca-certificates \
        fonts-liberation \
        libappindicator3-1 \
        libasound2 \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libc6 \
        libcairo2 \
        libcups2 \
        libdbus-1-3 \
        libexpat1 \
        libfontconfig1 \
        libgbm1 \
        libgcc1 \
        libglib2.0-0 \
        libgtk-3-0 \
        libnspr4 \
        libnss3 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libstdc++6 \
        libx11-6 \
        libx11-xcb1 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        libxss1 \
        libxtst6 \
        lsb-release \
        wget \
        xdg-utils
# && apt-get install -y wget gnupg ca-certificates \
# && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
# && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
# && apt-get update \
# # We install Chrome to get all the OS level dependencies, but Chrome itself
# # is not actually used as it's packaged in the node puppeteer library.
# # Alternatively, we could could include the entire dep list ourselves
# # (https://github.com/puppeteer/puppeteer/blob/master/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix)
# # but that seems too easy to get out of date.
# && apt-get install -y google-chrome-stable \
# && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN groupadd --system pptruser \
    && useradd --system --gid pptruser --groups audio,video --home-dir /app pptruser \
    && mkdir -p ./Downloads \
    && chown -R pptruser:pptruser .
USER pptruser
COPY package.json .
COPY package-lock.json .
RUN npm ci
COPY src/ src/
CMD node .