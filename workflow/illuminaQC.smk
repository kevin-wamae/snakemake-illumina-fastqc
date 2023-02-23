# A Snakemake pipeline for quality control and trimming of next-generation
#              sequencing data from Illumina sequences
# *********************************************************************


# dependencies
# *********************************************************************
# configuration file
configfile: "workflow/config.yaml"


# global wild cards of sample and pairpair list
(SAMPLES,) = glob_wildcards(config["input"]["fastq"] + "{sample}_R1.fastq.gz")


# test if samples can be found, uncomment for testing
# print(SAMPLES)


# all output out
# *********************************************************************
rule all:
    input:
        # ------------------------------------
        # fastqc
        expand(config["fastqc"]["dir"] + "{sample}_R1_fastqc.html", sample=SAMPLES),
        expand(config["fastqc"]["dir"] + "{sample}_R2_fastqc.html", sample=SAMPLES),
        expand(config["fastqc"]["dir"] + "{sample}_R1_fastqc.html", sample=SAMPLES),
        expand(config["fastqc"]["dir"] + "{sample}_R2_fastqc.html", sample=SAMPLES),
        expand(config["fastqc"]["dir"] + "{sample}_R1_fastqc.zip", sample=SAMPLES),
        expand(config["fastqc"]["dir"] + "{sample}_R2_fastqc.zip", sample=SAMPLES),
        # ------------------------------------
        # multiqc
        config["multiqc"]["dir"],


# fastqc - check quality of raw fastq-files and merge fastqc reports
# *********************************************************************


rule fastqc:
    input:
        r1=config["input"]["fastq"] + "{sample}_R1.fastq.gz",
        r2=config["input"]["fastq"] + "{sample}_R2.fastq.gz",
    output:
        r1_html=config["fastqc"]["dir"] + "{sample}_R1_fastqc.html",
        r2_html=config["fastqc"]["dir"] + "{sample}_R2_fastqc.html",
        r1_zip=config["fastqc"]["dir"] + "{sample}_R1_fastqc.zip",
        r2_zip=config["fastqc"]["dir"] + "{sample}_R2_fastqc.zip",
    params:
        threads=config["extra"]["threads"],
        dir=directory(config["fastqc"]["dir"]),
    shell:
        """
        fastqc {input.r1} {input.r2} \
            --threads {params.threads} \
            --format fastq \
            --quiet \
            --outdir {params.dir}
        """


# multiqc - merge fastqc reports
# *********************************************************************
rule multiqc:
    input:
        config["fastqc"]["dir"],
    output:
        directory(config["multiqc"]["dir"]),
    run:
        shell(
            """
            multiqc \
                --force {input} \
                --outdir {output}
            """
        )
