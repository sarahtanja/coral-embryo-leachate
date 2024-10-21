---
editor_options: 
  markdown: 
    wrap: 72
---

# Step 3: QAQC RNA sequences

Sarah Tanja October 10, 2024

-   [Goals](#goals)
-   [Setup conda environment](#setup-conda-environment)
-   [Run `FastQC`](#run-fastqc)
-   [Compile the `MultiQC` report](#compile-the-multiqc-report)
-   [Interpretation of `MultiQC`
    report](#interpretation-of-multiqc-report)
-   [Clean reads with `fastp`](#clean-reads-with-fastp)
-   [Summary](#summary)

# Goals {#goals}

In this script, we will generate FastQC/MultiQC for raw sequences,
conduct trimming and cleaning, then generate reports for cleaned
sequences.

# Setup conda environment {#setup-conda-environment}

Create and activate conda environment (must already have installed
miniconda)

> [!CAUTION]
>
> Execute the following conda commands in the terminal so that you can
> respond to `Proceed([y]/n)?` with a `y`

``` bash
conda create -n mcap2024
conda activate mcap2024
```

Install programs within conda environment

-   [fastqc](https://anaconda.org/bioconda/fastqc)

``` bash
conda install bioconda::fastqc
```

*FastQC generates sequence quality information of your reads*

-   [multiqc](https://anaconda.org/bioconda/multiqc), [git developer
    version](Installation)

``` bash
pip install --upgrade --force-reinstall git+https://github.com/MultiQC/MultiQC.git
```

*Multiqc summarizes FastQC analysis logs and summarizes results in an
html report*

-   [fastp](https://anaconda.org/bioconda/fastp)

``` bash
conda install bioconda::fastp
```

*FastP provides fast all-in-one preprocessing for FastQ files*

conda install hisat2 conda install samtools

# Run `FastQC` {#run-fastqc}

``` bash
cd rawfastq/00_fastq
fastqc ./*.fastq.gz
```

Make a subdirectory for your FastQC results and move FastQC results
there

``` bash
cd ../output
mkdir 03_qaqc
mv ../../rawfastq/00_fastq/*fastqc* ./
```

# Compile the `MultiQC` report {#compile-the-multiqc-report}

``` bash
cd ../output/03_qaqc
multiqc ./
```

# Interpretation of `MultiQC` report {#interpretation-of-multiqc-report}

Watch a quick [6-min
tutorial](https://www.youtube.com/watch?v=qPbIlO_KWN0) on how to
navigate in the MultiQC Report

# Clean reads with `fastp` {#clean-reads-with-fastp}

-   remove adapters
-   remove low-quality reads
-   remove reads with high number of unknown bases

In this script, we are trimming and cleaning with the following
settings:

-   remove adapter sequences
    `--adapter_sequence=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA`
-   enable polyX trimming on 3' end at length of 6 `--trim_poly_x 6`
-   filter by minimum phred quality score of \>30 `-q 30`
-   enable low complexity filter `-y`
-   set complexity filter threshold of 50% required `-Y 50`

Make a subdirectory for cleaned reads within the data directory.

``` bash
cd ../data
mkdir cleaned_reads
```

`fastp` all
[options](https://github.com/OpenGene/fastp?tab=readme-ov-file#:~:text=of%201%20~%206.-,all%20options,-usage%3A%20fastp%20%2Di)
can be found in the git README.

-   --in1 - Path to forward read input
-   --in2 - Path to reverse read input
-   --out1 - Path to forward read output
-   --out2 - Path to reservse read output
-   --failed_out - Specify file to store reads that fail filters
-   --qualified_quality_phred - Phred quality \>= -q is qualified (20)
-   --unqualified_percent_limit - % of bases allowed to be unqualified
    (10) 
-   --length_required - Set required sequence length (100)
-   --detect_adapter_for_pe - Adapters can be trimmed by overlap
    analysis, however, --detect_adapter_for_pe will usually result in
    slightly cleaner output than overlap detection alone. This results
    in a slightly slower run time
-   --cut_right - Move a sliding window from front to tail. Use
    cut_right_window_size to set the window size (5), and
    cut_right_mean_quality (20) to set the mean quality threshold.
-   --html - The html format report file name

``` bash

fastp 
--in1 ${file}_R1_001.fastq.gz 
--in2 ${file}_R2_001.fastq.gz 
--out1 ../cleaned_reads/${file}_R1_001.clean.fastq.gz 
--out2 ../cleaned_reads/${file}_R2_001.clean.fastq.gz 
--failed_out ../cleaned_reads/${file}_failed.txt 
--detect_adapter_for_pe
--trim_poly_x 6
-q 30
-y 
-Y
--qualified_quality_phred 20 
--unqualified_percent_limit 10 
--length_required 100 detect_adapter_for_pe 
--cut_right cut_right_window_size 5
--cut_right_mean_quality 20
```

# Summary {#summary}

Clean sequences are now ready for alignment.
