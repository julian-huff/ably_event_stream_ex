defmodule AblyEventStream.Connection do
  def connect(api_key) do
    sse_url = "https://realtime.ably.io/event-stream?v=1.2&channels=sample&heartbeats=true&key=#{api_key}"

    request = Finch.build(:get, sse_url)

    Finch.stream(request, AblyEventStream.HTTP, "",
      fn
        message, _accumulator ->
          IO.inspect(message, limit: :infinity)

          ""
      end,
      [{:receive_timeout, :infinity}]
    )
  end
end
