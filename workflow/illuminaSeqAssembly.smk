# A Snakemake pipeline for quality control and trimming of next-generation
#              sequencing data from Illumina sequences
# *********************************************************************



# dependencies
# *********************************************************************
# configuration file
configfile: "workflow/config.yaml"


# global wild cards of sample and pairpair list
(SAMPLES, PAIR) = glob_wildcards(config["input"]["fastq"] + "{sample}_{pair}.fastq.gz")


# all output out
# *********************************************************************
rule all:
    input:
        # ------------------------------------
        # fastqc
        expand(
            config["fastqc"]["dir"] + "{sample}_{pair}_fastqc.html",
            sample=SAMPLES,
            pair=PAIR,
        ),
        expand(
            config["fastqc"]["dir"] + "{sample}_{pair}_fastqc.zip",
            sample=SAMPLES,
            pair=PAIR,
        ),
        config["fastqc"]["dir"],
        # ------------------------------------
        # multiqc
        config["multiqc"]["dir"],



# fastqc - check quality of raw fastq-files and merge fastqc reports
# *********************************************************************


rule fastqc:
    input:
        fastq=expand(
            config["input"]["fastq"] + "{sample}_{pair}.fastq.gz",
            sample=SAMPLES,
            pair=PAIR,
        ),
    output:
        html=expand(
            config["fastqc"]["dir"] + "{sample}_{pair}_fastqc.html",
            sample=SAMPLES,
            pair=PAIR,
        ),
        zip=expand(
            config["fastqc"]["dir"] + "{sample}_{pair}_fastqc.zip",
            sample=SAMPLES,
            pair=PAIR,
        ),
        fastqc_dir=directory(config["fastqc"]["dir"]),
    params:
        threads=config["extra"]["threads"],
    run:
        shell(
            """
            fastqc {input.fastq} --threads {params.threads} --format fastq --quiet --outdir {output.fastqc_dir}
            """
        )



# multiqc - merge fastqc reports
# *********************************************************************


rule multiqc:
    input:
        rules.fastqc.output.fastqc_dir,
    output:
        directory(config["multiqc"]["dir"]),
    run:
        shell(
            """
            multiqc --force {input} --outdir {output}
            """
        )
