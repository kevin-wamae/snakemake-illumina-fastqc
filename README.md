# Illumina NGS Quality Control and Trimming Pipeline using Snakemake
### Motivation


This pipeline includes two rules:
- `fastqc` for checking the quality of raw fastq files and merging the fastqc reports, and
- `multiqc` for merging the fastqc reports.
  
The pipeline uses a configuration file `config.yaml` that specifies the location of:
- input files
- output directories, and
- parameters such as the number of threads to use.

The pipeline also uses `global wildcards` to match the sample names and pair names in the input fastq files.

The output files of the pipeline include fastqc reports in both HTML and ZIP format, as well as a multiqc report.

---

### Below are the project dependencies:

#### &nbsp;&nbsp;&nbsp;&nbsp; Package management
- [conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html) - an open-source package management system and environment management system that runs on various platforms, including Windows, MacOS, Linux.

#### &nbsp;&nbsp;&nbsp;&nbsp; Workflow management
- [snakemake](https://anaconda.org/bioconda/snakemake) - a workflow management system that aims to reduce the complexity of creating workflows by providing a fast and comfortable execution environment, together with a clean and modern specification language in python style.


#### &nbsp;&nbsp;&nbsp;&nbsp; Bioinformatics tools (packages)
- [fastqc](https://anaconda.org/bioconda/fastqc) - a tool for a quality control tool for high throughput sequence data
- [multiqc](https://anaconda.org/bioconda/multiqc) - a tool for aggregating bioinformatics analysis reports across many samples and tools


---

### Where to start
- Clone this project into your computer using Git ([_installation instructions_](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)) with the following command:
  - `git clone https://github.com/kevin-wamae/ampSeq-short-read-ONT.git`
- Navigate into the cloned directory using the following command:
  - `cd ampSeq-short-read-ONT`
 
 ---

### Directory structure
- Below is the default directory structure:
    - **env/**   - contains the Conda environment files
    - **input/** - contains fastq files
      - **_NB_**: There are two fastq files here for testing, but you can add your own
    - **output/** - contains the output from the analysis
    - **workflow/** - contains the Snakemake script (snakefile) and the workflow configuration file
```
.
|-- LICENSE
|-- README.md
|-- env
|   `-- environment.yml
|-- input
|   `-- fastq
|       |-- file1_R1.fastq.gz
|       `-- file2_R1.fastq.gz
|-- output
`-- workflow
    |-- config.yaml
    `-- illuminaSeqAssembly.smk
```

---

### Running the analysis
Install [conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html) and execute the following commands:

1 - Create the conda analysis environment and install the dependencies from the ***env/environment.yml*** by running the following command in your terminal:
  - `conda env create --file env/environment.yml`
  
2 - Activate the conda environment:
  - _**Note** - This needs to be done every time you want to execute this pipeline_:
  - `conda activate illumina-trim-wizard`


3 - Finally, execute the whole `Snakemake` pipeline by running the following command in your terminal:
  - _**Note** - Replace **4** in the command with the number of CPUs you wish to use_
  - `snakemake -s workflow/illuminaSeqAssembly.smk -c4`

  
  ---
  
  ### Expected output
  Below is the expected directory structure of the **output/** directory:
  - **fastqc/** - contains the fastqc QC reports from the raw fastq files (html and zip files)
  - **multiqc** - contains the aggregated fastqc QC reports (the html files is what you want to look at)
```
output
|-- fastqc
|   |-- file1_R1_fastqc.html
|   |-- file1_R1_fastqc.zip
|   |-- file2_R1_fastqc.html
|   `-- file2_R1_fastqc.zip
`-- multiqc
    |-- multiqc_data
    |   |-- multiqc.log
    |   |-- multiqc_citations.txt
    |   |-- multiqc_data.json
    |   |-- multiqc_fastqc.txt
    |   |-- multiqc_general_stats.txt
    |   `-- multiqc_sources.txt
    `-- multiqc_report.html
```
