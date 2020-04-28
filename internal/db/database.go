package db

import (
	"database/sql"
	"fmt"
	"os"
	"github.com/magiconair/properties"
	_ "github.com/go-sql-driver/mysql"
)

var db *sql.DB
var props *properties.Properties

func Init() {

	loadPropertiesFile()

	driverName := getDbConfig("DB_DRIVER_NAME")
	user := getDbConfig("DB_USER_NAME")
	password := getDbConfig("DB_USER_PASSWORD")
	host := getDbConfig("DB_HOST")
	port := getDbConfig("DB_PORT")
	schema := getDbConfig("DB_SCHEMA")

	dataSource := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?parseTime=true", user, password, host, port, schema)

	// Open up our database connection.
	db, err := sql.Open(driverName, dataSource)

	// if there is an error opening the connection, handle it
	if err != nil {
		panic(err.Error())
	}

	fmt.Println("Sucessfully connected to database.")

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
func getDbConfig(key string) string {
	if os.Getenv(key) != "" {
		return os.Getenv(key)
	}
	defaultValue, _ := props.Get(key);
	fmt.Printf("Env variable '%s' not found. Using default value: %s\n", key, defaultValue)
	return defaultValue
}

func loadPropertiesFile() {
	props = properties.MustLoadFile("defaultDbConfigs.properties", properties.UTF8)
}
