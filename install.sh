#!/bin/sh


usage() {
	echo "cd $TOMCAT_HOME"
	echo "./install.sh" 
	echo "vi conf.resources.properties for your datasource"
	echo "cp $DBDRIVER ./lib/"
	echo "vi webapps/business-central/WEB-INF/classes/META-INF/persistence.xml   #edit database dialect"
	echo "cd bin"
	echo "./startup.sh"
}

if [ ! -f "./bin/catalina.sh" ]; then
	echo " "
	echo "tomcat installation not detected.  Copy into tomcat root directory, "
	echo " "
	usage
	echo " "
	exit;
fi 


mkdir downloads
pushd downloads

if [ ! -f jboss-bpms-*-deployable-generic.zip ]; then
	wget http://people.redhat.com/jowest/bnym/jboss-bpms-6.0.2.GA-redhat-5-deployable-generic.zip
fi

if [ ! -f javax.security.jacc-api-1.5.jar ]; then
	wget http://repository.jboss.org/nexus/content/repositories/central/javax/security/jacc/javax.security.jacc-api/1.5/javax.security.jacc-api-1.5.jar
fi

unzip jboss-bpms-*-deployable-generic.zip
pushd jboss-bpms-*
unzip jboss-bpms-manager.zip
unzip jboss-bpms-engine.zip
popd
popd

cp -rv downloads/jboss-bpms-*-deployable-generic/jboss-bpms-manager/business-central.war webapps/business-central
cp -rv downloads/jboss-bpms-*-deployable-generic/jboss-bpms-manager/dashbuilder.war webapps/dashbuilder

cp -v downloads/jboss-bpms-*-deployable-generic/jboss-bpms-engine/lib/btm*.jar ./lib/
cp -v downloads/jboss-bpms-*-deployable-generic/jboss-bpms-engine/lib/jta*.jar ./lib/
cp -v downloads/jboss-bpms-*-deployable-generic/jboss-bpms-engine/lib/slf4j-api*.jar ./lib/
cp -v downloads/jboss-bpms-*-deployable-generic/jboss-bpms-engine/lib/slf4j-ext*.jar ./lib/
cp -v downloads/javax.security.jacc-api-1.5.jar ./lib/

cp -v ./webapps/business-central/WEB-INF/lib/kie-tomcat-integration-*.jar ./lib/
cp -v ./webapps/business-central/WEB-INF/lib/jaxb-api-*.jar ./lib/

# install your database driver
wget http://people.redhat.com/jowest/ojdbc6.jar
cp -v ojdbc6.jar ./lib/


# Overlay file changes from github 
# NOTE: this will not merge the changes with your files, so check that these overlay files don't disable anything customized in your own Tomcat installation
#cp -rf overlay/* ./




