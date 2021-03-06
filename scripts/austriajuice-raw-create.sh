#!/bin/bash
source discord_url.txt
#API_HOST="http://172.29.0.4:8777/"
#API_HOST="http://localhost:8100/"
API_HOST="https://austria-juice.import-api.gcp.staging.thenewfork.com/"
ORG="AJ"
GREETING="**BATCH DATA**"

for i in {1..1}
do

	# DATES
	PROD_RANDOM_START_DAY=$(cat /dev/urandom | tr -dc '1-2' | fold -w 2 | head -n 1)
        RANDOM_1=$(cat /dev/urandom | tr -dc '1-8' | fold -w 1 | head -n 1)
        PROD_END_DAY=$((PROD_RANDOM_START_DAY + RANDOM_1))
        PROD_MONTH="01"
        PROD_YEAR="2020"
	BBD_MONTH="03"

	# DATA
	RANDOM_VAL_ANFP=18505100
	RANDOM_VAL_DFP="Description here"
	RANDOM_VAL_BNFP=$(cat /dev/urandom | tr -dc '0-9' | fold -w 6 | head -n 1)
	RANDOM_VAL_PC="PO"
	RANDOM_VAL_PL="Bialobrzegi"
	RANDOM_VAL_RMN=11200100520
	RANDOM_VAL_PON=$(cat /dev/urandom | tr -dc '0-9' | fold -w 10 | head -n 1)
	RANDOM_VAL_POP=$(cat /dev/urandom | tr -dc '1-9' | fold -w 3 | head -n 1)
	JDS=${PROD_RANDOM_START_DAY} # only because it is january
	JDE=${PROD_END_DAY}
	PDS="${PROD_YEAR}-${PROD_MONTH}-${PROD_RANDOM_START_DAY}"
	PDE="${PROD_YEAR}-${PROD_MONTH}-${PROD_END_DAY}"
	BBD="${PROD_YEAR}-${BBD_MONTH}-${PROD_END_DAY}"
	# RAW_JSON=$(echo '{ \"anfp\": \"'${RANDOM_VAL_1}'\",\"dfp\": \"'${RANDOM_VAL_2}'\"}' | base64 -w 0)
	RAW_JSON=$(echo '{ \"anfp\": \"'${RANDOM_VAL_ANFP}'\",\"dfp\": \"'${RANDOM_VAL_DFP}'\",\"bnfp\": \"'${RANDOM_VAL_BNFP}'\",\"pds\": \"'${PDS}'\",\"pde\": \"'${PDE}'\",\"jds\": '${JDS}',\"jde\": '${JDE}',\"bbd\": \"'${BBD}'\",\"pc\": \"'${RANDOM_VAL_PC}'\",\"pl\": \"'${RANDOM_VAL_PL}'\",\"rmn\": \"'${RANDOM_VAL_RMN}'\",\"pon\": \"'${RANDOM_VAL_PON}'\",\"pop\": \"'${RANDOM_VAL_POP}'\"' | base64 -w 0)
	echo ""
	echo curl -X POST -H "Content-Type: application/json" ${API_HOST}raw/refresco/ -d "{ \"anfp\": \"${RANDOM_VAL_ANFP}\",\"dfp\": \"${RANDOM_VAL_DFP}\",\"bnfp\": \"${RANDOM_VAL_BNFP}\",\"pds\": \"${PDS}\",\"pde\": \"${PDE}\",\"jds\": ${JDS},\"jde\": ${JDE},\"bbd\": \"${BBD}\",\"pc\": \"${RANDOM_VAL_PC}\",\"pl\": \"${RANDOM_VAL_PL}\",\"rmn\": \"${RANDOM_VAL_RMN}\",\"pon\": \"${RANDOM_VAL_PON}\",\"pop\": \"${RANDOM_VAL_POP}\", \"raw_json\": \"${RAW_JSON}\"}"
	echo ""
	RESPONSE=$(curl -k -X POST -H "Content-Type: application/json" ${API_HOST}raw/refresco/ -d "{ \"anfp\": \"${RANDOM_VAL_ANFP}\",\"dfp\": \"${RANDOM_VAL_DFP}\",\"bnfp\": \"${RANDOM_VAL_BNFP}\",\"pds\": \"${PDS}\",\"pde\": \"${PDE}\",\"jds\": ${JDS},\"jde\": ${JDE},\"bbd\": \"${BBD}\",\"pc\": \"${RANDOM_VAL_PC}\",\"pl\": \"${RANDOM_VAL_PL}\",\"rmn\": \"${RANDOM_VAL_RMN}\",\"pon\": \"${RANDOM_VAL_PON}\",\"pop\": \"${RANDOM_VAL_POP}\", \"raw_json\": \"${RAW_JSON}\"}")
	echo ${RESPONSE}
	id=$(echo ${RESPONSE} | jq -r '.id')
	pon=$(echo ${RESPONSE} | jq -r '.pon')
	echo ${id}
	curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"${GREETING}\n(po) ${pon} ${ORG}\n${API_HOST}raw/refresco/${id}\"}" ${discord_url}
	sleep 1
done
