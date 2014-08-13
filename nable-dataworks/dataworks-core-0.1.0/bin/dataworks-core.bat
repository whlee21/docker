@REM dataworks-core launcher script
@REM
@REM Environment:
@REM JAVA_HOME - location of a JDK home dir (optional if java on path)
@REM CFG_OPTS  - JVM options (optional)
@REM Configuration:
@REM DATAWORKS_CORE_config.txt found in the DATAWORKS_CORE_HOME.
@setlocal enabledelayedexpansion

@echo off
if "%DATAWORKS_CORE_HOME%"=="" set "DATAWORKS_CORE_HOME=%~dp0\\.."
set ERROR_CODE=0

set "APP_LIB_DIR=%DATAWORKS_CORE_HOME%\lib\"

rem Detect if we were double clicked, although theoretically A user could
rem manually run cmd /c
for %%x in (%cmdcmdline%) do if %%~x==/c set DOUBLECLICKED=1

rem FIRST we load the config file of extra options.
set "CFG_FILE=%DATAWORKS_CORE_HOME%\DATAWORKS_CORE_config.txt"
set CFG_OPTS=
if exist %CFG_FILE% (
  FOR /F "tokens=* eol=# usebackq delims=" %%i IN ("%CFG_FILE%") DO (
    set DO_NOT_REUSE_ME=%%i
    rem ZOMG (Part #2) WE use !! here to delay the expansion of
    rem CFG_OPTS, otherwise it remains "" for this loop.
    set CFG_OPTS=!CFG_OPTS! !DO_NOT_REUSE_ME!
  )
)

rem We use the value of the JAVACMD environment variable if defined
set _JAVACMD=%JAVACMD%

if "%_JAVACMD%"=="" (
  if not "%JAVA_HOME%"=="" (
    if exist "%JAVA_HOME%\bin\java.exe" set "_JAVACMD=%JAVA_HOME%\bin\java.exe"
  )
)

if "%_JAVACMD%"=="" set _JAVACMD=java

rem Detect if this java is ok to use.
for /F %%j in ('"%_JAVACMD%" -version  2^>^&1') do (
  if %%~j==Java set JAVAINSTALLED=1
)

rem BAT has no logical or, so we do it OLD SCHOOL! Oppan Redmond Style
set JAVAOK=true
if not defined JAVAINSTALLED set JAVAOK=false

if "%JAVAOK%"=="false" (
  echo.
  echo A Java JDK is not installed or can't be found.
  if not "%JAVA_HOME%"=="" (
    echo JAVA_HOME = "%JAVA_HOME%"
  )
  echo.
  echo Please go to
  echo   http://www.oracle.com/technetwork/java/javase/downloads/index.html
  echo and download a valid Java JDK and install before running dataworks-core.
  echo.
  echo If you think this message is in error, please check
  echo your environment variables to see if "java.exe" and "javac.exe" are
  echo available via JAVA_HOME or PATH.
  echo.
  if defined DOUBLECLICKED pause
  exit /B 1
)


rem We use the value of the JAVA_OPTS environment variable if defined, rather than the config.
set _JAVA_OPTS=%JAVA_OPTS%
if "%_JAVA_OPTS%"=="" set _JAVA_OPTS=%CFG_OPTS%

rem We keep in _JAVA_PARAMS all -J-prefixed and -D-prefixed arguments
rem "-J" is stripped, "-D" is left as is, and everything is appended to JAVA_OPTS
set _JAVA_PARAMS=

:param_beforeloop
if [%1]==[] goto param_afterloop
set _TEST_PARAM=%~1

rem ignore arguments that do not start with '-'
if not "%_TEST_PARAM:~0,1%"=="-" (
  shift
  goto param_beforeloop
)

set _TEST_PARAM=%~1
if "%_TEST_PARAM:~0,2%"=="-J" (
  rem strip -J prefix
  set _TEST_PARAM=%_TEST_PARAM:~2%
)

if "%_TEST_PARAM:~0,2%"=="-D" (
  rem test if this was double-quoted property "-Dprop=42"
  for /F "delims== tokens=1-2" %%G in ("%_TEST_PARAM%") DO (
    if not "%%G" == "%_TEST_PARAM%" (
      rem double quoted: "-Dprop=42" -> -Dprop="42"
      set _JAVA_PARAMS=%%G="%%H"
    ) else if [%2] neq [] (
      rem it was a normal property: -Dprop=42 or -Drop="42"
      set _JAVA_PARAMS=%_TEST_PARAM%=%2
      shift
    )
  )
) else (
  rem a JVM property, we just append it
  set _JAVA_PARAMS=%_TEST_PARAM%
)

:param_loop
shift

if [%1]==[] goto param_afterloop
set _TEST_PARAM=%~1

rem ignore arguments that do not start with '-'
if not "%_TEST_PARAM:~0,1%"=="-" goto param_loop

set _TEST_PARAM=%~1
if "%_TEST_PARAM:~0,2%"=="-J" (
  rem strip -J prefix
  set _TEST_PARAM=%_TEST_PARAM:~2%
)

if "%_TEST_PARAM:~0,2%"=="-D" (
  rem test if this was double-quoted property "-Dprop=42"
  for /F "delims== tokens=1-2" %%G in ("%_TEST_PARAM%") DO (
    if not "%%G" == "%_TEST_PARAM%" (
      rem double quoted: "-Dprop=42" -> -Dprop="42"
      set _JAVA_PARAMS=%_JAVA_PARAMS% %%G="%%H"
    ) else if [%2] neq [] (
      rem it was a normal property: -Dprop=42 or -Drop="42"
      set _JAVA_PARAMS=%_JAVA_PARAMS% %_TEST_PARAM%=%2
      shift
    )
  )
) else (
  rem a JVM property, we just append it
  set _JAVA_PARAMS=%_JAVA_PARAMS% %_TEST_PARAM%
)
goto param_loop
:param_afterloop

set _JAVA_OPTS=%_JAVA_OPTS% %_JAVA_PARAMS%
:run
 
set "APP_CLASSPATH=%APP_LIB_DIR%\dataworks-core.dataworks-core-0.1.0.jar;%APP_LIB_DIR%\org.scala-lang.scala-compiler-2.10.4.jar;%APP_LIB_DIR%\org.scala-lang.scala-library-2.10.4.jar;%APP_LIB_DIR%\org.scala-lang.scala-reflect-2.10.4.jar;%APP_LIB_DIR%\com.typesafe.play.twirl-api_2.10-1.0.2.jar;%APP_LIB_DIR%\org.apache.commons.commons-lang3-3.1.jar;%APP_LIB_DIR%\com.typesafe.play.play_2.10-2.3.2.jar;%APP_LIB_DIR%\com.typesafe.play.build-link-2.3.2.jar;%APP_LIB_DIR%\com.typesafe.play.play-exceptions-2.3.2.jar;%APP_LIB_DIR%\org.javassist.javassist-3.18.2-GA.jar;%APP_LIB_DIR%\com.typesafe.play.play-iteratees_2.10-2.3.2.jar;%APP_LIB_DIR%\org.scala-stm.scala-stm_2.10-0.7.jar;%APP_LIB_DIR%\com.typesafe.config-1.2.1.jar;%APP_LIB_DIR%\com.typesafe.play.play-json_2.10-2.3.2.jar;%APP_LIB_DIR%\com.typesafe.play.play-functional_2.10-2.3.2.jar;%APP_LIB_DIR%\com.typesafe.play.play-datacommons_2.10-2.3.2.jar;%APP_LIB_DIR%\joda-time.joda-time-2.3.jar;%APP_LIB_DIR%\org.joda.joda-convert-1.6.jar;%APP_LIB_DIR%\com.fasterxml.jackson.core.jackson-annotations-2.3.2.jar;%APP_LIB_DIR%\com.fasterxml.jackson.core.jackson-core-2.3.2.jar;%APP_LIB_DIR%\com.fasterxml.jackson.core.jackson-databind-2.3.2.jar;%APP_LIB_DIR%\io.netty.netty-3.9.2.Final.jar;%APP_LIB_DIR%\com.typesafe.netty.netty-http-pipelining-1.1.2.jar;%APP_LIB_DIR%\org.slf4j.jul-to-slf4j-1.7.6.jar;%APP_LIB_DIR%\org.slf4j.jcl-over-slf4j-1.7.6.jar;%APP_LIB_DIR%\ch.qos.logback.logback-core-1.1.1.jar;%APP_LIB_DIR%\ch.qos.logback.logback-classic-1.1.1.jar;%APP_LIB_DIR%\com.typesafe.akka.akka-actor_2.10-2.3.4.jar;%APP_LIB_DIR%\com.typesafe.akka.akka-slf4j_2.10-2.3.4.jar;%APP_LIB_DIR%\commons-codec.commons-codec-1.9.jar;%APP_LIB_DIR%\xerces.xercesImpl-2.11.0.jar;%APP_LIB_DIR%\xml-apis.xml-apis-1.4.01.jar;%APP_LIB_DIR%\javax.transaction.jta-1.1.jar;%APP_LIB_DIR%\com.typesafe.play.play-jdbc_2.10-2.3.2.jar;%APP_LIB_DIR%\com.jolbox.bonecp-0.8.0.RELEASE.jar;%APP_LIB_DIR%\com.h2database.h2-1.3.175.jar;%APP_LIB_DIR%\tyrex.tyrex-1.0.1.jar;%APP_LIB_DIR%\com.typesafe.play.play-cache_2.10-2.3.2.jar;%APP_LIB_DIR%\net.sf.ehcache.ehcache-core-2.6.8.jar;%APP_LIB_DIR%\org.slf4j.slf4j-nop-1.7.7.jar;%APP_LIB_DIR%\org.slf4j.slf4j-api-1.7.7.jar;%APP_LIB_DIR%\be.objectify.deadbolt-scala_2.10-2.3.1.jar;%APP_LIB_DIR%\be.objectify.deadbolt-core_2.10-2.3.1.jar;%APP_LIB_DIR%\com.typesafe.play.play-java_2.10-2.3.1.jar;%APP_LIB_DIR%\org.yaml.snakeyaml-1.13.jar;%APP_LIB_DIR%\org.hibernate.hibernate-validator-5.0.3.Final.jar;%APP_LIB_DIR%\javax.validation.validation-api-1.1.0.Final.jar;%APP_LIB_DIR%\org.jboss.logging.jboss-logging-3.1.1.GA.jar;%APP_LIB_DIR%\com.fasterxml.classmate-1.0.0.jar;%APP_LIB_DIR%\org.springframework.spring-context-4.0.3.RELEASE.jar;%APP_LIB_DIR%\org.springframework.spring-core-4.0.3.RELEASE.jar;%APP_LIB_DIR%\org.springframework.spring-beans-4.0.3.RELEASE.jar;%APP_LIB_DIR%\org.reflections.reflections-0.9.8.jar;%APP_LIB_DIR%\com.google.guava.guava-16.0.1.jar;%APP_LIB_DIR%\dom4j.dom4j-1.6.1.jar;%APP_LIB_DIR%\com.google.code.findbugs.jsr305-2.0.3.jar;%APP_LIB_DIR%\org.apache.tomcat.tomcat-servlet-api-8.0.5.jar;%APP_LIB_DIR%\org.scalaz.scalaz-core_2.10-7.0.6.jar;%APP_LIB_DIR%\org.apache.hadoop.hadoop-common-2.3.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hadoop.hadoop-annotations-2.3.0-cdh5.1.0.jar;%APP_LIB_DIR%\commons-cli.commons-cli-1.2.jar;%APP_LIB_DIR%\org.apache.commons.commons-math3-3.1.1.jar;%APP_LIB_DIR%\xmlenc.xmlenc-0.52.jar;%APP_LIB_DIR%\commons-httpclient.commons-httpclient-3.1.jar;%APP_LIB_DIR%\commons-logging.commons-logging-1.1.3.jar;%APP_LIB_DIR%\commons-io.commons-io-2.4.jar;%APP_LIB_DIR%\commons-net.commons-net-3.1.jar;%APP_LIB_DIR%\commons-collections.commons-collections-3.2.1.jar;%APP_LIB_DIR%\log4j.log4j-1.2.17.jar;%APP_LIB_DIR%\net.java.dev.jets3t.jets3t-0.9.0.jar;%APP_LIB_DIR%\com.jamesmurty.utils.java-xmlbuilder-0.4.jar;%APP_LIB_DIR%\commons-lang.commons-lang-2.6.jar;%APP_LIB_DIR%\commons-configuration.commons-configuration-1.6.jar;%APP_LIB_DIR%\commons-digester.commons-digester-1.8.jar;%APP_LIB_DIR%\commons-beanutils.commons-beanutils-1.7.0.jar;%APP_LIB_DIR%\commons-beanutils.commons-beanutils-core-1.8.0.jar;%APP_LIB_DIR%\org.apache.avro.avro-1.7.5-cdh5.1.0.jar;%APP_LIB_DIR%\com.thoughtworks.paranamer.paranamer-2.3.jar;%APP_LIB_DIR%\org.xerial.snappy.snappy-java-1.0.5.jar;%APP_LIB_DIR%\org.apache.commons.commons-compress-1.4.1.jar;%APP_LIB_DIR%\org.tukaani.xz-1.0.jar;%APP_LIB_DIR%\com.google.protobuf.protobuf-java-2.5.0.jar;%APP_LIB_DIR%\org.apache.hadoop.hadoop-auth-2.3.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.httpcomponents.httpclient-4.2.5.jar;%APP_LIB_DIR%\org.apache.directory.server.apacheds-kerberos-codec-2.0.0-M15.jar;%APP_LIB_DIR%\org.apache.directory.server.apacheds-i18n-2.0.0-M15.jar;%APP_LIB_DIR%\org.apache.directory.api.api-asn1-api-1.0.0-M20.jar;%APP_LIB_DIR%\org.apache.directory.api.api-util-1.0.0-M20.jar;%APP_LIB_DIR%\com.jcraft.jsch-0.1.42.jar;%APP_LIB_DIR%\tomcat.jasper-compiler-5.5.23.jar;%APP_LIB_DIR%\tomcat.jasper-runtime-5.5.23.jar;%APP_LIB_DIR%\commons-el.commons-el-1.0.jar;%APP_LIB_DIR%\javax.servlet.jsp.jsp-api-2.1.jar;%APP_LIB_DIR%\org.slf4j.slf4j-log4j12-1.7.5.jar;%APP_LIB_DIR%\org.apache.hadoop.hadoop-mapreduce-client-common-2.3.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hadoop.hadoop-yarn-common-2.3.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hadoop.hadoop-yarn-api-2.3.0-cdh5.1.0.jar;%APP_LIB_DIR%\javax.xml.bind.jaxb-api-2.2.2.jar;%APP_LIB_DIR%\javax.xml.stream.stax-api-1.0-2.jar;%APP_LIB_DIR%\javax.activation.activation-1.1.jar;%APP_LIB_DIR%\com.google.inject.extensions.guice-servlet-3.0.jar;%APP_LIB_DIR%\com.google.inject.guice-3.0.jar;%APP_LIB_DIR%\javax.inject.javax.inject-1.jar;%APP_LIB_DIR%\aopalliance.aopalliance-1.0.jar;%APP_LIB_DIR%\org.sonatype.sisu.inject.cglib-2.2.1-v20090111.jar;%APP_LIB_DIR%\asm.asm-3.2.jar;%APP_LIB_DIR%\org.apache.hadoop.hadoop-yarn-client-2.3.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hadoop.hadoop-mapreduce-client-core-2.3.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hadoop.hadoop-yarn-server-common-2.3.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hbase.hbase-common-0.98.1-cdh5.1.0.jar;%APP_LIB_DIR%\com.github.stephenc.findbugs.findbugs-annotations-1.3.9-1.jar;%APP_LIB_DIR%\junit.junit-4.11.jar;%APP_LIB_DIR%\org.hamcrest.hamcrest-core-1.3.jar;%APP_LIB_DIR%\org.apache.hbase.hbase-client-0.98.1-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hbase.hbase-protocol-0.98.1-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.zookeeper.zookeeper-3.4.5-cdh5.1.0.jar;%APP_LIB_DIR%\org.cloudera.htrace.htrace-core-2.04.jar;%APP_LIB_DIR%\org.apache.hbase.hbase-hadoop-compat-0.98.1-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hbase.hbase-hadoop2-compat-0.98.1-cdh5.1.0.jar;%APP_LIB_DIR%\com.yammer.metrics.metrics-core-2.1.2.jar;%APP_LIB_DIR%\org.apache.hbase.hbase-server-0.98.1-cdh5.1.0.jar;%APP_LIB_DIR%\com.github.stephenc.high-scale-lib.high-scale-lib-1.1.1.jar;%APP_LIB_DIR%\org.apache.commons.commons-math-2.1.jar;%APP_LIB_DIR%\org.jamon.jamon-runtime-2.3.1.jar;%APP_LIB_DIR%\org.apache.hbase.hbase-prefix-tree-0.98.1-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hive.hcatalog.hive-hcatalog-core-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hive.hive-cli-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hive.hive-common-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hive.hive-shims-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hive.shims.hive-shims-common-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.thrift.libthrift-0.9.0.cloudera.2.jar;%APP_LIB_DIR%\org.apache.httpcomponents.httpcore-4.2.5.jar;%APP_LIB_DIR%\org.apache.hive.shims.hive-shims-common-secure-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hive.hive-metastore-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hive.hive-serde-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.derby.derby-10.4.2.0.jar;%APP_LIB_DIR%\org.datanucleus.datanucleus-api-jdo-3.2.1.jar;%APP_LIB_DIR%\org.datanucleus.datanucleus-core-3.2.2.jar;%APP_LIB_DIR%\org.datanucleus.datanucleus-rdbms-3.2.1.jar;%APP_LIB_DIR%\javax.jdo.jdo-api-3.0.1.jar;%APP_LIB_DIR%\org.antlr.antlr-runtime-3.4.jar;%APP_LIB_DIR%\org.antlr.stringtemplate-3.2.1.jar;%APP_LIB_DIR%\antlr.antlr-2.7.7.jar;%APP_LIB_DIR%\org.apache.thrift.libfb303-0.9.0.jar;%APP_LIB_DIR%\org.apache.hive.hive-service-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hive.hive-exec-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hive.hive-ant-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.ant.ant-1.9.1.jar;%APP_LIB_DIR%\org.apache.ant.ant-launcher-1.9.1.jar;%APP_LIB_DIR%\org.apache.velocity.velocity-1.5.jar;%APP_LIB_DIR%\oro.oro-2.0.8.jar;%APP_LIB_DIR%\com.twitter.parquet-hadoop-bundle-1.2.5-cdh5.1.0.jar;%APP_LIB_DIR%\org.antlr.ST4-4.0.4.jar;%APP_LIB_DIR%\org.codehaus.groovy.groovy-all-2.1.6.jar;%APP_LIB_DIR%\stax.stax-api-1.0.1.jar;%APP_LIB_DIR%\org.mortbay.jetty.jetty-6.1.26.cloudera.2.jar;%APP_LIB_DIR%\org.mortbay.jetty.jetty-util-6.1.26.cloudera.2.jar;%APP_LIB_DIR%\org.mortbay.jetty.servlet-api-2.5-20081211.jar;%APP_LIB_DIR%\jline.jline-0.9.94.jar;%APP_LIB_DIR%\org.codehaus.jackson.jackson-mapper-asl-1.9.2.jar;%APP_LIB_DIR%\org.codehaus.jackson.jackson-core-asl-1.9.2.jar;%APP_LIB_DIR%\org.apache.hive.shims.hive-shims-0.23-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\org.apache.hive.hcatalog.hive-webhcat-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\com.sun.jersey.jersey-json-1.14.jar;%APP_LIB_DIR%\org.codehaus.jettison.jettison-1.1.jar;%APP_LIB_DIR%\com.sun.xml.bind.jaxb-impl-2.2.3-1.jar;%APP_LIB_DIR%\org.codehaus.jackson.jackson-jaxrs-1.9.2.jar;%APP_LIB_DIR%\org.codehaus.jackson.jackson-xc-1.9.2.jar;%APP_LIB_DIR%\com.sun.jersey.jersey-servlet-1.14.jar;%APP_LIB_DIR%\com.sun.jersey.contribs.wadl-resourcedoc-doclet-1.4.jar;%APP_LIB_DIR%\com.sun.jersey.jersey-server-1.14.jar;%APP_LIB_DIR%\org.apache.commons.commons-exec-1.1.jar;%APP_LIB_DIR%\org.eclipse.jetty.aggregate.jetty-all-server-7.6.0.v20120127.jar;%APP_LIB_DIR%\javax.servlet.servlet-api-2.5.jar;%APP_LIB_DIR%\org.apache.geronimo.specs.geronimo-jta_1.1_spec-1.1.1.jar;%APP_LIB_DIR%\javax.mail.mail-1.4.1.jar;%APP_LIB_DIR%\org.apache.geronimo.specs.geronimo-jaspic_1.0_spec-1.0.jar;%APP_LIB_DIR%\org.apache.geronimo.specs.geronimo-annotation_1.0_spec-1.1.1.jar;%APP_LIB_DIR%\asm.asm-commons-3.1.jar;%APP_LIB_DIR%\asm.asm-tree-3.1.jar;%APP_LIB_DIR%\org.apache.hive.hive-beeline-0.12.0-cdh5.1.0.jar;%APP_LIB_DIR%\dataworks-core.dataworks-core-0.1.0-assets.jar"
set "APP_MAIN_CLASS=play.core.server.NettyServer"

rem Call the application and pass all arguments unchanged.
"%_JAVACMD%" %_JAVA_OPTS% %DATAWORKS_CORE_OPTS% -cp "%APP_CLASSPATH%" %APP_MAIN_CLASS% %*
if ERRORLEVEL 1 goto error
goto end

:error
set ERROR_CODE=1

:end

@endlocal

exit /B %ERROR_CODE%
