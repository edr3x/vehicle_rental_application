const int _port = 8080;
const String _host = "http://10.0.2.2";

const String api = "$_host:$_port/api/v1";
const String imageUrl = "$_host:$_port/image";
const Map<String, String> apiHeader = {
  "content-type": "application/json",
};
