# Snakemake workflow: FastQC and MultiQC of Next-generation Sequencing Data

## Motivation


This is a Snakemake pipeline for quality control of Illumina next-generation sequencing data. It performs quality check using FastQC on raw fastq-files and merges fastqc reports using MultiQC.

## Prerequisites
- [Conda](https://docs.conda.io/en/latest/) is a package, dependency and environment management system that is used to install software packages and manage their dependencies. It runs on Linux, OS X and Windows, and was created for Python programs but it can package and distribute software for any language. install conda for your operating system: [Linux](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html), [MacOS](https://docs.conda.io/projects/conda/en/latest/user-guide/install/macos.html).
- [Snakemake](https://snakemake.readthedocs.io/en/stable/) is a workflow management system that allows to create reproducible and scalable data analyses.

- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) is a quality control tool for high throughput sequence data.

- [MultiQC](https://multiqc.info/) is a tool to aggregate bioinformatics results across many samples into a single report.
Configuration
The configuration file is located in config/config.yaml. This file contains paths to input files and directories, output directories, and other settings.

## Usage
1.  **Clone the repository:**
```
git clone https://github.com/kevin-wamae/fastQC-multiQC-pipeline.git
```

2. **Navigate into the cloned directory using the following command:**
```
cd FastQC-MultiQC-pipeline
```

3. **Create a conda environment (named `fastqc-multiqc-pipeline`) for the pipeline:**
```
conda env create --file workflow/envs/environment.yaml
```

1. **Activate the conda environment.** This needs to be done every time you exit and restart your terminal and want re-run this pipeline:

```
conda activate fastqc-multiqc-pipeline
```

1. **Run the pipeline with Snakemake:**
```
snakemake --cores <number_of_cores> --use-conda
```

- _The `--cores` option specifies the number of cores to use, and the `--use-conda` option tells Snakemake to use the specified conda environments._

6. **Finally, the config file is located in `config/config.yaml`.**
   - This file contains paths to input files and directories, output directories, and other settings such as the number of cores to use.
   - You can edit this file to suit your needs.
   - For example, you can change the number of cores to use by editing the `extra:threads:` parameter

## Output
- The pipeline generates HTML reports for each sample in the fastqc directory and a merged HTML report in the multiqc directory.

## Dependencies
- This pipeline uses conda environments to manage dependencies for each rule. The environments are defined in envs/fastqc.yaml and envs/multiqc.yaml.

## Contact
- **Report any issues or bugs by openning an issue [here](https://github.com/kevin-wamae/FastQC-MultiQC-pipeline/issues) or contact me via email (wamaekevin[at]gmail.com)**
