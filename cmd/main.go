package cmd

import (
	"../internal/api"
	"../internal/db"
	"github.com/aws/aws-lambda-go/lambda"
)

// main is the entry point for this service and starts Lambda execution
func main() {

	// initialize db
	db.Init()

	//lambda.Start(handler)
	lambda.Start(api.TestHandler)

	// defer closing database connection until after the function has finished executing
	defer db.CloseDb()
}
