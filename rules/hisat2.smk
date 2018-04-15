references = pd.read_table(config["references"], index_col="reference")

rule hisat_index:
	input:
		expand(config[data_folder] + "/{dataset}", dataset=list(references.index))
	output:
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".1.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".2.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".3.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".4.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".5.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".6.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".7.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".8.ht21"
	conda: "../envs/hisat-deseq.yaml"
	params:
		index = config["hisat"]["index_prefix"]
	shell:
		"hisat2-build -f --large-index {input} {params.index}"

rule hisat_map:
	input:	
		config["trim_folder"] + "/{sample}_1_val_1.fq.gz",
		config["trim_folder"] + "/{sample}_2_val_2.fq.gz",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".1.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".2.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".3.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".4.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".5.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".6.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".7.ht21",
		config["data_folder"] + "/" + config["hisat"]["index_prefix"] + ".8.ht21"
	output:
		config["folders"]["output_folder"] + "/{sample}.sam"
	conda: "../envs/hisat-deseq.yaml"		
	params:
		set_index_folder = config["hisat"]["set_index_folder"],
		index = config["hisat"]["index_prefix"]
	shell:
		"{params.set_index_folder} & hisat2 -q -x {params.index} -1 {input[0]} -2 {input[1]} -S {output[0]}"
