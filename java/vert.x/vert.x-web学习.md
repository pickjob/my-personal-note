# vert.x-web学习
    ```java
    // Server
    // create
    HttpServer server = vertx.createHttpServer();
    // start
    server.listen();
    // handling request
    server.requestHandler(request -> {
        // reading request body
        request.handler(buffer -> {
            
        });
        // multipart/form-data
        request.setExpectMultipart(true);
        request.endHandler(v -> {
            // fully read the body
            MultiMap formAttributes = request.formAttributes();
        })
        // upload files
        request.uploadHandler(upload -> {
            // chunks
            upload.handler(chunk -> {
                // xx
            });
        });
        // response
        HttpServerResponse response = request.response();
        response.putHeader("Content-Type", "text/html");
        response.write("hello world");
        // end response
        response.end();
        // send files
        response.sendFile();
    });

    // Client
    // create
    HttpClient client = vertx.createHttpClient();
    // requestes
    clinet.getNow("/uri", response -> {
        // handle response
    });
    client.request(HttpMethod.POST, "foo-uri", response -> {
        // 
    }).end();
    // requestBody
    client.post("/uri", response -> {

    }).putHeader("Content-Length", "1000")
      .write(body)
      .end();
    
    // WebSocket
    server.websocketHandler(websocket -> {

    });
    server.requestHandler(request -> {
        if (request.path().equals("/web-socket-api")) {
            ServerWebSOcket websocket = request.upgrade();
        } else {
            request.response.setStatus(400).end();
        }
    });
    client.websocket("/web-socket-api", websocket => {
        
    });

    // Router
    Router router = Router.router(vertx);
    router.route().handle(routingContext -> {

    });
    server.requestHandler(router).listen(8080);
    // routing by exact path
    Route route = router.route().path("/some/path");
    // routing by wildcard
    Route route = router.route().path("/some/path/*");
    // routing by regex
    Route route = router.route().pathRegex(".*foo");
    Route route = router.routeWithRegex(".*foo");
    // routing by Http method
    Route route = router.route().method(HttpMethod.POST);
    // routing by MIME of request
    router.route().consumes("text/html").handler(ctx -> {});
    //  path parameters
    Route route = router.route().path(HttpMethod.POST, "/products/:productype/:productid/");
    route.handle(ctx -> {
        String productType = ctx.request().getParam("productype");
        String productId = ctx.reqeust().getParam("productid");
    });
    // Rerouting
    router.get().failureHandler(ctx -> {
        ctx.reroute("/my-pretty-notfound-handler");
    });
    ```