#!/bin/bash

set +e

RESULT_DIR="../results"
LOG_FILE="$RESULT_DIR/azure-chaos-results.log"

mkdir -p "$RESULT_DIR"

echo "========================================" | tee "$LOG_FILE"
echo "AZURE CHAOS ENGINEERING - EXPERIMENTS 02-25" | tee -a "$LOG_FILE"
echo "========================================" | tee -a "$LOG_FILE"

echo ""
echo "[ENVIRONMENT CHECK]"
floci az status | tee -a "$LOG_FILE"

echo ""
echo "[AZURE ENVIRONMENT]"
eval $(floci az env)

############################################
# COMMON VARIABLES
############################################

ACCOUNT="devstoreaccount1"

run_cmd() {
    echo ""
    echo "COMMAND: $1" | tee -a "$LOG_FILE"
    eval "$1" 2>&1 | tee -a "$LOG_FILE"
}

############################################
# AZURE CHAOS #02
# CONTAINER DELETION
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #02 - CONTAINER DELETION"
echo "========================================"

CONTAINER="chaos02container"

run_cmd "az storage container delete --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Container and its blobs become unavailable." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #03
# WRONG CONTAINER NAME
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #03 - WRONG CONTAINER"
echo "========================================"

run_cmd "az storage blob list --container-name wrong-container-999 --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Application requests a resource that does not exist." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #04
# WRONG BLOB NAME
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #04 - WRONG BLOB NAME"
echo "========================================"

CONTAINER="chaos04container"

run_cmd "az storage container create --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "correct data" > chaos04.txt

run_cmd "az storage blob upload --container-name $CONTAINER --name correct-config.txt --file chaos04.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage blob download --container-name $CONTAINER --name wrong-config.txt --file output.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Blob lookup fails because requested object is incorrect." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #05
# BLOB OVERWRITE
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #05 - BLOB OVERWRITE"
echo "========================================"

CONTAINER="chaos05container"

run_cmd "az storage container create --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "ORIGINAL_CONFIGURATION" > original.txt

run_cmd "az storage blob upload --overwrite true --container-name $CONTAINER --name config.txt --file original.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "CORRUPTED_CONFIGURATION" > corrupted.txt

run_cmd "az storage blob upload --overwrite true --container-name $CONTAINER --name config.txt --file corrupted.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage blob download --overwrite true --container-name $CONTAINER --name config.txt --file result05.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Resource exists but data has changed." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #06
# EMPTY BLOB
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #06 - EMPTY BLOB"
echo "========================================"

CONTAINER="chaos06container"

run_cmd "az storage container create --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

touch empty.txt

run_cmd "az storage blob upload --overwrite true --container-name $CONTAINER --name config.txt --file empty.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Request succeeds but application receives empty data." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #07
# MULTIPLE BLOB DELETION
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #07 - MULTIPLE BLOB DELETION"
echo "========================================"

CONTAINER="chaos07container"

run_cmd "az storage container create --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "DATA1" > data1.txt
echo "DATA2" > data2.txt
echo "DATA3" > data3.txt

run_cmd "az storage blob upload --container-name $CONTAINER --name data1.txt --file data1.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""
run_cmd "az storage blob upload --container-name $CONTAINER --name data2.txt --file data2.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""
run_cmd "az storage blob upload --container-name $CONTAINER --name data3.txt --file data3.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage blob delete --container-name $CONTAINER --name data1.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""
run_cmd "az storage blob delete --container-name $CONTAINER --name data2.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Multiple dependent resources disappear." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #08
# MISSING CONFIGURATION
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #08 - MISSING CONFIGURATION"
echo "========================================"

CONTAINER="chaos08container"

run_cmd "az storage container create --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage blob download --container-name $CONTAINER --name application-config.json --file config08.json --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Application configuration dependency is missing." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #09
# RECREATED EMPTY CONTAINER
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #09 - EMPTY CONTAINER RECOVERY"
echo "========================================"

CONTAINER="chaos09container"

run_cmd "az storage container create --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPORTANT_DATA" > important09.txt

run_cmd "az storage blob upload --container-name $CONTAINER --name important.txt --file important09.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage container delete --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage container create --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Infrastructure recovered but application data is still missing." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #10
# BLOB RECOVERY
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #10 - BLOB RECOVERY"
echo "========================================"

CONTAINER="chaos10container"

run_cmd "az storage container create --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "RECOVERABLE_DATA" > recovery10.txt

run_cmd "az storage blob upload --container-name $CONTAINER --name data.txt --file recovery10.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage blob delete --container-name $CONTAINER --name data.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage blob upload --container-name $CONTAINER --name data.txt --file recovery10.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Tests deletion followed by restoration." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #11
# QUEUE DELETION
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #11 - QUEUE DELETION"
echo "========================================"

QUEUE="chaos11queue"

run_cmd "az storage queue create --name $QUEUE --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage queue delete --name $QUEUE --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Producers and consumers lose queue dependency." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #12
# WRONG QUEUE
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #12 - WRONG QUEUE NAME"
echo "========================================"

run_cmd "az storage message get --queue-name wrong-queue-999 --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Consumer cannot locate required queue." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #13
# EMPTY QUEUE
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #13 - EMPTY QUEUE"
echo "========================================"

