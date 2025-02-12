/**
 * @description Abstract class for selectors
 * @author dmitrii.dronov@d2force.com
 * @version 1.0
 * @group selectors
 */
public inherited sharing abstract class Selector {
    /**
     * @description Constructor
     */
    public Selector() {
        return;
    }

    /**
     * @description Interface for selector constructors
     * @author dmitrii.dronov@d2force.com
     * @version 1.0
     */
    public interface ISelectorConstructor {
        /**
         * @description Method to create an instance of a selector
         * @return an instance of a selector
         */
        Selector newInstance();
    }
}