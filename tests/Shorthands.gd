extends TestCase

class_name Shorthands
	
func test_assert_not_equals() -> void:
	reflective(false, func(): return assert_not_equals(true, true))
	reflective(true, func(): return assert_not_equals(true, false))
	reflective(true, func(): return assert_not_equals(2, 10))
	reflective(false, func(): return assert_not_equals(2, 2))
	reflective(true, func(): return assert_not_equals(2.5, 10.5))
	reflective(false, func(): return assert_not_equals(10.5, 10.5))
	reflective(true, func(): return assert_not_equals("Hello", "World"))
	reflective(false, func(): return assert_not_equals("Hello", "Hello"))
	
func test_assert_true() -> void:
	reflective(true, func(): return assert_true(true))
	reflective(false, func(): return assert_true(false))
	
func test_assert_false() -> void:
	reflective(true, func(): return assert_false(false))
	reflective(false, func(): return assert_false(true))

func test_assert_empty() -> void:
	reflective(true, func(): return assert_empty([]))
	reflective(false, func(): return assert_empty([1, 2, 3]))
