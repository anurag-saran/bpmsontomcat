
CATALINA_OPTS="-Xmx2048M -XX:MaxPermSize=512m -Dbtm.root=$CATALINA_HOME -Dbitronix.tm.configuration=$CATALINA_HOME/conf/btm-config.properties -Dorg.jbpm.designer.perspective=RuleFlow"

CATALINA_OPTS="$CATALINA_OPTS -Dbpms.hibernate.dialect=org.hibernate.dialect.Oracle10gDialect"
#CATALINA_OPTS="$CATALINA_OPTS -Dbpms.hibernate.dialect=org.hibernate.dialect.DB2Dialect"
#CATALINA_OPTS="$CATALINA_OPTS -Dbpms.hibernate.dialect=org.hibernate.dialect.DB2400Dialect"
#CATALINA_OPTS="$CATALINA_OPTS -Dbpms.hibernate.dialect=org.hibernate.dialect.SQLServerDialect"
#CATALINA_OPTS="$CATALINA_OPTS -Dbpms.hibernate.dialect=org.hibernate.dialect.MySQLDialect"
#CATALINA_OPTS="$CATALINA_OPTS -Dbpms.hibernate.dialect=org.hibernate.dialect.H2Dialect"
#CATALINA_OPTS="$CATALINA_OPTS -Dbpms.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect"


