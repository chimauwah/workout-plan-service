package main

import (
	"../internal/api"
	"github.com/aws/aws-lambda-go/lambda"
)

// main is the entry point for this service and starts Lambda execution
func main() {

	//lambda.Start(handler)
	lambda.Start(api.TestHandler)
}
