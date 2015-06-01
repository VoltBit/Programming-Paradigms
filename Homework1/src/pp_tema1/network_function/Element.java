package network_function;
import java.util.List;

import network_data.Pattern;
import reachability.Visitable;

/* THE CONTENTS OF THIS FILE SHOULD NOT BE CHANGED */

/* Interface that models network element traits */
public interface Element extends Visitable {
	
	public List<Element> get_successors();
	public Pattern apply(Pattern f);
	
}
