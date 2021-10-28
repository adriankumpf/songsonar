FROM ekidd/rust-musl-builder:stable AS builder

WORKDIR /opt/app/
RUN sudo chown -R rust:rust .

COPY Cargo.* .
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release

COPY assets assets
COPY migrations migrations
COPY src src
COPY static static
COPY templates templates
COPY .git .git
COPY sqlx-data.json sqlx-data.json
# TODO Fix permissions
RUN sudo touch src/main.rs

RUN cargo build --release
RUN strip target/x86_64-unknown-linux-musl/release/songsonar

##########################################################

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /opt/app/

COPY --from=builder /opt/app/target/x86_64-unknown-linux-musl/release/songsonar .

ENTRYPOINT ["./songsonar"]
