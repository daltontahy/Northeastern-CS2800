# jqwik for java

## Creating properities in java 
### Example 1: property with int
```
 import net.jqwik.api.*;
 import org.assertj.core.api.*;

 class PropertyExample {

   // example property for even integers using jqwik
   @Property
   boolean evenIntegers(@ForAll int anInt) {
     return (anInt % 2) = 0;
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
jqwik reports 3 things when a property fails:  
   * Relevant exception
   * The property's base parameters
   * The failing sample

### Example 2: property with String
```
 import net.jqwik.api.*;
 import org.assertj.core.api.*;

 class PropertyExample {

   // example property for strings less than the length of 4
   @Property
   boolean stringsLessThanFour(@ForAll String str) {
     return str.length() < 4;
   }
 }
```
 




















