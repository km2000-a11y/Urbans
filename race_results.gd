extends Node

var player_name := "Player"
var results: Array = []


func clear():
	results.clear()


func add_result(name: String, car: String, time_ms: int):
	results.append({
		"name": name,
		"car": car,
		"time": time_ms
	})
