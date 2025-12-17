params.fastq_dir = null
params.outdir    = "results"
params.help      = false

if (params.help || !params.fastq_dir) {
    println '''
    Usage:
        nextflow run main.nf --fastq_dir path/to/fastqs --outdir results/

    Expected FASTQ filenames:
        sample_R1.fastq.gz
        sample_R2.fastq.gz

    Options:
        --fastq_dir   Directory containing paired-end FASTQs
        --outdir      Output directory (default: results)
        --help        Show this help message
    '''.stripIndent()
    exit 0
}

include { FastqPreprocessing } from './modules/fastq_preprocessing.nf'

workflow {
    // Preprocess FASTQ files
    Channel
        .fromFilePairs("${params.fastq_dir}/*_{1,2}.fastq.gz")
        .set { fastq_ch }
    trimmed_ch = fastq_ch | FastqPreprocessing
}
