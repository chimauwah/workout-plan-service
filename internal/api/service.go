package api

import (
	"../db"
	"../model"
	"fmt"
	"github.com/jucardi/go-streams/streams"
	"time"
	"net/http"
	"encoding/json"
	"strconv"
)

const GetMuscleCategoryAndMaxExercisesForTodaysWorkoutSQL = "select mgm.muscle, dgm.category, dgm.max from activity.day_group_mapping dgm join activity.muscle_group_mapping mgm on dgm.`group` = mgm.`group` where dgm.day = ?"
const GetNRandomActivitiesForGivenMuscleAndCategorySQL = "select acty.name, acty.muscle, acty.category from activity.activity acty where acty.active = ? and acty.muscle = ? and acty.category like ? order by rand() limit ?"
const GetCoreExercises = "select acty.name, acty.muscle, acty.category from activity.activity acty where muscle ='CORE' and consecutive_days < ?"
const MaxConsecutiveDaysForCore = 3
const ResetCoreConsecutiveCounter = "UPDATE activity.activity acty SET acty.consecutive_days = 0 WHERE muscle = 'CORE'"

const IncreaseCoreConsecutiveCounter = "UPDATE activity.activity acty SET acty.consecutive_days = consecutive_days + 1 WHERE muscle = 'CORE'"

func GenerateWorkout(w http.ResponseWriter, r *http.Request) {
	// initialize db
	//db.Init()

	// defer closing database connection until after the function has finished executing
	//defer db.CloseDb()

	currentTime := time.Now()
	currentDay := currentTime.Weekday()
	activitiesToPerform := getActivitiesForDay(currentDay)

	// TODO: MAAYYYYYBE, alternate lowerbody and upper body for stretching?? hip, glute, tfl | ankle, achilles, calf, adductors??

	// print out today's workout
	fmt.Println("Today's Workout |", currentDay, currentTime.Month(), currentTime.Day(), currentTime.Year())
	if len(activitiesToPerform) < 1 {
		fmt.Println("REST MY SON!!")
	} else {

		// filter AM tissue exercises
		dayTissueActivities := streams.FromArray(activitiesToPerform).Filter(func(v interface{}) bool {
			return v.(model.Activity).Category == "tissue (AM)"
		}).ToArray().([]model.Activity)
		// TODO: I WANT TO SORT!!! HIP, ADDUCTORS, CALF but oh well - OR, LOOK UP HOW JAVA SORTS WHEN PASSED IN A SORT ORDER

		// filter core exercises
		coreExerciseActivities := streams.FromArray(activitiesToPerform).Filter(func(v interface{}) bool {
			return v.(model.Activity).Muscle == "CORE" && v.(model.Activity).Category == "exercise"
		}).ToArray().([]model.Activity)

		// filter stretch exercises
		stretchActivities := streams.FromArray(activitiesToPerform).Filter(func(v interface{}) bool {
			return v.(model.Activity).Category == "stretch"
		}).ToArray().([]model.Activity)
		// TODO: I WANT TO SORT!!!  HIP, GLUTE, ADDUCTORS, CALF, ANKLE, ACHILLES

		// filter leg exercises
		legExerciseActivities := streams.FromArray(activitiesToPerform).Filter(func(v interface{}) bool {
			return v.(model.Activity).Category == "exercise" && v.(model.Activity).Muscle != "CORE"
		}).ToArray().([]model.Activity)
		// TODO: I WANT TO SORT!!!  GLUTE, QUADS, ADDUCTORS, CALF, ANKLE, ACHILLES

		// filter resistance exercises
		resistanceActivities := streams.FromArray(activitiesToPerform).Filter(func(v interface{}) bool {
			return v.(model.Activity).Category == "resistance"
		}).ToArray().([]model.Activity)

		// filter AM tissue exercises
		nightTissueActivities := streams.FromArray(activitiesToPerform).Filter(func(v interface{}) bool {
			return v.(model.Activity).Category == "tissue (PM)"
		}).ToArray().([]model.Activity)
		// TODO: I WANT TO SORT!!! HIP, ADDUCTORS, CALF

		fmt.Println("\n*** AM Tissue Work ***")
		printWorkoutFormatted(dayTissueActivities)

		fmt.Println("\n*** Core Work ***")
		printWorkoutFormatted(coreExerciseActivities)

		fmt.Println("\n*** Stretching Work ***")
		printWorkoutFormatted(stretchActivities)

		fmt.Println("\n*** Leg Exercises ***")
		printWorkoutFormatted(legExerciseActivities)

		fmt.Println("\n*** Resistance Work ***")
		printWorkoutFormatted(resistanceActivities)

		fmt.Println("\n*** PM Tissue Work ***")
		printWorkoutFormatted(nightTissueActivities)

	}

	// TODO: figure out things doing everyday - DONE, I think??

	// TODO: order workout  1) AM tissue work | 2) core  3) stretch | 4) resistance/exercises | 5) PM tissue work??

	// TODO: how long to do plank??

	json.NewEncoder(w).Encode(createResponseMap(true, "200", ""))
	return
}

