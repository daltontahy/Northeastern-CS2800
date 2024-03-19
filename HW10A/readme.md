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

### Failure Reporting
jqwik reports 3 things when a property fails:  
   * Relevant exception
   * The property's base parameters
   * The failing sample

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






 




















