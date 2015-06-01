package reachability;
import java.util.List;

import network_function.Element;

/* THE CONTENTS OF THIS FILE SHOULD NOT BE CHANGED */

/* The visitor is going to update the visitable when the
 * visitable calls visit with it in accept.
 */
public interface Visitor {
	public List<Element> visit(Element e);
}