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

az datafactory trigger create --resource-group $RESOURCE_GROUP --factory-name $FACTORY_NAME --name $AzureDataFactoryTrigger --properties @Pipeline/AzureDataFactoryTriggerEvent.json
az datafactory pipeline create --resource-group $RESOURCE_GROUP --factory-name $FACTORY_NAME --name $AzureDataFactoryPipeline --pipeline @Pipeline/AzureDataFactoryCopyPipeline.json


AzureStorageLinkedServiceOpenData=ls_http_opendata_ecdc_europa_eu
AzureDataFactorySourceDataSetOpenData=ds_cases_deaths_raw_csv_http
AzureDataFactoryConfigDataSet=ds_ecdc_file_list

AzureDataFactorySinkDataSetOpenData=ds_cases_deaths_raw_csv_dl

AzureDataFactoryOpenDataPipeline=pl_ingest_ecdc_data
AzureDataFactoryOpenDataTrigger=tr_ingest_ecdc_data

az datafactory linked-service create --resource-group $RESOURCE_GROUP --factory-name $FACTORY_NAME --linked-service-name $AzureStorageLinkedServiceOpenData --properties @LinkedService/AzureStorageLinkedServiceOpenData.json

az datafactory dataset create --resource-group $RESOURCE_GROUP --dataset-name $AzureDataFactoryConfigDataSet --factory-name $FACTORY_NAME --properties @DataSet/AzureDataFactoryConfigDataSetOpenData.json
az datafactory dataset create --resource-group $RESOURCE_GROUP --dataset-name $AzureDataFactorySourceDataSet --factory-name $FACTORY_NAME --properties @DataSet/AzureDataFactorySourceDataSetOpenData.json
az datafactory dataset create --resource-group $RESOURCE_GROUP --dataset-name $AzureDataFactorySinkDataSetOpenData --factory-name $FACTORY_NAME --properties @DataSet/AzureDataFactorySinkDataSetOpenData.json

az datafactory trigger create --resource-group $RESOURCE_GROUP --factory-name $FACTORY_NAME --name $AzureDataFactoryOpenDataTrigger --properties @Pipeline/AzureDataFactoryOpenDataTriggerEvent.json
az datafactory pipeline create --resource-group $RESOURCE_GROUP --factory-name $FACTORY_NAME --name $AzureDataFactoryOpenDataPipeline --pipeline @Pipeline/AzureDataFactoryCopyPipelineOpenData.json