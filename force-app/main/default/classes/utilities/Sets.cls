/**
 * @description Utility class for working with sets
 * @author dmitrii.dronov@integrate2cloud.com
 * @version 1.0
 * @group utilities
 */
public without sharing class Sets {
    /**
     * @description Method to check if a set is null or empty
     * @param objects - the set to check
     * @return true if the set is null or empty, false otherwise
     */
    public static Boolean isNullOrEmpty(final Set<Object> objects) {
        return objects == null || objects.isEmpty();
    }

    /**
     * @description Method to check if a set is null or empty
     * @param ids - the set to check
     * @return true if the set is null or empty, false otherwise
     */
    public static Boolean isNullOrEmpty(final Set<Id> ids) {
        return ids == null || ids.isEmpty();
    }

    /**
     * @description Method to check if a set is null or empty
     * @param fields - the set to check
     * @return true if the set is null or empty, false otherwise
     */
    public static Boolean isNullOrEmpty(final Set<SObjectField> fields) {
        return fields == null || fields.isEmpty();
    }

    /**
     * @description Method to check if a set is null or empty
     * @param strings - the set to check
     * @return true if the set is null or empty, false otherwise
     */
    public static Boolean isNullOrEmpty(final Set<String> strings) {
        return strings == null || strings.isEmpty();
    }

        /**
     * @description Method to convert a set of Id values to a string
     * @param ids - the set of Id values to convert
     * @return the string representation of the set
     */
    public static String toString(final Set<Id> ids) {
        if (ids == null) {
            return '()';
        }

        String stringIds = '(';

        for (Id id : ids) {
            stringIds += '\'' + id + '\',';
        }

        return stringIds.removeEnd(',') + ')';
    }

    /**
     * @description Method to convert a set of string values to a string
     * @param strings - `Set<String>`
     * @return `String` - the string representation of the set
     */
    public static String toString(final Set<String> strings) {
        if (strings == null) {
            return '()';
        }

        String stringIds = '(';

        for (String stringValue : strings) {
            stringIds += '\'' + stringValue + '\',';
        }

        return stringIds.removeEnd(',') + ')';
    }

    /**
     * @description Method to convert a set of string values to a set of Id values
     * @param strings - `Set<String>` values to convert
     * @return `Set<Id>` - the set of Id values
     */
    public static Set<Id> toIdSet(final Set<String> strings) {
        if (strings == null) {
            return new Set<Id>();
        }

        Set<Id> ids = new Set<Id>();
        for (String stringId : strings) {
            if (String.isBlank(stringId)) {
                continue;
            }

            try {
                ids.add(Id.valueOf(stringId));
            } catch (Exception error) {
                System.debug(LoggingLevel.ERROR, '[Sets][toIdSet] Error: ' + Exceptions.getDetails(error));
            }
        }

        return ids;
    }
}