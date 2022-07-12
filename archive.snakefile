#location of source data to be archived and compressed
srcPath = config['Paths']['srcPath']

#destination of output (compressed) .tar.zst files
destPath = config['Paths']['destPath']

datasetNamesList = config['datasetNames']

rule all:
    #wildcard_constraints:
    #    datasetName = '|'.join(datasetNamesList)
    input: expand(destPath + '{datasetName}.tar.zst', datasetName=datasetNamesList)

rule archiveDirectory:
    wildcard_constraints:
        datasetName = '|'.join(datasetNamesList)

    input: srcPath + '{datasetName}/'
    output: destPath + '{datasetName}.tar.zst'
    message: 'Archiving and compressing {wildcards.datasetName}'
    shell: 'time tar -cf - ' + srcPath+'{wildcards.datasetName}/ | zstd -1 -T6 - > ' + destPath+'{wildcards.datasetName}.tar.zst'
 