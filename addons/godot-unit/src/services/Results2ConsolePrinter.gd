extends Node

class_name Results2ConsolePrinter

func print_results(results: TestResult) -> void:
	print("=".repeat(32) + "\nGodotUnit\n")
	
	for err in results.assertions:
		print("[FAILED] %s" % [err.it])
		print(" ".repeat(9) + "Expected: %s" % [str(err.expected)])
		print(" ".repeat(9) + "Actual  : %s" % [str(err.actual)])
		print(" ".repeat(9) + "File: %s | Method: %s | Line: %d" % [
			err.source.file,
			err.source.function,
			err.source.line,
		])
		print("")
	
	print("TOTAL: %d | PASSED: %d" % [
		results.tests,
		results.passed,
	])
