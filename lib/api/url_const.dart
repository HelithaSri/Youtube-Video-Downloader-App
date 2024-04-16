const bool isUat = false;
const String baseUrl = isUat
    ? "https://jsonplaceholder.typicode.com"
    : "http://192.168.254.105:5000";

const String downloadVideo = "$baseUrl/download/video";
const String getAllPhotos =
    "https://jsonplaceholder.typicode.com/photos?start=0&_limit=20";
const String getSinglePhotos = "$baseUrl/photos?start=0&_limit=1";
const String getPlaylist = "$baseUrl/photos?start=0&_limit=10";

const String fetchDetails = "$baseUrl/yt/fetch-info";
