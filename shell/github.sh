# GitHub Maven Package Registry

# creating a personal access token for the command line

# configure settings.xml
# ~/.m2/settings.xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <activeProfiles>
    <activeProfile>github</activeProfile>
  </activeProfiles>

  <profiles>
    <profile>
      <id>github</id>
      <repositories>
        <repository>
          <id>central</id>
          <url>https://repo1.maven.org/maven2</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </repository>
        <repository>
          <id>github</id>
          <name>GitHub OWNER Apache Maven Packages</name>
          <url>https://maven.pkg.github.com/OWNER</url>
        </repository>
      </repositories>
    </profile>
  </profiles>

  <servers>
    <server>
      <id>github</id>
      <username>USERNAME</username>
      <password>TOKEN</password>
    </server>
  </servers>
</settings>

# configure pom.xml in project
<distributionManagement>
   <repository>
     <id>github</id>
     <name>GitHub OWNER Apache Maven Packages</name>
     <url>https://maven.pkg.github.com/OWNER</url>
   </repository>
</distributionManagement>
# publish multiple packages to the same repository, optional
<scm>
  <connection>scm:git:https://github.com/OWNER/REPOSITORY.git</connection>
  <developerConnection>scm:git:https://github.com/OWNER/REPOSITORY.git</developerConnection>
  <url>https://github.com/OWNER/REPOSITORY</url>
</scm>

# publish package to your GitHub Package Registry
mvn deploy

# access package
https://github.com/OWNER/REPOSITORY/packages

# install package
<dependencies>
  <dependency>
    <groupId>com.example</groupId>
    <artifactId>test</artifactId>
    <version>1.0.0</version>
  </dependency>
</dependencies>

mvn install

# delete package
curl -H "Authorization: Bearer TOKEN" -X DELETE https://maven.pkg.github.com/OWNER/com/example/PACKAGE NAME/VERSION

# GitHub Docker Package Registry