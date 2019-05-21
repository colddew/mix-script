mvn -v

# create project
# mvn <plugin:goal>
mvn archetype:generate -DgroupId=<groupId> -DartifactId=<artifactId> -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=<version> -DinteractiveMode=false

# lifecycles
# mvn <phase>
mvn clean
mvn validate
mvn compile
mvn test
mvn package
mvn integration-test
mvn verify
mvn install
mvn deploy