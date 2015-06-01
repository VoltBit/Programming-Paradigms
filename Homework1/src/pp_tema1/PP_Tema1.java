package pp_tema1;

import decorator.Const;
import java.util.ArrayList;
import java.util.List;
import network_data.Binding;
import network_data.Pattern;
import network_data.header.Dst;
import network_data.header.Port;
import network_data.header.Src;
import network_data.value.Any;
import network_data.value.Null;
import network_data.value.StringAtom;


public class PP_Tema1 {
    
    static private List<Binding> cl1, cl2, cl3, clp;
    static private Pattern p1, p2, p3, pp1, pp2, pp3, pp4, pp;
    
    public static void testing(){
                cl1 = new ArrayList<Binding>() {{ 
			add(new Binding(Src.getInstance(), new StringAtom("a")));
			add(new Binding(Dst.getInstance(), Any.getInstance()));
			add(new Binding(Port.getInstance(), Any.getInstance()));
			}};
		
		cl2 = new ArrayList<Binding>() {{ 
			add(new Binding(Src.getInstance(), new StringAtom("b")));
			add(new Binding(Dst.getInstance(), Any.getInstance()));
			add(new Binding(Port.getInstance(), Any.getInstance()));
			}};
			
		cl3 = new ArrayList<Binding>() {{ 
			add(new Binding(Src.getInstance(), Any.getInstance()));
			add(new Binding(Dst.getInstance(), new StringAtom("c")));
			add(new Binding(Port.getInstance(), Any.getInstance()));
			}};
			
		clp = new ArrayList<Binding>() {{ 
			add(new Binding(Src.getInstance(), Any.getInstance()));
			add(new Binding(Dst.getInstance(), Any.getInstance()));
			add(new Binding(Port.getInstance(), new StringAtom("x")));
			}};
								

		pp = new Pattern(clp);
		p1 = new Pattern(cl1);
		p2 = new Pattern(cl2);
		p3 = new Pattern(cl3);
		
		List<Binding> temp = new ArrayList<>();
		temp.addAll(cl1);
		temp.addAll(cl2);
		pp2 = new Pattern(temp);
		temp.clear();
		temp.addAll(cl3);
		temp.addAll(cl1);
		pp3 = new Pattern(temp);
		temp.clear();
		temp.addAll(cl1);
		temp.addAll(cl2);
		temp.addAll(cl3);
		pp4 = new Pattern(temp);
        
//                System.out.println(pp3.toString());
                System.out.println("p1 = " + p1.toString());
                System.out.println("p2 = " + p2.toString());
                System.out.println("p3 = " + p3.toString());
                System.out.println("p1 + p2 = pp2 " + pp2.toString());
                System.out.println("p1 + p3 = pp3 " + pp3.toString());
//                System.out.println("p1 + p2 + p3 = pp4 " + pp4.toString());
                p1.subset(pp3);
                pp3.subset(p1);
                Pattern.mostGeneralPattern().subset(pp3);
                
    }

    private void testing2(){
        
    }
    
    public static void main(String[] args) {
        testing();
        new PP_Tema1().testing2();
    }

}
