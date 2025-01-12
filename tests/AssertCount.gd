extends TestCase

class_name AssertCount

func test_assert_count() -> void:
	reflective(true, func(): return assert_count(3, [1, 2, 3]))
	reflective(false, func(): return assert_count(1, [1, 2, 3]))
	
	# Check other Array types
	reflective(true, func(): return assert_count(1, PackedColorArray([Color.RED])))
	reflective(false, func(): return assert_count(5, PackedColorArray([Color.RED])))
	
