package network_function;
import java.util.LinkedList;
import java.util.List;

import network_data.Pattern;
import reachability.Visitor;
import decorator.Decorator;

public class Device implements Element {
	
	Decorator d;
	/* list of all device successors */
	List<Element> successors = new LinkedList<>();
	
	public Device (Decorator d){
		this.d = d;
	}
	
	@Override
	public List<Element> get_successors(){
		return successors;
	}
	
	public void set_successors(List<Element> successors){
		this.successors = successors;
	}
	
	/* TODO
	 * evaluate the decorator by sending the current pattern as parameter.
	 * the decorator encodes an expression, whose evaluation possibly depends on f;
	 */
	public Pattern apply (Pattern f){
		return null;
	}
	/*
	 * this is the visitable part. The visitor is responsible for generating the successors, and for keeping global state.
	 * The visitable simply propagates acceptance to those successors computed by the visitor
	 */
	
	/* TODO: a device accepts to be visited by a visitor:
	 * - visit device by visitor will return a list of device successors
	 *   (see how the visitor should fill up the list of successors in the comments
	 *    from Reachability class)
	 * - each successor should then also accept the visitor.
	 */
	@Override
	public void accept(Visitor v){
	}	
}
