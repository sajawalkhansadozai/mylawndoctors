'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e20f28d010920351f4b648928bf578aa",
"assets/AssetManifest.bin.json": "3e2430b83531d8168096421b31b6e41b",
"assets/AssetManifest.json": "03393643fc958b43ce3976ae7c15c008",
"assets/assets/aisha.jpg": "2cf883c1be6aa108030ec5f2e81f1a31",
"assets/assets/ali.jpg": "4bd1aefda45153dc636153c40f1d9735",
"assets/assets/fatima.jpg": "85f9e561fe77267391b55275bb0c2220",
"assets/assets/garden1.jpg": "16e605827a649ff7372b4a0f94cfb9eb",
"assets/assets/garden2.jpg": "9c8ca5e483a17f6d93c6b23e25bcb149",
"assets/assets/garden3.jpg": "52761cddb072b22a71048a7271f6085b",
"assets/assets/garden4.jpg": "712c2d9344ca4134a693024251c2a8f6",
"assets/assets/garden5.jpg": "49b420d990f42d8f3814a97f58bcf69c",
"assets/assets/garden6.jpg": "3f1ad84ad0c10612b6a7cc0f6a180c08",
"assets/assets/hero1.jpg": "cdebd3cd4e7647a8850585d10cf64340",
"assets/assets/hero2.jpg": "bfc1e85fdb9c67bfc1116926464fbbe4",
"assets/assets/hero3.jpg": "9acadc5240526386a8ce069f341c689e",
"assets/assets/logo.png": "628bd0411d5c6c08a2d26028605adc89",
"assets/assets/muhammad.jpg": "240dc507c26acbf17b9ca91a2d624e31",
"assets/assets/omar.jpg": "3a155b188097892c749b205157fc314c",
"assets/assets/plants/aloe1.jpg": "a135609560c23888792e686ce5ff3a40",
"assets/assets/plants/aloe2.jpg": "6028e17dff2c0f6962f8a9ff3413d2f7",
"assets/assets/plants/aloe3.jpg": "c9b2a42547a37ba695194ba6a12b3e75",
"assets/assets/plants/areca1.jpg": "be27f3c25f71c3574689775b57a19858",
"assets/assets/plants/areca2.jpg": "767138957833ee0eb4c8ed9a4cb5b3ad",
"assets/assets/plants/areca3.jpg": "e65b653d2604a7e09a74e21b6ecb6021",
"assets/assets/plants/aza1.jpg": "cae8ee46fc4e74973a91c0b3a4d636f3",
"assets/assets/plants/aza2.jpg": "c9896324568a9d3e1a5255003489712b",
"assets/assets/plants/aza3.jpg": "4fa59cd27d81191d952c8350fb015ec8",
"assets/assets/plants/bamboo1.jpg": "c491a274b545aaef500f30ef08ecc1d4",
"assets/assets/plants/bamboo2.jpg": "67a01a04ed531d4e3e414ef68ab84f9c",
"assets/assets/plants/bamboo3.jpg": "a90b27029b245b3e4ce2cbd8590f2651",
"assets/assets/plants/boug1.jpg": "7f0e2f7499daaae53040ca56cc55f0f1",
"assets/assets/plants/boug2.jpg": "a672dcfbb562e2e047e0110df94ccd34",
"assets/assets/plants/boug3.jpg": "db8bd3938d84f61a517401f45509f881",
"assets/assets/plants/cam1.jpg": "c690cf5984aef8f72e4aecac8f9f30ca",
"assets/assets/plants/cam2.jpg": "830083c8808e23031b0afa0e7f78a42d",
"assets/assets/plants/cam3.jpg": "564b37f100f89578f69cf2e7d0aa41f2",
"assets/assets/plants/drac1.jpg": "fa9bce64f2f3eed7145abe4587d4ad53",
"assets/assets/plants/drac2.jpg": "9ae3ff5e88ec4691be9af64038d4e225",
"assets/assets/plants/drac3.jpg": "f2e96cf879cb427636856b3a7439ad9e",
"assets/assets/plants/ficus1.jpg": "fc6f35cafd8eea3ce76c2429e1a7296d",
"assets/assets/plants/ficus2.jpg": "1ef9a305456e8700dd14448f15c9612c",
"assets/assets/plants/ficus3.jpg": "2e775029821c2646ca90a6fd356e922b",
"assets/assets/plants/gard1.jpg": "d899342054f948902857881cd5d12e48",
"assets/assets/plants/gard2.jpg": "c7d683e881732ba0976248af652fb33d",
"assets/assets/plants/gard3.jpg": "11efaebe06541a05c9c4597261d8fa2d",
"assets/assets/plants/guava1.jpg": "0decac9bb285271d5e813cc4070d3e3f",
"assets/assets/plants/guava2.png": "3a060e762f006a1d706607d5eccd3f42",
"assets/assets/plants/guava3.jpg": "fb2c87bae55e10251298ce5a080389f9",
"assets/assets/plants/hib1.jpg": "88ea93d18143b529d9eeb1fe05022fe9",
"assets/assets/plants/hib2.jpg": "2bbc0e6cbb03e36bf4b3798a3ffc04e5",
"assets/assets/plants/hib3.jpg": "d6ef0dc6660212914940b5a0c7e3b411",
"assets/assets/plants/hyd1.jpg": "9b2f143e1a27a709503ab3a2e979e04a",
"assets/assets/plants/hyd2.jpg": "8a3fc48412b2956d79bd01f3bcfff2bf",
"assets/assets/plants/hyd3.jpg": "69bcb7ca420801d3b86b39d204e561bf",
"assets/assets/plants/ixo1.jpg": "286b723dd686715d4becda621b470fbf",
"assets/assets/plants/ixo2.jpg": "13a643f708ea61a3ac319304ee4e5a1b",
"assets/assets/plants/ixo3.jpg": "c16e44456377a776608f07922fad3608",
"assets/assets/plants/jas1.jpg": "81ee9cb1fea05f9bf7f96cda6de27c1f",
"assets/assets/plants/jas2.jpg": "b058b898677ceefd7b21446187ed14b1",
"assets/assets/plants/jas3.jpg": "9af0f28d301f4b885b92eabe6058b0f3",
"assets/assets/plants/lav1.jpg": "094e3a9c8eb632cc80bafc167c19636e",
"assets/assets/plants/lav2.jpg": "dd51f9ca7e390a907a9f8339baf85c90",
"assets/assets/plants/lav3.jpg": "b4485be0bc0752fa52fb4dbffc53ba6c",
"assets/assets/plants/lemon1.jpg": "03276b7dd8e7c37cf42bf16fec7f003f",
"assets/assets/plants/lemon2.jpg": "073243d8066a63b0722af2001e1b982d",
"assets/assets/plants/lemon3.jpg": "98901cf629d60a5b11614875d1f72eda",
"assets/assets/plants/mango1.jpg": "ac22026d319335141ca9efd8a8443f91",
"assets/assets/plants/mango2.jpg": "541dcd188da896a948dc81793f3ade2e",
"assets/assets/plants/mango3.jpg": "c8bcf0767f087015b7d5566f3907a22b",
"assets/assets/plants/mar1.jpg": "1561e97def8a63f39682692a35998485",
"assets/assets/plants/mar2.jpg": "dd6d4d5f136f4cc621e728d6fcd104e0",
"assets/assets/plants/mar3.jpg": "cdf09c7f1df95eebb5bfff2fc7c6fc40",
"assets/assets/plants/neem1.jpg": "815077f55bf8a50541bfcec014520d81",
"assets/assets/plants/neem2.jpg": "eea924d677def7e5e478b1a45afe7172",
"assets/assets/plants/neem3.jpg": "b0ca885b2d101e122f3d7cd09f69fa66",
"assets/assets/plants/pet1.jpg": "5ea06ca3814fc1c1a7bc29020e33aae0",
"assets/assets/plants/pet2.jpg": "0faa656cc137c829582b3cd972d5ec78",
"assets/assets/plants/pet3.jpg": "d00130a68810305ddeb12a0c3faf7211",
"assets/assets/plants/pothos1.jpg": "77a91f7ab8ff150f6290d47f902eceed",
"assets/assets/plants/pothos2.jpg": "594a642728e5c7397fa4b9c51b54d94d",
"assets/assets/plants/pothos3.jpg": "eb45d01ccaa60ab956e0b3ecdd0536f3",
"assets/assets/plants/rose1.jpg": "c3806f154b969d90d1933c542f30a506",
"assets/assets/plants/rose2.jpg": "2be6d33b3e1bac3843deeb4ae7d7bd20",
"assets/assets/plants/rose3.jpg": "4982dd2eae3f322d5a933f63cb5abfa3",
"assets/assets/plants/rubber1.jpg": "7228e856cfd12afbf4c9556be11f7724",
"assets/assets/plants/rubber2.jpg": "c932344a510cfb30563de9e2f517484a",
"assets/assets/plants/rubber3.jpg": "ffed4048a09c9f9384ab77de66efb93a",
"assets/assets/plants/snake1.jpg": "779469d916ff36cdfc484c0b7fde2b4c",
"assets/assets/plants/snake2.jpg": "54e73b5b2ce53679de2e151863a86826",
"assets/assets/plants/snake3.jpg": "135213d527bd2734ba4055128d5e26f9",
"assets/assets/services1.jpg": "b1031bd42cce87c879930c97f34ff668",
"assets/assets/services2.jpg": "7e25e62091255ec67a15c03d0eaab7d7",
"assets/assets/services3.jpg": "d4116c75c15d1ea01b47994d7f9cd183",
"assets/assets/services4.jpg": "a39216d61cd9dbf0f12bf3b43fa6eb8a",
"assets/assets/zainab.jpg": "b98b8dc2487d51e597044387570b8a50",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "1fd4b9ee86eabcd5f3641ede114a367c",
"assets/NOTICES": "61a7c72cad4a10f9854e9b56b2c7b43c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "628bd0411d5c6c08a2d26028605adc89",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "85e2ef2a96c76254d32a7d6398b99c93",
"icons/Icon-192.png": "628bd0411d5c6c08a2d26028605adc89",
"icons/Icon-512.png": "628bd0411d5c6c08a2d26028605adc89",
"icons/Icon-maskable-192.png": "628bd0411d5c6c08a2d26028605adc89",
"icons/Icon-maskable-512.png": "628bd0411d5c6c08a2d26028605adc89",
"index.html": "3e546810cd75650e52fb80fbfd4ded64",
"/": "3e546810cd75650e52fb80fbfd4ded64",
"main.dart.js": "47ce4cfb87d9be4280c8da558207fc93",
"manifest.json": "18e7501a8d3a3cb6cf0e73f366464c41",
"version.json": "d9604a888bfb0f5a7ece5724a37f4e19",
"_redirects.txt": "c62c109df475b368db5e075d5e2f0052"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
