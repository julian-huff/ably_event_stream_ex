# AblyEventStream

Sample code for connecting to an [Ably Channel using SSE](https://ably.com/documentation/sse) with [Finch](https://hexdocs.pm/finch/0.10.2/Finch.html).


## Installation

`docker build -t julianatthescore/ably_event_stream:latest .`

or

`docker pull julianatthescore/ably_event_stream:latest`

## Reproducing dropped connection

For this section, it's assumed that you have a dev setup in Ably and have your dev API key.

### Setup Finch SSE connection

Run: `docker run -it julianatthescore/ably_event_stream:latest`

Once attached to your container run:
```
AblyEventStream.Connection.connect("your_dev_api_key")
```

In your `iex` session you should see output like:
```
{:status, 200}
{:headers,
 [
   {"content-type", "application/json"},
   {"transfer-encoding", "chunked"},
   {"connection", "keep-alive"},
   {"access-control-allow-credentials", "true"},
   {"access-control-allow-origin", "*"},
   {"access-control-expose-headers",
   {"date", "Wed, 16 Mar 2022 12:59:36 GMT"},
   {"vary", "Origin"},
   {"x-content-type-options", "nosniff"},
   {"x-robots-tag", "noindex"},
   {"x-cache", "Miss from cloudfront"},
 ]}
{:data, "\n{\"id\":\"e7dMGcynAB9DjZ@1647435576290-0\"}
```

### Publishing to the channel

When setting up the SSE connection, we created channel "sample".

In a separate terminal window run:
```
curl -X POST -H "Content-Type: application/json" -u "<your_dev_api_key>" -d @large_publish.json https://rest.ably.io/channels/sample/messages
```

After the 10th POST, you'll see in your server that `{:ok, ""}` was returned. This is Finch gracefully closing the connection after receiving `"\"\\r\\n0\\r\\n\\r\\n\""`. The expected suffix is `"\"\\r\\n\"`.

In order to log the suffix, you've got to dig into the underlying Finch/Mint code.
