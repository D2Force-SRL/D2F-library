/**
 * @description Virtual domain class for sObjects
 * @author dmitrii.dronov@d2force.com
 * @group domains
 * @version 1.0
 * @see Objects
 */
public inherited sharing virtual class SObjects extends Objects {
    private List<SObject> records;

    /**
     * @description Constructor
     * @param records - list of sObjects
     */
    public SObjects(final List<SObject> records) {
        super(records);
        this.records = records == null ? new List<SObject>() : records;
    }

    /**
     * @description Method to get the list of sObjects
     * @return list of sObjects
     */
    public List<SObject> getRecords() {
        return this.records;
    }

    /**
     * @description Method to get the set of Id values for the specified field
     * @param field - sObject field
     * @return Set of Id values
     */
    public Set<Id> getIdFieldValues(final SObjectField field) {
        if (field == null) {
            return new Set<Id>();
        }

        return getIdFieldValues(new Set<SObjectField>{ field });
    }

    /**
     * @description Method to get the set of Id values for the specified fields
     * @param fields - set of sObject fields
     * @return Set of Id values
     */
    public Set<Id> getIdFieldValues(final Set<SObjectField> fields) {
        Set<Id> ids = new Set<Id>();
        if (Sets.isNullOrEmpty(fields)) {
            return ids;
        }

        for (SObject record : (List<SObject>) this.getRecords()) {
            for (SObjectField field : fields) {
                ids.add((Id) record.get(field));
            }
        }

        return ids;
    }

    /**
     * @description Domain constructor class
     * @author dmitrii.dronov@d2force.com
     * @see IDomainConstructor
     * @version 1.0
     */
    public class Constructor implements IDomainConstructor {
        /**
         * @description Method to construct a domain object
         * @param records - list of sObjects
         * @return domain object
         */
        public Object newInstance(final List<Object> records) {
            return new SObjects((List<SObject>) records);
        }
    }
}
