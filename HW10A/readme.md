# jqwik for java
### A test engine focusing on PBT for JUnit 5

## Creating properities in java 
### Example 1: property with int
```
 import net.jqwik.api.*;
 import org.assertj.core.api.*;

 class PropertyExample {

   // example property for even integers using jqwik
   @Property
   boolean evenIntegers(@ForAll int num) {
     return (num % 2) == 0;
   }
  }
```
As you can see above, the property is written in the form of a *method*, but with the special __@Property__ annotation. This
can be use on `public`, `protected`, or `package-scoped` methods. Each property must have one or more parameters, annotated
by __@ForAll__.  

Each property method has to either  
     * return a `boolean`  
     * return nothing (`void`)  

At runtime, jqwik will fill in the parameter values 1000 explicit times and test the property method with each parameter set.
Any failed attempt will stop the execution and report a failure.  

## Failure Reporting
### Example: property failure
__GRADING NOTE:__ *this example was taken from the official docs to avoid setting up JUnit 5 on my machine. It is not being used
as one of my 3 examples, and it is here for thoroughness.*
```
  @Property
	 void lengthOfConcatenatedStringIsGreaterThanLengthOfEach(
		@ForAll String string1, @ForAll String string2
	 ) {
	  	String conc = string1 + string2;
		  Assertions.assertThat(conc.length()).isGreaterThan(string1.length());
	  	Assertions.assertThat(conc.length()).isGreaterThan(string2.length());
 	}
```
__FAILURE REPORTED:__
```
PropertyBasedTests:lengthOfConcatenatedStringIsGreaterThanLengthOfEach = 
  java.lang.AssertionError: 
    Expecting:
     <0>
    to be greater than:
     <0> 
                              |-----------------------jqwik-----------------------
tries = 16                    | # of calls to property
checks = 16                   | # of not rejected calls
generation = RANDOMIZED       | parameters are randomly generated
after-failure = SAMPLE_FIRST  | try previously failed sample, then previous seed
when-fixed-seed = ALLOW       | fixing the random seed is allowed
edge-cases#mode = MIXIN       | edge cases are mixed in
edge-cases#total = 4          | # of all combined edge cases
edge-cases#tried = 0          | # of edge cases tried in current run
seed = -2370223836245802816   | random seed to reproduce generated values

Shrunk Sample (<n> steps)
-------------------------
  string1: ""
  string2: ""

Original Sample
---------------
  string1: "乮��깼뷼檹瀶�������የ뷯����ঘ꼝���焗봢牠"
  string2: ""

  Original Error
  --------------
  java.lang.AssertionError: 
    Expecting:
     <29>
    to be greater than:
     <29>
jqwik reports 3 things when a property fails:  
   * Relevant exception
   * The property's base parameters
   * The failing sample
```
jqwik reports 3 main things here:  
  * The relevant exception
  * the property's base parameters
  * the failing sample



## Example 2: property with parameterized types 
```
 import net.jqwik.api.*;
 import org.assertj.core.api.*;

 class PropertyExample {

   // example property with parameterized parameter.
   @Property
   boolean stringsLessThanFour(@ForAll @Size(min=1) List<@StringLength(min=2) String> LoStr ) {
     // you can implemet any whatever test you would like here, for simplicity it's blank
   }
 }
```
If you are constraining the generation of parameter types, you annotate the type as you would regularly.
This example continues to show the specifics of using predefined java constructs in your parameters. However,
what if you want to use custom parameters?  

## Example 3: arbitrary provider methods
```
  @Provide
  Arbitrary<Integer> numbersOneToTen() {
    return Arbitraries.integers().between(1,10);
  }

  @Property
  boolean evenNumbersBetweenOneAndTen(@ForAll("numbersOneToTen") int num) {
    return (num % 2) == 0;
  }
```
In this example, we were able to "provide" the property with a custom parameter, `numbersOneToTen`. When called, the random inputs generated
will adhere to the specification in `numbersOneToTen`. This adds major flexibility to our code, as we are able to design more specific properties
that don't rely on built-in constructs.







 




















