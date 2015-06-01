package network_function;

import java.util.ArrayList;
import java.util.List;

import network_data.Binding;
import network_data.Pattern;
import network_data.header.Dst;
import network_data.header.Port;
import network_data.header.Src;
import network_data.value.Any;
import network_data.value.StringAtom;
import decorator.Const;
import decorator.Decorator;
import decorator.Id;
import decorator.Intersection;
import decorator.Reunion;
import decorator.Rewrite;

/* THE CONTENTS OF THIS FILE SHOULD NOT BE CHANGED */

public class DeviceParser {
	
	private static final String BIG_DELIM = "!";
	private static final String SMALL_DELIM = "/";
	private static final String INSIDE_DELIM = ",";
	
	public static Device makeDevice(String input) {
		
		String[] allow_modif = input.split(BIG_DELIM);
		String[] allowed = allow_modif[0].split(SMALL_DELIM);
		String[] modif = allow_modif[1].split(SMALL_DELIM);
		List<Binding> bindings = new ArrayList<>();
		
		/* Construct the pattern which says what patterns the device allows 
		 * Use the first part of the input
		 */
		for(final String src : allowed[0].split(INSIDE_DELIM)) {
			for(final String dst : allowed[1].split(INSIDE_DELIM)) {
				for(final String port : allowed[2].split(INSIDE_DELIM)) {
					final Binding sb, db, pb;
					if(src.equals("_"))
						sb = new Binding(Src.getInstance(), Any.getInstance());
					else
						sb = new Binding(Src.getInstance(), new StringAtom(src));
					
					if(dst.equals("_"))
						db = new Binding(Dst.getInstance(), Any.getInstance());
					else
						db = new Binding(Dst.getInstance(), new StringAtom(dst));
					
					if(port.equals("_"))
						pb = new Binding(Port.getInstance(), Any.getInstance());
					else
						pb = new Binding(Port.getInstance(), new StringAtom(port));
					
					bindings.add(sb);
					bindings.add(db);
					bindings.add(pb);
				}
			}
		}
		
		Pattern allowPattern = new Pattern(bindings);
		
		/* Construct the decorator that models the behavior of the device 
		 * Start with the decorator for "allowed" part 
		 */
		Decorator i = new Intersection(new Const(allowPattern), new Id());
		
		/* Wrap with rewrite functions */
		if(!modif[0].equals("_"))
			i = new Rewrite(new Binding(Src.getInstance(), new StringAtom(modif[0])), i);
		if(!modif[1].equals("_"))
			i = new Rewrite(new Binding(Dst.getInstance(), new StringAtom(modif[1])), i);
		
		/* Wrap with port rewrite functions and duplicate using reunion
		 * for each port to rewrite
		 */
		Decorator big = new Const(new Pattern(new ArrayList<Binding>()));
		for(String port : modif[2].split(INSIDE_DELIM)) {
			big = new Reunion(big,  new Rewrite(new Binding(Port.getInstance(), new StringAtom(port)), i));
		}
	
		return new Device(big);
	}
}