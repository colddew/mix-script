mvn -v

# create project
# mvn <plugin:goal>
mvn archetype:generate -DgroupId=<groupId> -DartifactId=<artifactId> -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=<version> -DinteractiveMode=false
mvn archetype:generate -DgroupId=cn.plantlink -DartifactId=<artifactId> -DarchetypeArtifactId=micro-service-archetype -DarchetypeVersion=<version> -DinteractiveMode=false
mvn archetype:generate -B -DarchetypeGroupId=<archetypeGroupId> -DarchetypeArtifactId=<archetypeArtifactId> -DarchetypeVersion=<archetypeVersion> -DarchetypeCatalog=http://<nexus-server-ip>:8081/nexus/content/groups/public/archetype-catalog.xml -DgroupId=<groupId> -DartifactId=<rtifactId> -Dpackage=com.plantlink.<micro-service-name>

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
