package main

import (
	"fmt"
	"net/http"
)

func main() {
	// "/hello" というURLにアクセスが来たときの処理を定義
	http.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello, Go Backend for Corporate Site! (CI/CD Test2)")
	})

	// ポート番号 8080 でサーバーを起動
	fmt.Println("Server is running on port 8080...")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		fmt.Println("Error starting server:", err)
	}
}
