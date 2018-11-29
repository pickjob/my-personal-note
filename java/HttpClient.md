# HttpClient学习
- HttpClient
    ```java
    HttpClient client = HttpClient.newBuilder()
            .version(Version.HTTP_2)
            .followRedirects(Redirect.SAME_PROTOCOL)
            .proxy(ProxySelector.of(new InetSocketAddress("www-proxy.com", 8080)))
            .authenticator(Authenticator.getDefault())
            .build();
    ```
- HttpRequest
    ```java
    HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("http://openjdk.java.net/"))
            .timeout(Duration.ofMinutes(1))
            .header("Content-Type", "application/json")
            .POST(BodyPublishers.ofFile(Paths.get("file.json")))
            .build();
    ```
- Synchronous / Asynchronous
    ```java
    // Synchronous
    HttpResponse<String> response = client.send(request, BodyHandlers.ofString());
    System.out.println(response.statusCode());
    System.out.println(response.body());
    // Asynchronous
    client.sendAsync(request, BodyHandlers.ofString())
            .thenApply(response -> {
                System.out.println(response.statusCode());
                return response; 
              })
            .thenApply(HttpResponse::body)
            .thenAccept(System.out::println);
    ```
- About Json
    ```java
    // get json
    HttpRequest request = HttpRequest.newBuilder(uri)
            .header("Accept", "application/json")
            .build();
    HttpClient.newHttpClient()
            .sendAsync(request, BodyHandlers.ofString())
            .thenApply(HttpResponse::body)
            .thenApply(objectMapper::readValue);
    // send json
    String requestBody = objectMapper
            .writerWithDefaultPrettyPrinter()
            .writeValueAsString(map);
    HttpRequest request = HttpRequest.newBuilder(uri)
            .header("Content-Type", "application/json")
            .POST(BodyPublishers.ofString(requestBody))
            .build();
    HttpClient.newHttpClient()
            .sendAsync(request, BodyHandlers.ofString())
            .thenApply(HttpResponse::statusCode)
            .thenAccept(System.out::println);
    ```