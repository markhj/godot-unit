extends Control

@onready var test_summary = $TestSummary

func _ready():
	test_summary.results = TestRunner.new().run([
		AssertEquals.new(),
		AssertNull.new(),
		AssertCount.new(),
		Shorthands.new(),
	])
