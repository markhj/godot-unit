extends Node

class_name Results2ConsolePrinter

func print_results(results: TestResult) -> void:
	print("=".repeat(32) + "\nGodotUnit\n")
	
	for err in results.failed:
		print("[FAILED] %s" % [err.message])
		print(" ".repeat(9) + "Expected: %s" % [str(err.expected)])
		print(" ".repeat(9) + "Actual  : %s" % [str(err.actual)])
		print(" ".repeat(9) + "File: %s | Method: %s | Line: %d" % [
			err.test_case_file,
			err.test_case_method,
			err.test_case_line,
		])
		print("")
	
	print("TOTAL: %d | PASSED: %d" % [
		results.tests,
		results.passed,
	])
