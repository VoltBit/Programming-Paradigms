package network_function;

import java.util.ArrayList;
import java.util.List;

/* THE CONTENTS OF THIS FILE SHOULD NOT BE CHANGED */

public class Network {
	
	private static final String DEVICE_DELIM = ";";
	private static final String NET_DELIM = ">";
	private static final String NEIGH_DELIM = ",";
		
	public static List<Element> makeNetwork(String input) {
		List<Element> devices = new ArrayList<>();
		String device_s = input.split(NET_DELIM)[0];
		String net = input.split(NET_DELIM)[1];
		
		/* Construct individual devices */
		for(String d_input : device_s.split(DEVICE_DELIM)) {
			devices.add(DeviceParser.makeDevice(d_input));
		}
	
		/* Make connections between devices */
		int i = 0;
		for(String neighs : net.split(DEVICE_DELIM)) {
			/* Check if device has successors and link them */
			if(!neighs.equals("_")) {
				List<Element> successors = new ArrayList<>();
				
				for(String neigh : neighs.split(NEIGH_DELIM)) {
					successors.add(devices.get(Integer.parseInt(neigh)));
				}
				
				((Device)devices.get(i)).set_successors(successors);
			}
			i++;
		}
		
		return devices;
	}
}