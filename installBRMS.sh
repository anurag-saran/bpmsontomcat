#!/bin/sh

# TODO
# + Factor in set current working directory for .niogit and maven directories to be under catalina home
# + also backup the setenv.sh script
# 

usage() {
	echo "cd \$TOMCAT_HOME"
	echo "wget https://raw.githubusercontent.com/shuawest/bpmsontomcat/master/installBRMS.sh" 
	echo "chmod a+x installBRMS.sh"
	echo "./installBRMS.sh"
	echo " "	
	echo "vi conf/resources.properties  # update this file for your datasource"
	echo "vi bin/setenv.sh              # uncomment the proper hiberate dialect"
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



pushd /tmp/

if [ ! -f jboss-brms-deployable-generic.zip ]; then
	wget  http://people.redhat.com/jowest/jboss-brms-6.0.3.GA-redhat-1-deployable-generic.zip	
	mv jboss-brms-*-deployable-generic.zip jboss-brms-deployable-generic.zip
fi

if [ ! -f javax.security.jacc-api-1.5.jar ]; then
	wget http://repository.jboss.org/nexus/content/repositories/central/javax/security/jacc/javax.security.jacc-api/1.5/javax.security.jacc-api-1.5.jar
fi

if [ ! -f bpmsontomcat.zip ]; then
	wget --no-check-certificate https://github.com/shuawest/bpmsontomcat/archive/master.zip
	mv master.zip bpmsontomcat.zip
fi


rm -rf bpmsontomcat*/
unzip bpmsontomcat.zip

rm -rf jboss-brms-deployable-generic
unzip jboss-brms-deployable-generic.zip
mv jboss-brms-*-deployable-generic jboss-brms-deployable-generic
pushd jboss-brms-deployable-generic
unzip jboss-brms-manager.zip
unzip jboss-brms-engine.zip
popd
popd

cp -rv /tmp/jboss-brms-*-deployable-generic/jboss-brms-manager/business-central.war webapps/business-central
cp -rv /tmp/jboss-brms-*-deployable-generic/jboss-brms-manager/dashbuilder.war webapps/dashbuilder

cp -v /tmp/jboss-brms-*-deployable-generic/jboss-bpms-engine/lib/slf4j-api*.jar ./lib/
cp -v /tmp/jboss-brms-*-deployable-generic/jboss-bpms-engine/lib/slf4j-ext*.jar ./lib/
cp -v /tmp/javax.security.jacc-api-1.5.jar ./lib/

cp -v ./webapps/business-central/WEB-INF/lib/kie-tomcat-integration-*.jar ./lib/


mkdir confbackup
cp --parents conf/tomcat-users.xml confbackup/
cp --parents conf/context.xml confbackup/
cp --parents conf/server.xml confbackup/

# Overlay file changes from github 
# NOTE: this will not merge the changes with your files, so check that these overlay files don't disable anything customized in your own Tomcat installation
cp -rvf /tmp/bpmsontomcat*/overlay/* ./
chmod a+x bin/*.sh

echo " "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "
echo " "
echo " Installation Complete"
echo "   complete the post-install steps"
echo " "
usage



