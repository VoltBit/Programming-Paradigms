package network_data;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import network_data.header.Dst;

import network_data.header.Header;
import network_data.header.Port;
import network_data.header.Src;
import network_data.value.Any;
import network_data.value.Value;

public class Pattern {

	/* Build the pattern using the bindings in the list allBindings.
	 * The bindings in the list are ordered in the following form:
	 * src_bind1, dst_bind1, port_bind1, src_bind2, dst_bind2, port_bind2, ...
	 */
    
    private ArrayList<LinkedHashSet<Binding>> fieldTable = new ArrayList<>();
    private ArrayList<Binding> bindings = new ArrayList();

    private LinkedHashSet<ArrayList<Binding>> bindingSetList = new LinkedHashSet<>();
    
    public Pattern(List<Binding> allBindings) {
        fieldTable = new ArrayList<>();
        fieldTable.add(new LinkedHashSet<Binding>());
        fieldTable.add(new LinkedHashSet<Binding>());
        fieldTable.add(new LinkedHashSet<Binding>());
        ArrayList aux = new ArrayList();
        aux.addAll(allBindings);
        this.bindingSetList.add(aux);
        this.bindings.addAll(allBindings);
        this.parseBindings();
    }
    
    public boolean is_empty() {
        return bindings.isEmpty();
    }
    
    private void parseBindings(){
        Iterator<Binding> itr = this.bindings.iterator();        
        
//        int counter = 0;
//        while(itr.hasNext()){
//            ArrayList<Binding> auxList = new ArrayList();
//            if(counter == 3){
//                this.bindingSetList.add(auxList);
//                auxList = new ArrayList<Binding>();
////                auxList.clear();
//                counter = 0;
//            }
//            auxList.add(itr.next());
//            counter++;
//        }
        
        Binding aux;
        while(itr.hasNext()){
            aux = itr.next();
            if(aux.getHeader() instanceof Src) this.fieldTable.get(0).add(aux);
            else if(aux.getHeader() instanceof Dst) this.fieldTable.get(1).add(aux);
            else if(aux.getHeader() instanceof Port) this.fieldTable.get(2).add(aux);
            else{
                System.err.println("Pattern parse bidings error (wrong format).");
                break;
            }
        }
        /* the code block below removes Any value if there are more spceific 
            entries
        */
        aux = new Binding(Src.getInstance(), Any.getInstance());
        if(this.fieldTable.get(0).size() > 1 && this.fieldTable.get(0).contains(aux)){
            this.fieldTable.get(0).remove(aux);
//            this.bindings.remove(aux);
        }
        aux = new Binding(Dst.getInstance(), Any.getInstance());
        if(this.fieldTable.get(1).size() > 1 && this.fieldTable.get(1).contains(aux)){
            this.fieldTable.get(1).remove(aux);
//            this.bindings.remove(aux);
        }
        aux = new Binding(Port.getInstance(), Any.getInstance());
        if(this.fieldTable.get(2).size() > 1 && this.fieldTable.get(2).contains(aux)){
            this.fieldTable.get(2).remove(aux);
//            this.bindings.remove(aux);
        }
        this.bindings.clear();
        this.bindings.addAll(this.fieldTable.get(0));
        this.bindings.addAll(this.fieldTable.get(1));
        this.bindings.addAll(this.fieldTable.get(2));
        /* TODO: check what happens whith Null types (delete all other values) */
    }
    
    public Set getSources(){
        return this.fieldTable.get(0);
    }
    
    public Set getDestinations(){
        return this.fieldTable.get(1);
    }
    
    public Set getPorts(){
        return this.fieldTable.get(2);
    }
    
    public static boolean hasAny(Set toCheck){
//        if(toCheck.size() > 1) return false;
//        else{
            Iterator<Binding> itr = ((LinkedHashSet)toCheck).iterator();
//            Binding auxBind;
            while(itr.hasNext())
                if(itr.next().getValue().equals(Any.getInstance())) return true;
//        }
        return false;
    }

    /**
     * Tells if a set of bindings contains only one binding of value Any.
     * @param toCheck - set of bindings
     * @return true for yes, false for no
     */
    
    public boolean isAny(Set toCheck){
        if(((LinkedHashSet)toCheck).size() == 1 && hasAny(toCheck)) return true;
        return false;
    }
    
    public static Pattern mostGeneralPattern() {

        /* TODO
         * pattern which contains bindings with each value of header
         * set to 'Any' : [Src:Any, Dst:Any, Port:Any]
         */
        ArrayList<Binding> generalBindings = new ArrayList();
        generalBindings.add(new Binding(Src.getInstance(), Any.getInstance()));
        generalBindings.add(new Binding(Dst.getInstance(), Any.getInstance()));
        generalBindings.add(new Binding(Port.getInstance(), Any.getInstance()));

        return new Pattern(generalBindings);
    }

    public Pattern intersect(Pattern q) {

        /* TODO 
         * intersection of two patterns
         * Use deepClone() ! 
         */
        int i;
        Pattern curentPattern = this.deepClone();
        
        return null;
    }

