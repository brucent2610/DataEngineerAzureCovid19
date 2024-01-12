AzureStorageLinkedService=ls_ablob_covidreportingsa
AzureDataFactorySourceDataSet=ds_population_raw_gz

AzureDataLakeStorageGen2LinkedService=ls_adls_covidreportingdl
AzureDataFactorySinkDataSet=ds_population_raw_tsv

AzureDataFactoryPipeline=pl_ingest_population_data
AzureDataFactoryTrigger=tr_ingest_population_data

az datafactory linked-service create --resource-group $RESOURCE_GROUP --factory-name $FACTORY_NAME --linked-service-name $AzureStorageLinkedService --properties @LinkedService/AzureStorageLinkedService.json
az datafactory linked-service create --resource-group $RESOURCE_GROUP --factory-name $FACTORY_NAME --linked-service-name $AzureDataLakeStorageGen2LinkedService --properties @LinkedService/AzureDataLakeGen2LinkedService.json

az datafactory dataset create --resource-group $RESOURCE_GROUP --dataset-name $AzureDataFactorySourceDataSet --factory-name $FACTORY_NAME --properties @DataSet/AzureDataFactorySourceDataSet.json
az datafactory dataset create --resource-group $RESOURCE_GROUP --dataset-name $AzureDataFactorySinkDataSet --factory-name $FACTORY_NAME --properties @DataSet/AzureDataFactorySinkDataSet.json

az datafactory pipeline create --resource-group $RESOURCE_GROUP --factory-name $FACTORY_NAME --name $AzureDataFactoryPipeline --pipeline @Pipeline/AzureDataFactoryCopyPipeline.json
az datafactory trigger create --resource-group $RESOURCE_GROUP --factory-name $FACTORY_NAME --name $AzureDataFactoryTrigger --properties @Pipeline/AzureDataFactoryTriggerEvent.json