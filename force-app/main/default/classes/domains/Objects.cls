/**
 * @description Abstract domain base class
 * @author dmitrii.dronov@d2force.com
 * @version 1.0
 * @group domains
 */
public without sharing abstract class Objects {
    private List<Object> objects;

    /**
     * @description Constructor
     * @param objects - list of objects
     */
    public Objects(final List<Object> objects) {
        this.objects = objects == null ? new List<Object>() : objects;
    }

        /**
     * @description Get list of objects
     * @return `List<Object>`
     */
    protected List<Object> getObjects() {
        return this.objects;
    }

    /**
     * @description Domain constructor class interface
     */
    public interface IDomainConstructor {
        /**
         * @description Method to construct a domain instance
         * @param objects - list of objects
         * @return domain instance
         */
        Object newInstance(final List<Object> objects);
    }
}
