# --- 1段階目: ビルド環境 ---
FROM golang:alpine AS builder

WORKDIR /app

# 依存関係のダウンロード
COPY go.mod ./
RUN go mod download

# ソースコードをコピーしてビルド
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o contact-api .

# --- 2段階目: 本番用軽量コンテナ ---
FROM alpine:latest

WORKDIR /app

# 1段階目のビルダー環境からバイナリをコピー
COPY --from=builder /app/contact-api /app/contact-api

EXPOSE 8080

# 実行ファイルの位置を明確に指定
CMD ["/app/contact-api"]