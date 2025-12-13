process FastqPreprocessing {
    tag "$sample_id"
    publishDir "${params.outdir}/qc/", mode: 'move', pattern: "*.json"
    publishDir "${params.outdir}/trimmed_fastqs/", mode: 'move', pattern: "*_trimmed.fastq.gz"

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("*_trimmed.fastq.gz"), emit: trimmed_reads
    path("*.html"), emit: html_report
    path("*.json"), emit: json_report

    script:
    """
    fastp \
    -i ${reads[0]} \
    -I ${reads[1]} \
    -o ${sample_id}_R1_trimmed.fastq.gz \
    -O ${sample_id}_R2_trimmed.fastq.gz \
    --disable_quality_filtering \
    --disable_length_filtering \
    --disable_trim_poly_g \
    -n 50 \
    --html ${sample_id}_fastp_report.html \
    --json ${sample_id}_fastp_report.json \
    --thread ${task.cpus}
    """
}
