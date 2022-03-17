FROM elixir:1.13.3-alpine

COPY . .

RUN mix local.hex --force && \
  mix deps.get && \
  mix compile

CMD ["iex", "-S", "mix"]
