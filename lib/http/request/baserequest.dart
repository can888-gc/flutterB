enum HttpMethod { GET, POST, DELETE }

//基础的请求类
abstract class BaseRequest {
  var pathParams = '';
  //是否启用Https的访问方式
  var useHttps = true;
  Map<String, String> params = Map();

  //设置域名
  String authority() {
    return "api.devio.org";
  }

  //通过派生类来设置通过什么方法来请求的
  HttpMethod httpMethod();

  //设置一个请求的路径
  String path();

  //生成一个具体的Url
  String url() {
    Uri uri;
    var pathStr = path();

    //拼接path参数
    if (pathStr.isNotEmpty) {
      if (pathStr.endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    return uri.toString();
  }

  //接口是否要登录
  bool needLogin();

  //添加参数
  BaseRequest add(String k, String v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, String> header = Map();
  BaseRequest addHeader(String k, String v) {
    header[k] = v.toString();
    return this;
  }
}
