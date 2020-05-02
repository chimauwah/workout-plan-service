package main

import (
	"../internal/api"
	"../internal/db"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/awslabs/aws-lambda-go-api-proxy/gorillamux"
	"github.com/gorilla/mux"
)

var muxLambda *gorillamux.GorillaMuxAdapter

func init() {
	//init mux router
	router := mux.NewRouter()

	// route handlers / endpoints
	router.HandleFunc("/api/generate", api.GenerateWorkout).Methods("POST")
	router.HandleFunc("/api/reset/counters", api.ResetCoreCounters).Methods("POST")

	muxLambda = gorillamux.New(router)
}

// main is the entry point for this service and starts Lambda execution
func main() {
	// initialize db
	db.Init()

	// defer closing database connection until after function has finished executing
	defer db.CloseDb()

	lambda.Start(handleRequest)
}

func handleRequest(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return muxLambda.Proxy(req)
}
