/**
 * @description Virtual domain class for sObjects
 * @author dmitrii.dronov@integrate2cloud.com
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
                if (record.get(field) == null) {
                    continue;
                }

                ids.add((Id) record.get(field));
            }
        }

        return ids;
    }

    /**
     * @description Method to get the set of Id values for the specified field and value
     * @param idField - sObject field
     * @param valueField - sObject field
     * @param expectedValue - expected value
     */
    public Set<Id> getIdFieldValuesByFieldValue(final SObjectField idField, final SObjectField valueField, final Object expectedValue) {
        return this.getIdFieldValuesByFieldsValues(idField, new Set<SObjectField>{ valueField }, new Set<Object>{ expectedValue });
    }

    /**
     * @description Method to get the set of Id values for the specified fields and values
     * @param idField - sObject field
     * @param valueFields - set of sObject fields
     * @param expectedValues - set of expected values
     * @return Set of Id values
     */
    public Set<Id> getIdFieldValuesByFieldsValues(
        final SObjectField idField,
        final Set<SObjectField> valueFields,
        final Set<Object> expectedValues
    ) {
        if (idField == null || Sets.isNullOrEmpty(valueFields) || Sets.isNullOrEmpty(expectedValues)) {
            return new Set<Id>();
        }

        Set<Id> ids = new Set<Id>();
        for (SObject record : (List<SObject>) this.getRecords()) {
            for (SObjectField valueField : valueFields) {
                if (expectedValues.contains(record.get(valueField))) {
                    if (record.get(idField) == null) {
                        continue;
                    }
                    ids.add((Id) record.get(idField));
                }
            }
        }

        return ids;
    }

    /**
     * @description Method to group record ids by string field value
     * @param field - `SObjectField`
     * @return `Map<String, Id>` - record ids by string field values
     */
    public Map<String, Id> groupRecordIdsByStringFieldValue(final SObjectField field) {
        if (field == null) {
            return new Map<String, Id>();
        }

        Map<String, Id> result = new Map<String, Id>();
        for (SObject record : (List<SObject>) this.getRecords()) {
            final String fieldValue = (String) record.get(field);
            if (String.isBlank(fieldValue)) {
                continue;
            }

            result.put(fieldValue, (Id) record.Id);
        }

        return result;
    }

    /**
     * @description Domain constructor class
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
