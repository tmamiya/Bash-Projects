#!/bin/sh


EMAILDIR=/home/tmamiya/email
FNAME=vert_etl_health
# Set environment variables

## -v The shell shall write its input to standard error as it is read. -x The shell shall write to standard error a trace for each command after it expands the command and before it executes it. It is unspecified whether the command that turns tracing off is traced.
set -xv

## grabbing variables in the below shells

.  /home/tmamiya/sh/vert_env.sh
.  /home/tmamiya/sh/variables.sh

# Create data files


#Salesline Based Shipping Check

#gives the time setting up variables took place
date

################################################################################################################
#salesline_based_shipping Check


REPORT_OUTPUT=${DATADIR}/vert/${FNAME}.xls; export REPORT_OUTPUT
echo $REPORT_OUTPUT


vsql -h vertica.newokl.com -d $NZ_DB -U $NZ_USER -w $NZ_PWD -A -F "	" <<EOF

\o $REPORT_OUTPUT
\i $SQLDIR/vert/${FNAME}.sql
\q
EOF



EMAILDIR=/home/tmamiya/email


ROWCOUNT=`wc -l /home/tmamiya/data/vert/${FNAME}.xls | awk '{print $1}'`
# -gt means greater than, this conditional looks for anything that has rowcount greater than 1

    if [ ${ROWCOUNT} -lt 3 ]
then

# Email to confirm that txt file has been created.
echo "Salesline based shipping did not report any/enough records yesterday please check on the status of this ETL, please do not respond to this email address" | mail -s "ETL HEALTH ALERT Salesline based shipping" `cat ${EMAILDIR}/PandaAlert.txt`


        fi


date

################################################################################################################
#bitmp_package Check



REPORT_OUTPUT2=${DATADIR}/vert/vert_etl_health2.xls; export REPORT_OUTPUT2
echo $REPORT_OUTPUT2


vsql -h vertica.newokl.com -d $NZ_DB -U $NZ_USER -w $NZ_PWD -A -F "	" <<EOF

\o $REPORT_OUTPUT2
\i $SQLDIR/vert/vert_etl_health2.sql
\q
EOF



EMAILDIR=/home/tmamiya/email


ROWCOUNT=`wc -l /home/tmamiya/data/vert/vert_etl_health2.xls | awk '{print $1}'`
# -gt means greater than, this conditional looks for anything that has rowcount greater than 1

    if [ ${ROWCOUNT} -lt 3 ]
then

# Email to confirm that txt file has been created.
echo "Ops_package did not report any/enough records yesterday please check on the status of this ETL, please do not respond to this email address" | mail -s "ETL HEALTH ALERT OPS_PACKAGE" `cat ${EMAILDIR}/PandaAlert.txt`

        fi
date

################################################################################################################
#Assistly Check



REPORT_OUTPUT3=${DATADIR}/vert/vert_etl_health3.xls; export REPORT_OUTPUT3
echo $REPORT_OUTPUT3


vsql -h vertica.newokl.com -d $NZ_DB -U $NZ_USER -w $NZ_PWD -A -F "	" <<EOF

\o $REPORT_OUTPUT3
\i $SQLDIR/vert/vert_etl_health3.sql
\q
EOF



EMAILDIR=/home/tmamiya/email


ROWCOUNT=`wc -l /home/tmamiya/data/vert/vert_etl_health3.xls | awk '{print $1}'`
# -gt means greater than, this conditional looks for anything that has rowcount greater than 1

    if [ ${ROWCOUNT} -lt 3 ]
then

# Email to confirm that txt file has been created.
echo "raw_sources.Assistly did not report any/enough records yesterday please check on the status of this ETL, please do not respond to this email address" | mail -s "ETL HEALTH ALERT raw_sources.Assistly" `cat ${EMAILDIR}/PandaAlert.txt`

        fi
date

################################################################################################################
#raw_sources.cdr_main Check



REPORT_OUTPUT4=${DATADIR}/vert/vert_etl_health4.xls; export REPORT_OUTPUT4
echo $REPORT_OUTPUT4


vsql -h vertica.newokl.com -d $NZ_DB -U $NZ_USER -w $NZ_PWD -A -F "	" <<EOF

\o $REPORT_OUTPUT4
\i $SQLDIR/vert/vert_etl_health4.sql
\q
EOF



EMAILDIR=/home/tmamiya/email


ROWCOUNT=`wc -l /home/tmamiya/data/vert/vert_etl_health4.xls | awk '{print $1}'`
# -gt means greater than, this conditional looks for anything that has rowcount greater than 1

    if [ ${ROWCOUNT} -lt 3 ]
then

# Email to confirm that txt file has been created.
echo "raw_sources.cdr_main did not report any/enough records yesterday please check on the status of this ETL, please do not respond to this email address" | mail -s "ETL HEALTH ALERT raw_sources.cdr_main" `cat ${EMAILDIR}/PandaAlert.txt`

        fi
date