QUEUE="chaos13queue"

run_cmd "az storage queue create --name $QUEUE --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage message get --queue-name $QUEUE --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Consumer has no work to process." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #14
# MESSAGE DELETION
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #14 - MESSAGE REMOVAL"
echo "========================================"

QUEUE="chaos14queue"

run_cmd "az storage queue create --name $QUEUE --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage message put --queue-name $QUEUE --content JOB_TO_PROCESS --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage message clear --queue-name $QUEUE --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Pending work disappears from the queue." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #15
# MULTIPLE MESSAGE LOSS
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #15 - MULTIPLE MESSAGE LOSS"
echo "========================================"

QUEUE="chaos15queue"

run_cmd "az storage queue create --name $QUEUE --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage message put --queue-name $QUEUE --content JOB1 --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""
run_cmd "az storage message put --queue-name $QUEUE --content JOB2 --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""
run_cmd "az storage message put --queue-name $QUEUE --content JOB3 --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage message clear --queue-name $QUEUE --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Multiple pending jobs are removed." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #16
# TABLE DELETION
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #16 - TABLE DELETION"
echo "========================================"

TABLE="chaos16table"

run_cmd "az storage table create --name $TABLE --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

run_cmd "az storage table delete --name $TABLE --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Structured application data becomes unavailable." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #17
# WRONG TABLE
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #17 - WRONG TABLE NAME"
echo "========================================"

run_cmd "az storage entity query --table-name wrongtable999 --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Application cannot locate its data table." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #18
# ENTITY MISSING
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #18 - MISSING ENTITY"
echo "========================================"

echo "SIMULATION: Application requests a record that does not exist." | tee -a "$LOG_FILE"

echo "IMPACT: Specific application data is unavailable." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #19
# ENTITY DATA CORRUPTION
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #19 - DATA OVERWRITE"
echo "========================================"

echo "SIMULATION: Existing structured data is replaced with incorrect values." | tee -a "$LOG_FILE"

echo "IMPACT: Resource exists but contains incorrect data." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #20
# MISSING DATA LOOKUP
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #20 - DATA LOOKUP FAILURE"
echo "========================================"

echo "SIMULATION: Application queries a non-existing record." | tee -a "$LOG_FILE"

echo "IMPACT: Lookup returns no expected data." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #21
# INVALID CONNECTION CONFIGURATION
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #21 - INVALID CONNECTION"
echo "========================================"

OLD_CONNECTION="$AZURE_STORAGE_CONNECTION_STRING"

export AZURE_STORAGE_CONNECTION_STRING="INVALID_CONNECTION_STRING"

echo "SIMULATION: Application receives invalid storage configuration." | tee -a "$LOG_FILE"

export AZURE_STORAGE_CONNECTION_STRING="$OLD_CONNECTION"

echo "RECOVERY: Correct connection configuration restored." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #22
# WRONG RESOURCE PATH
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #22 - WRONG RESOURCE PATH"
echo "========================================"

echo "SIMULATION: Application uses incorrect resource location." | tee -a "$LOG_FILE"

echo "IMPACT: Client cannot find expected cloud resource." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #23
# DEPENDENCY FAILURE
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #23 - DEPENDENCY FAILURE"
echo "========================================"

echo "SIMULATION: Required cloud dependency is unavailable." | tee -a "$LOG_FILE"

echo "INTERNAL EFFECT: Application request reaches dependency layer and fails." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #24
# WRONG CONFIGURATION DATA
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #24 - WRONG CONFIGURATION DATA"
echo "========================================"

CONTAINER="chaos24container"

run_cmd "az storage container create --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "ENVIRONMENT=PRODUCTION_BUT_WRONG" > wrongconfig24.txt

run_cmd "az storage blob upload --overwrite true --container-name $CONTAINER --name app-config.txt --file wrongconfig24.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "IMPACT: Application retrieves valid resource with invalid content." | tee -a "$LOG_FILE"

############################################
# AZURE CHAOS #25
# FAILURE + RECOVERY
############################################

echo ""
echo "========================================"
echo "AZURE CHAOS #25 - FULL FAILURE AND RECOVERY"
echo "========================================"

CONTAINER="chaos25container"

run_cmd "az storage container create --name $CONTAINER --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo "CRITICAL_APPLICATION_DATA" > critical25.txt

run_cmd "az storage blob upload --container-name $CONTAINER --name critical.txt --file critical25.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo ""
echo "CHAOS: Deleting critical resource..." | tee -a "$LOG_FILE"

run_cmd "az storage blob delete --container-name $CONTAINER --name critical.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo ""
echo "IMPACT: Critical application dependency is missing." | tee -a "$LOG_FILE"

echo ""
echo "RECOVERY: Restoring critical resource..." | tee -a "$LOG_FILE"

run_cmd "az storage blob upload --container-name $CONTAINER --name critical.txt --file critical25.txt --connection-string \"$AZURE_STORAGE_CONNECTION_STRING\""

echo ""
echo "========================================"
echo "ALL AZURE CHAOS EXPERIMENTS COMPLETED"
echo "========================================"

echo "Results saved in:"
echo "$LOG_FILE"
