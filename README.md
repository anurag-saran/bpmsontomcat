bpmsontomcat
============

Scripted install of JBoss BPMS on top of Tomcat.  

[JBoss BPMS on Tomcat installation instructions](https://access.redhat.com/documentation/en-US/Red_Hat_JBoss_BPM_Suite/6.0/html-single/Installation_Guide/index.html#sect-The_generic_deployable_bundle_installation)

[JBoss BPMS enterprise download location](https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=30833)

[JBoss BPMS Supported Configuration Details](https://access.redhat.com/articles/704703)


## Directions for usage: 

* cd into the root directory of your Tomcat installation

```
  cd $CATALINA_HOME
```  

* Get the install script, and execute it

```
  wget https://raw.githubusercontent.com/shuawest/bpmsontomcat/master/installBPMS.sh
  chmod a+x installBPMS.sh
  ./installBPMS.sh
```  

* Edit the datasource properties to match your environment

```
  vi conf/resources.properties  # update this file for your datasource
  vi bin/setenv.sh              # uncomment the proper hiberate dialect
  cp $JDBCJAR ./lib             # copy your JDBC driver jar file into ./lib/
```  

* Check your default tomcat configurations files for differences.  This script backs up then overwrites the following files. If you have preconfigured Tomcat you may need to merge your changes.

```
  diff -y confbackup/conf/tomcat-users.xml conf/tomcat-users.xml
  diff -y confbackup/conf/context.xml conf/context.xml
  diff -y confbackup/conf/server.xmlconf/server.xml
```

* Start Tomcat.  Note, you should start Tomcat from a consistent working directory, as some directories are created based on the current working directory when Tomcat startup.sh was invoked.

```
  cd $CATALINA_HOME/bin/
  ./startup.sh
```

* Watch the main log for exceptions. Note, you should look at the top most error in the log, after the server was started.

* After installation is it save to delete the installation and staging directories:

```
  cd $CATALINA_HOME
  rm -rf confbackup
  rm installBPMS.sh
```

