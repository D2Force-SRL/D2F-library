public without sharing class Exceptions {
    public static AuraHandledException newAuraHandledException(final Exception error) {
        if (error == null) {
            return null;
        }

        AuraHandledException auraHandledException = new AuraHandledException(error.getMessage());
        auraHandledException.setMessage(error.getMessage());

        return auraHandledException;
    }

    public static Map<String, String> getDetails(final Exception error) {
        if (error == null) {
            return null;
        }

        return new Map<String, String>{
            'message' => error.getMessage(),
            'stackTrace' => error.getStackTraceString(),
            'type' => error.getTypeName()
        };
    }
}