    public Pattern reunion(Pattern q) {

            /* TODO
             * perform reunion of 'this' and q pattern
             */
            return null;
    }

    public boolean checkExpanded(Pattern pch){
        int i;
        ArrayList<Binding> aux1 = new ArrayList<Binding>();
        ArrayList<Binding> aux2 = new ArrayList<Binding>();
        Iterator subset = this.bindingSetList.iterator();
        Iterator set;
        boolean check;
        while(subset.hasNext()){
            set = pch.bindingSetList.iterator();
            aux1 = (ArrayList<Binding>) subset.next();
            check = false;
            while(set.hasNext()){
                aux2 = (ArrayList<Binding>) set.next();
                if(aux2.containsAll(aux1)){
                    check = true;
                    System.out.println("Found: " + aux1 + " Here: " + aux2);
                    break;
                }
            }
            if(check == false) return false;
//            if(!pch.bindingSetList.contains(aux1)){
//                System.out.println("Not found: " + aux1);
//                return false;
//            }
        }
        return true;
    }
    
    public boolean checkCompact(Pattern pch){
        boolean checkSrc = pch.getSources()
                .contains(new Binding(Src.getInstance(), Any.getInstance()));
        boolean checkDst = pch.getDestinations()
                .contains(new Binding(Dst.getInstance(), Any.getInstance()));
        boolean checkPort = pch.getPorts()
                .contains(new Binding(Port.getInstance(), Any.getInstance()));
        /*  if all headers have value Any then the binding set is the general
            one and any other set is its subset
        */
        if(checkSrc && checkDst && checkPort) return true;
        /*  check to see if all src headers from current pattern can be found in
            the src headers of received pattern
        */
        if(!checkSrc){
            LinkedHashSet<Binding> aux = (LinkedHashSet<Binding>) pch.getSources();
            Iterator<Binding> srcVals = this.getSources().iterator();
            while(srcVals.hasNext()){
                if(!aux.contains(srcVals.next())) return false;
            }
        }
        if(!checkDst){
            LinkedHashSet<Binding> aux = (LinkedHashSet<Binding>) pch.getDestinations();
            Iterator<Binding> dstVals = this.getSources().iterator();
            while(dstVals.hasNext()){
                if(!aux.contains(dstVals.next())) return false;
            }
        }
        if(!checkPort){
            LinkedHashSet<Binding> aux = (LinkedHashSet<Binding>) pch.getPorts();
            Iterator<Binding> portVals = this.getSources().iterator();
            while(portVals.hasNext()){
                if(!aux.contains(portVals.next())) return false;
            }
        }
        return true;
    }
    
    public boolean subset(Pattern q) {

            /* TODO
             * check if 'this' is subset of pattern q
             */
            boolean ch1 = checkExpanded(q);
            boolean ch2 = checkCompact(q);
            System.out.println("Expanded: " + ch1 + "\t\tCompact: " + ch2);
        return ch1 || ch2;
    }

    public Pattern rewrite(Header h, Value v){

            /* TODO
             * rewrite value of header h in 'this' pattern
             * use deepClone() ! 
             */
            Pattern clonePat = this.deepClone();
            ArrayList<Binding> cloneBds = clonePat.getBindings();
            Iterator<Binding> itr = cloneBds.iterator();
            Binding toWrite = new Binding(h,v);
            /* remove all bindings that have header h */
            Binding aux;
            while(itr.hasNext()){
                aux = itr.next();
                if(aux.getHeader().equals(h))
                    this.bindings.remove(aux);
            }
            if(h instanceof Src){
                this.getSources().clear();
                this.getSources().add(new Binding(h, v));
            } else if(h instanceof Dst){
                this.getDestinations().clear();
                this.getDestinations().add(new Binding(h, v));
            } else if(h instanceof Port){
                this.getPorts().clear();
                this.getPorts().add(new Binding(h, v));
            }
            return null;
    }

    @Override
    public int hashCode() {
            /* TODO */
            return 0;
    }
    /* TODO:
     * Two patterns are equal when they represent the same set of network packets.
     * Hint: You should implement this after the above functions were
     * implemented and use them.
     */
    @Override
    public boolean equals(Object obj) {
            /* TODO */
            /* two patterns are equal if each of them is a subset of the other */
            if(obj == null || this == null) return false;
            return ((Pattern)obj).subset(this) && this.subset((Pattern)obj);
    }

    /* The deepClone is needed because tests and code in general
     * considers that when doing o1.intersect(o2), a new object
     * is created, and that o1 is not affected.
     */
    public Pattern deepClone() {
        ArrayList cloneList = new ArrayList();
        cloneList.addAll(this.bindings);
        Pattern clone = new Pattern(cloneList);
        return clone;
    }

    public ArrayList getBindings(){
        return this.bindings;
    }
    
    /* Display a pattern. */
    @Override
    public String toString(){
        System.out.println(this.bindings.toString());
        return this.bindingSetList.toString();
    }
}
	