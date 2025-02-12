@isTest
public without sharing class UnitTest {
    public static BuilderFactory builders = new BuilderFactory(
        new Map<Type, Type>{
            
        }
    );

    /**
     * @description Data Builder Factory.
     * @author dmitrii.dronov2001@gmail.com
     * @date 2024-11-20
     */
    public class BuilderFactory {
        private Map<Type, Type> builders;

        /**
         * @description Constructor
         * @param builders A map of builder types
         */
        public BuilderFactory(final Map<Type, Type> builders) {
            this.builders = builders == null ? new Map<Type, Type>() : builders;
        }

        /**
         * @description Creates a new instance of a builder.
         * @param builderType The type of the builder.
         * @return Object - An instance of the builder.
         */
        public Object newInstance(final Type builderType) {
            final Type implementationType = this.builders.get(builderType);
            Assert.areNotEqual(
                null,
                implementationType,
                'Builder ' + builderType.getName() + ' not found'
            );
            return (Object) implementationType.newInstance();
        }
    }
}
