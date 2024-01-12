# Setup Environment
RESOURCE_GROUP=covid-report-rg
LOCATION=eastus
FACTORY_NAME=phongnt-covid-report-adf
STORAGE_ACCOUNT_NAME=phongntcovidreportsa
STORAGE_ACCOUNT_SKU=Standard_LRS
STORAGE_ACCOUNT_KIND=StorageV2
DATALAKE_STORAGE_GEN2_NAME=phongntcovidreportdlsg2
DATALAKE_STORAGE_GEN2_SKU=Standard_LRS
DATALAKE_STORAGE_GEN2_KIND=StorageV2
DATABASE_SQL_SERVER_NAME=phongntcovidsqlsrv
DATABASE_SQL_SERVER_ADMIN_USER=phongnt
DATABASE_SQL_SERVER_ADMIN_PASSWORD=SxfzG5jsnemCJc2ZbL7EQp
DATABASE_SQL_NAME=phongntcovidsqldb
DATABASE_SQL_EDITION=Basic
DATABASE_SQL_CAPACITY=5
DATABASE_SQL_STORAGE_REDUNDANCY=Local

az group create --name $RESOURCE_GROUP --location $LOCATION
az datafactory create --resource-group $RESOURCE_GROUP --factory-name $FACTORY_NAME
az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --sku $STORAGE_ACCOUNT_SKU --kind $STORAGE_ACCOUNT_KIND
az storage account create --name $DATALAKE_STORAGE_GEN2_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --sku $DATALAKE_STORAGE_GEN2_SKU --kind $DATALAKE_STORAGE_GEN2_KIND --hns

az sql server create --name $DATABASE_SQL_SERVER_NAME --resource-group $RESOURCE_GROUP --location $LOCATION --admin-user $DATABASE_SQL_SERVER_ADMIN_USER --admin-password $DATABASE_SQL_SERVER_ADMIN_PASSWORD
az sql db create --resource-group $RESOURCE_GROUP --server $DATABASE_SQL_SERVER_NAME --name $DATABASE_SQL_NAME --edition $DATABASE_SQL_EDITION --max-size 2GB --capacity $DATABASE_SQL_CAPACITY --compute-model Provisioned --backup-storage-redundancy $DATABASE_SQL_STORAGE_REDUNDANCY


# Data Ingestion from Azure Blob
STORAGE_ACCOUNT_CONTAINER_NAME=population
SOURCE_FILE_NAME=population_by_age.tsv.gz

DATALAKE_STORAGE_GEN2_CONTAINER_NAME=raw

az storage container create --account-name $STORAGE_ACCOUNT_NAME --name $STORAGE_ACCOUNT_CONTAINER_NAME --auth-mode login
az storage blob upload --account-name $STORAGE_ACCOUNT_NAME --container-name $STORAGE_ACCOUNT_CONTAINER_NAME --name $SOURCE_FILE_NAME --file $SOURCE_FILE_NAME --auth-mode login

az storage container create --account-name $DATALAKE_STORAGE_GEN2_NAME --name $DATALAKE_STORAGE_GEN2_CONTAINER_NAME --auth-mode login