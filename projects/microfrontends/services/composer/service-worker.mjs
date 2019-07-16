let installing = true;

self.addEventListener('install', function (event) {

});

self.addEventListener('fetch', async function (event) {
  const {pathname} = new URL(event.request.url);
  if (pathname.startsWith('/home/somescript')) {
    console.log('rewriting')
    const fetchRequest = event.request.clone();
    const response = await fetch(fetchRequest);
    const body = await response.text();
    const newBody = body.replace(/asdf/, `/home/asdf`)
    event.respondWith(new Response(newBody));
  }
});