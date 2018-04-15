# The main entry point of your workflow.
# After configuring, running snakemake -n in a clone of this repository should successfully execute a dry-run of the workflow.
import pandas as pd

configfile: "config.yaml"

samples = pd.read_table(config["samples"], index_col="sample")

rule all:
	input:
		

include: "rules/hisat2.smk"
include: "rules/trim.smk"
include: "rules/formats.smk"
include: "rules/deseq2.smk"
