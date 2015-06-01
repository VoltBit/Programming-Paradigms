package network_data;
import java.util.Objects;
import network_data.header.Header;
import network_data.value.Value;

/* Class used to bind a header to a value */
public class Binding {
	private Header header;
	private Value value;
	
	public Binding(Header header, Value value) {
		this.header = header;
		this.value = value;
	}

	public Header getHeader() {
		return header;
	}

	public void setHeader(Header header) {
		this.header = header;
	}

	public Value getValue() {
		return value;
	}

	public void setValue(Value value) {
		this.value = value;
	}
	
	/* TODO if needed, implement hashCode() and equals() methods */
	
        @Override
        public boolean equals(Object obj){
            if(obj instanceof Binding){
                if(((Binding)obj).header.equals(this.header) &&
                        ((Binding)obj).value.equals(this.value)){
                    return true;
                }
                return false;
            } else {
                System.err.println("Binding equals error.");
                return false;
            }
        }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 97 * hash + Objects.hashCode(this.header);
        hash = 97 * hash + Objects.hashCode(this.value);
        return hash;
    }
        
	@Override
	public String toString() {
		return "[" + this.header + ", " + this.value + "]";
	}

}