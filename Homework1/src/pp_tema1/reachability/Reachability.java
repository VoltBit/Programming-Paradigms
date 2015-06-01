package reachability;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import network_data.Pattern;
import network_data.header.Port;
import network_data.value.StringAtom;
import network_function.Element;
import network_function.Network;

/*
 * Reachability is a Visitor and Element is a Visitable.
 * The idea is that the network Element (or device) lets itself be visited by the
 * Reachability, as the Reachability offers access to the patterns that visited
 * the device and to the current pattern that enters the device
 */
public class Reachability implements Visitor {
	
	/* This map will contain, for each element, the list of reachable patterns, at all steps 
	 * at the end of the visiting process, we use this structure to see the results 
	 */
	private Map<Element,List<Pattern>> reach = new HashMap<>();
	
	/* List of devices that form the network, obtained by parsing input */
	private List<Element> devices = null;
	
	/* A set of all patterns that reach destination */
	private Set<Pattern> reachable = new HashSet<Pattern>();
	
	/* Call reachability with:
	 * - input: a special input, parsable by Network
	 * - srcPort, dstPort are some strings telling us on which port to start and when to stop.
	 */
	public Reachability (String input, String srcPort, String dstPort){
		
		/* build the start pattern representing network packets with the given src port */
		Pattern initial = Pattern.mostGeneralPattern().rewrite(Port.getInstance(), new StringAtom(srcPort));
		
		/* create the network (list of devices) using the input */
		devices = Network.makeNetwork(input);
		
		/* TODO: 
		 * trigger the visitor pattern by doing accepts on all devices; 
		 * only those that will "match" the initial pattern will continue and
		 * will call accept on their successors and so on
		 * 
		 */
		
		/* TODO: 
		 * after the acceptance, we've finished exploring all devices,
		 * the "reach" is completed and converged.
		 * Reachability has finished, we can now iterate through the history and 
		 * get the patterns that match the destination port.
		 * Fill this.reachable
		 *   
		 * OBS: you might need to refer to the intersections with aux pattern 
		 */
		Pattern aux = Pattern.mostGeneralPattern().rewrite(Port.getInstance(), new StringAtom(dstPort));
		
	}
	
	public Set<Pattern> getReachable() {
		return this.reachable;
	}

	/* TODO:
	 * - get the current pattern that needs to be processed by
	 *   the visitable device
	 * - save the pattern in the history of that device
	 * - that pattern "goes into" the device and a modified pattern "exits"
	 * - find all the neighbors of the device that haven't been visited yet or 
	 *   haven't been visited by the current pattern and save them
	 *   OBS: if no such neighbor is found or if the modified pattern is empty,
	 *   an empty list is returned, so this "branch" of recursion will end
	 *   
	 * The list of successors is used by the visited device (Element). It will call
	 * accept on each of them, they will be visited and will call accept on their 
	 * successors and so on.
	 * 
	 */
	@Override
	public List<Element> visit(Element e){
		
		List<Element> next_hops = new LinkedList<>();
		
		/* TODO: */
		
		return next_hops;
	}
}