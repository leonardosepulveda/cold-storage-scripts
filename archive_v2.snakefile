inputList = config['inputNames']
outputList = config['outputNames']

rule all:
    #wildcard_constraints:
    #    datasetName = '|'.join(datasetNamesList)
    input: expand('{outputList}.tar.zst', outputList=outputList)

rule archiveDirectory:
    wildcard_constraints:
        datasetName = '|'.join(datasetNamesList)

    input: srcPath + '{datasetName}/'
    output: destPath + '{datasetName}.tar.zst'
    message: 'Archiving and compressing {wildcards.datasetName}'
    shell: 'time tar -cf - ' + srcPath+'{wildcards.datasetName}/ | zstd -1 -T6 - > ' + destPath+'{wildcards.datasetName}.tar.zst'
 