package network_data.value;

/* A value type, standing for a string type of value. */
public class StringAtom extends Value {
	private String str;

	public StringAtom(String str) {
		this.str = str;
	}

	/* TODO:
	 * also implement hashCode, as we will be implementing equals below.
	 */
	@Override
	public int hashCode() {
		return 0;
	}
	/* TODO:
	 * can be useful to be able to compare values with v1.equals(v2)
	 * when implementing equals on a binding object.
	 * You can compare the other values (Any, Null) with equals, as they
	 * are singletons and represent a single instantiated entitity.
	 */
	@Override
	public boolean equals(Object obj) {
                if(obj == null || this.str == null) return false;
                if(obj instanceof Value){
                    if(obj instanceof StringAtom)
                        return ((Value)obj).toString().equals(this.str);
                    else if(obj instanceof Any) return false;
                    else return false;
                }else{
                    System.err.println("StringAtom equals error. "
                        + "Received input that is not of type Value.");
                    return false;
                }
	}

	/* TODO:
	 * Implementing the intersect for the Value type will make it easier
	 * to do intersection of corresponding bindings.
	 * 
	 */
	@Override
	public Value intersect(Value v) {
		
		return null;
	}

	@Override
	public String toString() {
		return str;
	}
}