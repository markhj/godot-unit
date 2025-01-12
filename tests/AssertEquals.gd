extends TestCase

class_name AssertEquals
	
func test_bools() -> void:
	reflective(true, func(): return assert_equals(true, true))
	reflective(false, func(): return assert_equals(true, false))

func test_null_vs_bool() -> void:
	reflective(false, func(): return assert_equals(false, null))
	
func test_strings() -> void:
	reflective(true, func(): return assert_equals("Hello", "Hello"))
	reflective(false, func(): return assert_equals("Hello", "World"))
	
func test_integers() -> void:
	reflective(true, func(): return assert_equals(2, 2))
	reflective(false, func(): return assert_equals(1, 2))
	
func test_floats() -> void:
	reflective(true, func(): return assert_equals(2.5, 2.500))
	reflective(false, func(): return assert_equals(1.5, 2.5))
	
func test_floats_vs_integers() -> void:
	reflective(true, func(): return assert_equals(2, 2.0))
	reflective(false, func(): return assert_equals(2, 2.5))

func test_nodes() -> void:
	var a = Node2D.new()
	var b = Node2D.new()
	var ref_to_a = a
	var duplicated_a = a.duplicate()
	
	reflective(true, func(): return assert_equals(a, a))
	reflective(true, func(): return assert_equals(a, ref_to_a))
	reflective(false, func(): return assert_equals(a, b))
	reflective(false, func(): return assert_equals(a, duplicated_a))
