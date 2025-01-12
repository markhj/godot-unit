extends TestCase

class_name AssertNull
	
func test_assert_null() -> void:
	reflective(true, func(): return assert_null(null))
	
# Ensure that a number of values in other types are not re-interpreted as null
func test_assert_null_false_positives() -> void:
	reflective(false, func(): return assert_null(false))
	reflective(false, func(): return assert_null(0))
	
func test_assert_null_bool() -> void:
	reflective(false, func(): return assert_null(true))
	
func test_assert_null_node() -> void:
	reflective(false, func(): return assert_null(Node2D.new()))

func test_assert_not_null() -> void:
	reflective(false, func(): return assert_not_null(null))
	reflective(true, func(): return assert_not_null(true))
