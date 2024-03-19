# jqwik for java  
# Part 1

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
As you can see above, the property is written in the form of a *method*, but with the special __@Property__ annotation. This can be use on `public`, `protected`, or `package-scoped` methods. Each property must have one or more parameters, annotated by __@ForAll__.  

Each property method has to either  
     * return a `boolean`  
     * return nothing (`void`)  

At runtime, jqwik will fill in the parameter values 1000 explicit times and test the property method with each parameter set. Any failed attempt will stop the execution and report a failure.  

## Failure Reporting
### Example: property failure
__GRADING NOTE:__ *this example was taken from the official docs to avoid setting up JUnit 5 on my machine. It is not being used as one of my 3 examples, and it is here for thoroughness.*
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

However, this error reporting does have a caveat. If you are using mutable objects, and they are changed in the property, their final state will be reported, not their initial state. this means that it can be tricky to decipher what went wrong,  as finding the exact cause of failure can be more complicated.

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
If you are constraining the generation of parameter types, you annotate the type as you would regularly. This example continues to show the specifics of using predefined java constructs in your parameters. However, what if you want to use custom parameters?  

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
In this example, we were able to "provide" the property with a custom parameter, `numbersOneToTen`. When called, the random inputs generated will adhere to the specification in `numbersOneToTen`.

This adds major flexibility to our code, as we are able to design more specific properties that don't rely on built-in constructs. This library, specifically its ease and flexibility in this aspect, benifits greatly from custom parameters.

## Conclusion
This only scratches the surface with Property Based Testing in a mainstream language such as java. This library has much more to explore, but even now it's clear how benifical it can be.  


<d><d/>
# Part 2
## Why We Should Use jqwik
### Test Coverage
jqwik allows us to expand our test coverage, as it is capable of generating a wide range of test cases automatically. When we use example-based testing, the correctness of our project depends on the examples created by the software enginner(s) developing the project. By automating our test cases, we can uncover potential edge cases, especially for particularly complex programs, that can otherwise be missed. In turn, fatal bugs can be caught in the development stage.

Additionally, improved confidence in our programs will allow us to better market our service, and give consumers more ease of mind when working with us. Reliability is something that mustn't be overlooked, not in any manner.  

### Time Efficiency 
Not only will our engineers be better equipped to write reliable code, but we should expect to see a notable increase in efficency. With the writing of tests being automated, our engineers can focus on implementing solutions rather than checking every step they make. In turn, we will be able to get more done in less time, all while improving the reliability of our software.  

### Organization
As our codebase evolves, we can efficiently rerun tests to ensure that previous functionality remains intact. Additionally, these tests can serve as a type of documentation that highlights the intended behavior of our code. As for implementing jqwik, there is extensive documentation it is very well supported. It will be relatively simple to work into our our current workflow.  
<d><d/>
## Potential Drawbacks
### Learning Curve
Engineers may need time to familiarize themselves with a new library, as well as the framework of property based testing. Additionally, when a test fails, it could be harder to pinpoint the exact error. Finding an error exists is the most important thing to us, but it is not an easy process to find what *exactly* went wrong.

### Runtime
Property Based Testing uses significantly more resources, as we are testing many different cases that wouldn't otherwise be observed. For complex properties and large datasets, we could see a steep increase in the execution times, which can lead to a slower development process.

## Conclusion
It is essential that we carefully evaluate all the benifits and drawbacks of implementing jqwik to our workflow, but I believe this is very important to consider in a timely manner. The benifits we would see from increasing the reliability of our software alone are immense, and our team can benifit greatly from the added mechanisms to test their code. I hope you consider this request with a fair perspective, and support this as an improvement to our team.




 




















