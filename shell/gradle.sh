# install on ubuntu
wget https://services.gradle.org/distributions/gradle-5.1-bin.zip -P /tmp
sudo unzip -d /opt/gradle /tmp/gradle-5.1-bin.zip
sudo touch /etc/profile.d/gradle.sh
export GRADLE_HOME=/opt/gradle/gradle-5.1
export PATH=${GRADLE_HOME}/bin:${PATH}
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh

# basic command
gradle -v
gradle tasks
gradle clean
# gradle check assemble
gradle build
gradle projects
gradle <sub-project>:docker