func getActivitiesForDay(currentDay time.Weekday) []model.Activity {

	// for today, select muscle we are doing, the category of it, and max exercises to do for that muscle
	results1, err := db.GetDb().Query(GetMuscleCategoryAndMaxExercisesForTodaysWorkoutSQL, currentDay)
	if err != nil {
		panic(err.Error()) // proper error handling instead of panic in your app
	}
	var muscleCategoryMappings []model.MuscleCategoryMapping
	for results1.Next() {
		var muscleCategoryMapping model.MuscleCategoryMapping
		err := results1.Scan(&muscleCategoryMapping.Muscle, &muscleCategoryMapping.Category, &muscleCategoryMapping.Max)
		if err != nil {
			panic(err.Error()) // proper error handling instead of panic in your app
		}
		muscleCategoryMappings = append(muscleCategoryMappings, muscleCategoryMapping)
	}

	var activitiesToPerform []model.Activity
	for _, muscleCategoryMapping := range muscleCategoryMappings {
		results2, err := db.GetDb().Query(GetNRandomActivitiesForGivenMuscleAndCategorySQL, true, muscleCategoryMapping.Muscle, muscleCategoryMapping.Category+"%", muscleCategoryMapping.Max)
		if err != nil {
			panic(err.Error()) // proper error handling instead of panic in your app
		}
		for results2.Next() {
			var activityToPerform model.Activity
			err := results2.Scan(&activityToPerform.Name, &activityToPerform.Muscle, &activityToPerform.Category)
			if err != nil {
				panic(err.Error()) // proper error handling instead of panic in your app
			}
			activitiesToPerform = append(activitiesToPerform, activityToPerform)
		}
	}

	activitiesToPerform = append(activitiesToPerform, getCoreWorkout()...)

	return activitiesToPerform
}

func getCoreWorkout() []model.Activity {

	results3, err := db.GetDb().Query(GetCoreExercises, MaxConsecutiveDaysForCore)
	if err != nil {
		panic(err.Error()) // proper error handling instead of panic in your app
	}
	var coreActivities []model.Activity
	for results3.Next() {
		var coreActivity model.Activity
		err := results3.Scan(&coreActivity.Name, &coreActivity.Muscle, &coreActivity.Category)
		if err != nil {
			panic(err.Error()) // proper error handling instead of panic in your app
		}
		coreActivities = append(coreActivities, coreActivity)
	}

	// TODO: REALLY NEED TO DO THIS ONLY WHEN WORKOUT HAS BEEN ACCEPTED!!
	updateCoreCounter()

	return coreActivities
}

func updateCoreCounter() {
	resetPreparedStmt, err := db.GetDb().Prepare(IncreaseCoreConsecutiveCounter)
	if err != nil {
		panic(err.Error())
	}
	resetPreparedStmt.Exec()
}

// EVERY 3 DAYS, RESET CONSECUTIVE DAYS COUNTER (mostly for planks) - take a break from core every 3 days
// maybe call this restfully or something using an event trigger
func ResetCoreCounters(w http.ResponseWriter, r *http.Request) {
	resetPreparedStmt, err := db.GetDb().Prepare(ResetCoreConsecutiveCounter)
	if err != nil {
		panic(err.Error())
	}
	resetPreparedStmt.Exec()
	fmt.Println("Core counter reset to 0.")
	json.NewEncoder(w).Encode(createResponseMap(true, "200", ""))
	return
}

func printWorkoutFormatted(activitiesToPerform []model.Activity) {
	if (len(activitiesToPerform)) < 1 {
		fmt.Println("\tN/A")
	} else {
		for _, activity := range activitiesToPerform {
			fmt.Printf("%s \n\t%s\n", activity.Muscle, activity.Name)
		}
	}
}

func createResponseMap(success bool, code string, msg string) map[string]string {
	res := map[string]string{
		"Success": strconv.FormatBool(success),
		"Status":  code,
		"Message": msg}
	return res
}

// have custom struct (Attribute) implement Scanner interface which will be called by driver
// when retrieving json from db to unmarshal into struct (Attribute) type

// REF: https://stackoverflow.com/questions/47335697/golang-decode-json-request-in-nested-struct-and-insert-in-db-as-blob
// alternative approach: https://github.com/jinzhu/gorm/issues/1935
//func (c *Attribute) Scan(src interface{}) error {
//	var data []byte
//	if b, ok := src.([]byte); ok {
//		data = b
//	} else if s, ok := src.(string); ok {
//		data = []byte(s)
//	}
//	return json.Unmarshal(data, c)
//}
