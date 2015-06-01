package decorator;

import network_data.Binding;
import network_data.Pattern;

/*
 * Rewrite decorator
 */
public class Rewrite implements Decorator {

	Decorator d; Binding b;
	public Rewrite (Binding b, Decorator d){
		/* TODO: implement constructor */
	}
	
	@Override
	public Pattern execute(Pattern f) {
		/* TODO: implement evaluation */
		/* evaluate decorator, then perform rewrite using the binding */
		
		return null;
	}
	
}