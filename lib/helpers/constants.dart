import 'key.dart' as k;

// Auth Service
const String domain = "myanimelist.net";
const String authorizationEndpoint = "/v1/oauth2/authorize";
const String tokenEndpoint = "/v1/oauth2/token";
const String redirectUrl = "dev.potato.nekolist://oauth-callback";

const String clientId = k.clientId;

// Api Services
const String apiEndpoint = "https://api.myanimelist.net/v2";

// OTA update

const String owner = "ajxv";
const String repo = "NekoList";
const String latestTagApi =
    "https://api.github.com/repos/$owner/$repo/releases/latest";

const String latestReleaseDownloadPath =
    "https://github.com/$owner/$repo/releases/latest/download/";
