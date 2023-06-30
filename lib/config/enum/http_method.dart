enum HTTPMethod { get, post, delete, put, patch }

extension HttpMethodToString on HTTPMethod {
  String toMethodString() {
    switch (this) {
      case HTTPMethod.get:
        return "GET";
      case HTTPMethod.post:
        return "POST";
      case HTTPMethod.delete:
        return "DELETE";
      case HTTPMethod.patch:
        return "PATCH";
      case HTTPMethod.put:
        return "PUT";
    }
  }
}
