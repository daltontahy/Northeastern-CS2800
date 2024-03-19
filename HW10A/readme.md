# jqwik for java

### Creating properities in java 
## Example 1
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
As you can see above, the property is written in the form of a *method*, but with the special @Property annotation. This
can be use on `public`, `protected`, or `package-scoped` methods. Each property must have one or more parameters, annotated
by @ForAll.





