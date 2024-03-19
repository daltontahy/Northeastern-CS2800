# jqwik for java

### Creating properities in java 
Properites can be written with @Properity, and must have one or more parameters annotated with @ForAll.

     ## example usage
   *  @Property
   *  boolean evenIntegers(@ForAll int anInt) {
   *    return (anInt % 2) = 0;
   *  }
     

