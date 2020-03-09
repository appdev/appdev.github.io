'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/index.html": "a724d1df97b1a4a0bdad877e1e646947",
"/main.dart.js": "2308410aff788c0eb28d125409b02906",
"/assets/LICENSE": "96a48eab8a0e53482140d6cb5bc264db",
"/assets/AssetManifest.json": "45bac8413312979b7560b4eae9deb9fc",
"/assets/FontManifest.json": "f7161631e25fbd47f3180eae84053a51",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/packages/flutter_markdown/assets/logo.png": "67642a0b80f3d50277c44cde8f450e50",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/assets/images/git.png": "f3290ad6438ac90017a1bab5a1f3a5bc",
"/assets/assets/images/pre-page-normal.png": "c15d14aba2666fc184f77b0a86b3d1df",
"/assets/assets/images/github.png": "dd288308fba6deb7680ac190a7326ec1",
"/assets/assets/images/no-data.png": "711933a4d4c81aa7ca53827ec3d146fc",
"/assets/assets/images/qq-group.png": "095681adbf39d16467765a53a6067d90",
"/assets/assets/images/next-page-hover.png": "6031acd94dd3165318558cb23aa3e8fc",
"/assets/assets/images/enter-icon.svg": "87e43f3a8b3c05c47a3d79e1ed4bd066",
"/assets/assets/images/favicon.png": "f36f50bb4a6f90189d098369e4f934cf",
"/assets/assets/images/next-page-normal.png": "855393996f46465df71eb43a078d0151",
"/assets/assets/images/pre-page-hover.png": "6e53f2a4a4480248702229dfe910e955"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request, {
          credentials: 'include'
        });
      })
  );
});
