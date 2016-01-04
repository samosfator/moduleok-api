Npm.depends({
    cheerio: "0.19.0"
});

Package.describe({
    summary: 'Tiny, fast, and elegant implementation of core jQuery designed specifically for the server',
    version: '0.19.0',
    name: 'cheerio'
});

Package.onUse(function (api) {
    api.addFiles(['cheerio.js'], 'server');
    api.export('cheerio', 'server');
});
