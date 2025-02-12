public without sharing virtual class TriggerHandler {
    protected SObjectType sObjectType;

    private System.TriggerOperation operationType;

    private List<SObject> newRecords;
    private Map<Id, SObject> newRecordsByIds;
    private Map<Id, SObject> oldRecordsByIds;

    public TriggerHandler() {
        this.setTriggerContext();
    }

    public TriggerHandler(final SObjectType sObjectType) {
        this.setSObjectType(sObjectType);
        this.setTriggerContext();
    }

    public TriggerHandler setSObjectType(final SObjectType sObjectType) {
        this.sObjectType = sObjectType;
        return this;
    }

    public List<SObject> getNewRecords() {
        return this.newRecords;
    }

    public Map<Id, SObject> getNewRecordsByIds() {
        return this.newRecordsByIds;
    }

    public SObject getNewRecord(final Id recordId) {
        if (this.getNewRecordsByIds() == null) {
            return null;
        }

        return this.getNewRecordsByIds().get(recordId);
    }

    public SObject getOldRecord(final Id recordId) {
        if (this.getOldRecordsByIds() == null) {
            return null;
        }

        return this.getOldRecordsByIds().get(recordId);
    }

    public Map<Id, SObject> getOldRecordsByIds() {
        return this.oldRecordsByIds;
    }

    public Map<Id, Set<Schema.SObjectField>> getChangedRetainedFieldsByRecordIds(
        final Set<Schema.SObjectField> fieldsToRetain
    ) {
        Map<Id, Set<SObjectField>> changedRetainedFieldsByRecordIds = new Map<Id, Set<SObjectField>>();

        for (SObject newRecord : this.getNewRecords()) {
            Set<SObjectField> changedDeltaFields = this.getChangedRetainedFields(
                newRecord,
                fieldsToRetain
            );

            changedRetainedFieldsByRecordIds.put(newRecord.Id, changedDeltaFields);
        }

        return changedRetainedFieldsByRecordIds;
    }

    public Set<Schema.SObjectField> getChangedRetainedFields(
        final SObject record,
        final Set<Schema.SObjectField> fieldsToRetain
    ) {
        if (record == null || fieldsToRetain == null) {
            return new Set<Schema.SObjectField>();
        }

        Set<SObjectField> changedFields = this.getChangedFields(record);
        changedFields.retainAll(fieldsToRetain);

        return changedFields;
    }

    public void execute() {
        switch on operationType {
            when BEFORE_INSERT {
                this.onValidate();
                this.onBeforeInsert();
            }
            when BEFORE_UPDATE {
                this.onValidate();
                this.onBeforeUpdate();
            }
            when BEFORE_DELETE {
                this.onBeforeDelete();
            }
            when AFTER_INSERT {
                this.onAfterInsert();
            }
            when AFTER_UPDATE {
                this.onAfterUpdate();
            }
            when AFTER_DELETE {
                this.onAfterDelete();
            }
            when AFTER_UNDELETE {
                this.onAfterUndelete();
            }
            when else {
                throw new TriggerHandlerException(
                    'Operation type not supported: ' + this.operationType
                );
            }
        }
    }

    public Set<Schema.SObjectField> getChangedFields() {
        Set<Schema.SObjectField> changedFields = new Set<Schema.SObjectField>();

        for (SObject newRecord : this.getNewRecords()) {
            changedFields.addAll(this.getChangedFields(newRecord));
        }

        return changedFields;
    }

    public Set<Schema.SObjectField> getChangedFields(final SObject record) {
        Set<Schema.SObjectField> changedFields = new Set<Schema.SObjectField>();
        if (record == null) {
            return changedFields;
        }

        final SObject oldRecord = this.getOldRecordsByIds() == null
            ? null
            : this.getOldRecordsByIds().get(record.Id);
        for (
            Schema.SObjectField field : record.getSObjectType()
                .getDescribe()
                .fields.getMap()
                .values()
        ) {
            if (oldRecord == null || record.get(field) != oldRecord.get(field)) {
                changedFields.add(field);
            }
        }

        return changedFields;
    }

    public List<SObject> getChangedRecordsBy(final SObjectField field, final Object value) {
        List<SObject> changedRecords = new List<SObject>();
        if (
            field == null ||
            this.getNewRecords() == null ||
            field.getDescribe().getSObjectType() != this.sObjectType
        ) {
            return changedRecords;
        }

        for (SObject newRecord : this.getNewRecords()) {
            SObject oldRecord = null;
            if (this.getOldRecordsByIds() != null) {
                oldRecord = this.getOldRecordsByIds().get(newRecord.Id);
            }

            if (newRecord.get(field) == value) {
                if (oldRecord == null || oldRecord.get(field) != value) {
                    changedRecords.add(newRecord);
                }
            }
        }

        return changedRecords;
    }

    public List<SObject> getChangedRecordsBy(final Set<SObjectField> fields) {
        if (this.getNewRecords() == null || fields == null || fields.isEmpty()) {
            return new List<SObject>();
        }

        List<SObject> changedRecords = new List<SObject>();
        for (SObject newRecord : this.getNewRecords()) {
            if (newRecord == null) {
                continue;
            }

            final SObject oldRecord = this.getOldRecordsByIds() == null
                ? null
                : this.getOldRecordsByIds().get(newRecord.Id);
            if (oldRecord == null) {
                changedRecords.add(newRecord);
                continue;
            }

            for (SObjectField field : fields) {
                if (newRecord.get(field) != oldRecord.get(field)) {
                    changedRecords.add(newRecord);
                    break;
                }
            }
        }

        return changedRecords;
    }

    protected virtual void onValidate() {
        return;
    }

    protected virtual void onBeforeInsert() {
        return;
    }

    protected virtual void onBeforeUpdate() {
        return;
    }

    protected virtual void onBeforeDelete() {
        return;
    }

    protected virtual void onAfterInsert() {
        return;
    }

    protected virtual void onAfterUpdate() {
        return;
    }

    protected virtual void onAfterDelete() {
        return;
    }

    protected virtual void onAfterUndelete() {
        return;
    }

    private void setTriggerContext() {
        this.operationType = Trigger.operationType;
        this.setNewRecords(Trigger.new)
            .setNewRecordsByIds(Trigger.newMap)
            .setOldRecordsByIds(Trigger.oldMap);
    }

    @testVisible
    private TriggerHandler setNewRecords(List<SObject> newRecords) {
        this.newRecords = newRecords;
        return this;
    }

    @testVisible
    private TriggerHandler setNewRecordsByIds(Map<Id, SObject> newRecordsByIds) {
        this.newRecordsByIds = newRecordsByIds;
        return this;
    }

    @testVisible
    private TriggerHandler setOldRecordsByIds(Map<Id, SObject> oldRecordsByIds) {
        this.oldRecordsByIds = oldRecordsByIds;
        return this;
    }

    private class TriggerHandlerException extends Exception {
    }
}
