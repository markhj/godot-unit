# GodotUnit

![GitHub Tag](https://img.shields.io/github/v/tag/markhj/godot-unit?label=version)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?label=license)

**_GodotUnit_** is a small unit testing add-on for Godot, inspired by
the likes of PHPUnit and JUnit.

## 💫 Prerequisites

- Godot 4.3 or higher

## 🔖 Features

🎁 **Designed for Godot**: Written in GDScript, and capable of testing Godot-specific
things, such as nodes.

📊 **Easily digestible results**: The results are detailed, and help locate
where problems have arisen which clear and concise references to the test source code.

📦 **Easily extendable**: Need more assertions? No problem. It's very easy to
expand on _GodotUnit_'s functionality.

🔬 **Self-testing**: _GodotUnit_ is keeping itself in check with a self-testing utility.

## 🚀 Installation

> This add-on is not yet available as an official Godot plug-in.
> The goal is to add it to the official repository, when it has matured a bit.

Since
[submodules are not allowed in Godot](https://docs.godotengine.org/en/latest/community/asset_library/submitting_to_assetlib.html#requirements),
the best way to install the plug-in is by downloading the code, and copying the contents
of ``addon/godot-unit`` to the identical location within your project.

Following this, you have to enable the plugin under **Project Settings &rarr; Addons**.

## 🚦 Where to run tests?

The first thing you need to do, is to decide _where_ and _when_ you want
your unit tests to run.

The current state of Godot doesn't offer a super obvious
place for this kind of stuff, so you might have to get a bit creative.

### Checking debug mode

You can (and probably should) ensure that tests are only executed (or visible)
in debug mode, using code akin to:

````gdscript
if OS.is_debug_build():
    run_tests()
````

### Solutions to run

#### Solution 1

Create a button (e.g. in your main menu), which is only visible in
debug mode, which opens a scene that executes the tests.

### Solution 2

If the unit test doesn't impact performance significantly,
you could run it upon app start, but with a very important
note: Only in debug mode!

## ✒️ Writing a test

Let's get started with a really simple test case.

Create an empty script file (e.g. ``res://tests/my-test.gd``)

The ``TestRunner`` will search for methods called ``test_*``, so our
first code will look like this:

````GDScript
extends TestCase

class_name MyTest

func test_hello_world() -> void:
    # Test will pass
    assert_equals(5, 5)
    
    # Test will fail
    assert_equals("Hello", "World")
````

As in many other testing frameworks, you can provide an optional description:

````GDScript
assert_equals(49.95, calculate_price(), "Checks that calculated price equals 49.95")
````

## ▶️ Running the test

From the location where you want to execute your unit tests, you
instantiate the ``TestRunner``, and select the test classes you'd like to run.

````GDScript
var results: TestResult = TestRunner.new().run([
    MyTest.new(),
    # Add other test classes here
])
````

## 📢 Displaying results

The results can be printed to the console using the built-in &mdash; and aptly named
&mdash; ``Results2ConsolePrinter``.

````GDScript
var results: TestResult = TestRunner.new().run([
    MyTest.new(),
    # Add other test classes here
])

Results2ConsolePrinter.new().print_results(results)
````

It prints a summary of how many tests were made and how many passed,
and outputs more details about the failed cases.

You can write your own visualization, if you wish, by iterating through
the ``result.assertions`` property.

## 📜 Assertions

| Method                | Functionality                                             |
|-----------------------|-----------------------------------------------------------|
| ``assert_equals``     | Checks if the actual value equals the expected.           |
| ``assert_not_equals`` | Checks if the actual value does _not_ equal the expected. |
| ``assert_true``       | Short-hand function which checks if the value is true.    |
| ``assert_false``      | The counter-part to ``assert_true``.                      |
| ``assert_null``       | Checks if the actual value is (exactly) null.             |
| ``assert_not_null``   | Checks if the actual value is anything but null.          |
| ``assert_count``      | Checks the size of an array                               |
| ``assert_empty``      | Short-hand to check if an array is empty.                 |

### Full signatures

````GDScript
assert_equals(expected: Variant, actual: Variant, it: String = "")
assert_not_equals(expected: Variant, actual: Variant, it: String = "")
assert_true(actual: bool, it: String = "")
assert_false(actual: bool, it: String = "")
assert_null(actual: Variant, it: String = "")
assert_not_null(actual: Variant, it: String = "")
assert_count(expected: int, iterable: Array, it: String = "")
assert_empty(iterable: Array, it: String = "")
````

## 🌿 Extending

It's easy to add new assertions. The recommended approach is to create
a new class which extends ``TestCase``.

````GDScript
extends TestCase

class_name CustomTestCase
````

Now, if you have already explored the existing ``assert_*`` methods,
you'll have seen that:

- The method must return ``AssertMeta``. This is a resource generated by
  the private helper method ``_assert``.
- The first argument passed to ``_assert`` determines if the assertion has
  passed or not. You won't have to do anything else, _GodotUnit_ packages
  all required information about the assertion, such that it can be displayed
  in the results.
- You must provide expected and actual values to ``_assert``.

Example:

````GDScript
func my_custom_assert(expected: Variant, actual: Variant, it: String = "") -> AssertionMeta:
	return _assert(expected == actual, expected, actual, it)
````

## 📋 Visual test summary

The addon comes with an embeddable scene which can display test summaries
in a neat way.
To use it, you add ``addons/godot-unit/tools/test-summary/TestSummary.tscn``
into the scene you use to run your tests. The next step is to add the results:

````GDScript
@onready var test_summary = $Path/To/TestSummaryScene

func _ready() -> void:
  # Run the tests
  var results = ...
  
  test_summary.results = results
````

## 🔬 Self-testing

_GodotUnit_ has a "self-testing suite", which mainly relies on the
``reflective`` method. It's capable of wrapping an assertion and when
executing the logic, it silences the ordinary result workflow, and creates
its own.
