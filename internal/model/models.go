package model

type Activity struct {
	Name     string `json:"name"`
	Muscle   string `json:"muscle"`
	Category string `json:"category"`
}

type MuscleCategoryMapping struct {
	Muscle   string `json:"muscle"`
	Category string `json:"category"`
	Max      int    `json:"max"`
}

//type Attribute struct {
//	Level      string        `json:"level"`
//	TimesAWeek int           `json:"timesAWeek"`
//	Desc       []Description `json:"description"`
//	Target     []Target      `json:"target"`
//}
//
//type Description struct {
//	Text  string `json:"text"`
//	Image string `json:"image"`
//	Video string `json:"video"`
//}
//
//type Target struct {
//	Reps          int `json:"reps"`
//	Sets          int `json:"sets"`
//	RestInSeconds int `json:"rest"`
//	Rounds        int `json:"rounds"`
//}
