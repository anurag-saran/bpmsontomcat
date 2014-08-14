#!/bin/sh


usage() {
	echo "cd \$TOMCAT_HOME"
	echo "wget https://raw.githubusercontent.com/shuawest/bpmsontomcat/master/install.sh" 
	echo "chmod a+x install.sh"
	echo "./install.sh"
	echo " "	
	echo "vi conf/resources.properties  # update this file for your datasource"
	echo "vi bin/setenv.sh              # uncomment the proper hiberate dialect"
	echo "cp $JDBCJAR ./lib		    # copy your JDBC driver jar file into ./lib/"
	echo " "
	echo "cd bin            # start tomcat from a consistent location - files are placed in the current working directory"
	echo "./startup.sh      # start the server"

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

if [ ! -f bpmsontomcat.zip ]; then
	wget https://github.com/shuawest/bpmsontomcat/archive/43b4a9058c0f3e0d2108afc741f768bc09918feb.zip
	mv 43b4a9058c0f3e0d2108afc741f768bc09918feb.zip bpmsontomcat.zip
fi

if [ ! -f ojdbc6.jar ]; then
	wget http://people.redhat.com/jowest/ojdbc6.jar        
fi

rm -rf bpmsontomcat*/
unzip bpmsontomcat.zip


rm -rf jboss-bpms-*-deployable-generic
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
cp -v downloads/ojdbc6.jar ./lib/

mkdir confbackup
cp --parents conf/tomcat-users.xml confbackup/
cp --parents conf/context.xml confbackup/
cp --parents conf/server.xml confbackup/

# Overlay file changes from github 
# NOTE: this will not merge the changes with your files, so check that these overlay files don't disable anything customized in your own Tomcat installation
cp -rvf downloads/bpmsontomcat*/overlay/* ./
chmod a+x bin/setenv.sh

echo " "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "
echo " "
echo " Installation Complete"
echo "   complete the post-install steps"
echo " "
usage



