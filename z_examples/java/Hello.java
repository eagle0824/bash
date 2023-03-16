
public class Hello {

    public static void main(String[] args) {
        System.out.println("===>hello");
        int a = 0x08;
        int b = 0x09;
        int d = a << 4 | b;
        int e = d >> 4;
        int f = d & 0x0f;
        System.out.println("===>hello " + String.format("%x", d));
        System.out.println("===>hello " + String.format("%x", e));
        System.out.println("===>hello " + String.format("%x", f));

        boolean stateA = false; 
        boolean stateB = false;

        System.out.println("===>hello " + (!(stateA ^ stateB)));
    }

}
