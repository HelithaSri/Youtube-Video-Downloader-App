const bool isUat = true;
const String baseUrl = isUat
    ? "https://jsonplaceholder.typicode.com"
    : "https://jsonplaceholder.typicode.com";

const String downloadVideo = "$baseUrl/download/video";
const String getAllPhotos = "$baseUrl/photos?start=0&_limit=20";
const String getSinglePhotos = "$baseUrl/photos?start=0&_limit=1";
const String getPlaylist = "$baseUrl/photos?start=0&_limit=10";
