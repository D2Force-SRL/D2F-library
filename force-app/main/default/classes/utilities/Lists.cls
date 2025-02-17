public without sharing class Lists {
    public static Boolean isNullOrEmpty(final List<Object> objects) {
        return objects == null || objects.isEmpty();
    }

    public static List<String> toStrings(final List<SObjectField> fields) {
        if (fields == null) {
            return new List<String>();
        }

        List<String> strings = new List<String>();

        for (SObjectField field : fields) {
            strings.add(field.getDescribe().getName());
        }

        return strings;
    }
}