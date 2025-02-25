public class Stack {
    private Element top;
    private int size;

    public Stack() {
        this.top = null;
        this.size = 0;
    }

    public void push(Element e) {
        e.setNext(top);            
        top = e;
        size++;
    }

    public Element top() {
        return top;
    }

    public boolean pop() {
        top = top.getNext();
        size--;
        return true;
    }

    public void print() {
        System.out.println(isEmpty() ? "print - Stack is empty" :
            "print - Stack contains: " + getElementsAsString() + " top Element = " + top.getValue());
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public int size() {
        return size;
    }

    // clear function: just dereferencing the top element, garbage collector takes care of the rest
    public void clear() {
        top = null;
        size = 0;
    }

    private String getElementsAsString() {
        StringBuilder sb = new StringBuilder();
        for (Element current = top; current != null; current = current.getNext()) {
            sb.append(current.getValue()).append(", ");
        }
        return sb.toString().trim();
    }
}
