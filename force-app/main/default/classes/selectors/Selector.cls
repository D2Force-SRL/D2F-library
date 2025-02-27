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

    public abstract SObjectType getSObjectType();

    public abstract List<SObjectField> getSObjectFields();

    /**
     * @description Method to select records by ids
     * @param ids - `Set<Id>`
     * @return `List<SObject>` - list of sObjects
     */
    public virtual List<SObject> selectByIds(final Set<Id> ids) {
        if (ids == null || ids.isEmpty()) {
            return new List<SObject>();
        }

        String query =
            'SELECT ' +
            String.join(Lists.toStrings(this.getSObjectFields()), ', ') +
            ' FROM ' +
            this.getSObjectType().getDescribe().getName() +
            ' WHERE Id IN ' +
            Sets.toString(ids);

        return Database.query(query);
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
