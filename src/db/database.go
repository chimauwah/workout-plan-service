package db

import (
	"database/sql"
	"fmt"
	"os"
)

var db *sql.DB

func Init() {

	driverName := getDbConfig("DB_DRIVER_NAME", "mysql")
	user := getDbConfig("DB_USER_NAME", "localuser")
	password := getDbConfig("DB_USER_PASSWORD", "localuser")
	host := getDbConfig("DB_HOST", "ccu-database-1.cg3rhofjy8l3.us-east-2.rds.amazonaws.com")
	port := getDbConfig("DB_PORT", "3306")
	schema := getDbConfig("DB_SCHEMA", "activity")

	dataSource := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?parseTime=true", user, password, host, port, schema)

	// Open up our database connection.
	db, err := sql.Open(driverName, dataSource)

	// if there is an error opening the connection, handle it
	if err != nil {
		panic(err.Error())
	}

	fmt.Println("Sucessfully connected to MySQL database.")

	setDb(db)
}

func setDb(db2 *sql.DB) {
	db = db2
}

func GetDb() *sql.DB {
	return db
}

func CloseDb() {
	db.Close()
	fmt.Println("Database connection closed.")
}

// Returns the db config value for provided key or returns default value if env variable not set
func getDbConfig(key string, defaultValue string) (retValue string) {
	if os.Getenv(key) != "" {
		return os.Getenv(key)
	}
	fmt.Printf("Env variable '%s' not found. Using default value: %s\n", key, defaultValue)
	return defaultValue
}
